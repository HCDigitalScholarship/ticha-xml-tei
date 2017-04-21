"""Convert TEI-encoded XML into human-readable HTML.

   <TEI>
     <teiHeader>...</teiHeader>
     <text>
       <front>...</front>
       <body>...</body>
       <back>...</back>
     </text>
   </TEI>

What kind of transformations need to be done?
- The contents of the <front>, <body> and <back> elements need to be extracted
  and concatenated.
- Choosing from the children of a <choice> element
- Changing names of tags
    <lb>   -> <br>
    <head> -> <h4>

- Paginating the document and properly opening/closing elements that span page
  breaks
- Preserving <div> tags
"""
import sys
import os.path
import xml.etree.ElementTree as ET
import io

HEADER_TAGS = ('TEI', 'teiHeader', 'fileDesc', 'titleStmt', 'title',
    'publicationStmt', 'profileDesc', 'encodingDesc', 'sourceDesc',
    'langUsage', 'language', 'projectDesc', 'editorialDecl', 'correction',
    'normalization', 'hyphenation', 'segmentation', 'interpretation',
    'refsDecl', 'cRefPattern', 'charDecl', 'glyph', 'glyphName', 'figure',
    'graphic', 'add', 'c', 'del', 'ptr', 'ref', 'g'
)

SPELLCHOICES = ('orig', 'reg')
ABBRCHOICES = ('abbr', 'expan')

class TEItoHTMLTarget:
    def __init__(self, spellchoice='orig', abbrchoice='abbr'):
        # choice of original (<orig>) or regularized (<reg>) spelling
        self.spellchoice = spellchoice
        # choice of abbreviation (<abbr>) or expansion (<expan>)
        self.abbrchoice = abbrchoice
        # the stack of open tags (each tag is stored as a name-attrib pair)
        self.tags = []
        self.trb = ET.TreeBuilder()
        self.waiting_for = []
        self.lines = 0
        self.this_col_lines = 0
        self.max_col_lines = 0
        self.in_column = False
        self.in_header = True
        self.trb.start('div')

    def start(self, tag, attrib):
        if self.waiting_for:
            return
        if self.in_header:
            if tag not in HEADER_TAGS:
                self.in_header = False
                #self.open_tag('div', {'class':'col-xs-10'})
                self.open_tag('div', {'class':'printed_text_page'})
            else:
                return
        # dispatch to the proper tag_ function
        try:
            x = getattr(self, 'tag_' + tag)
            x(attrib)
        except AttributeError:
            pass
        # handle choice tags
        if tag in SPELLCHOICES and tag != self.spellchoice:
            self.waiting_for.append(tag)
        elif tag in ABBRCHOICES and tag != self.abbrchoice:
            self.waiting_for.append(tag)

    def tag_lb(self, attrib):
        if self.in_column:
            self.this_col_lines += 1
        else:
            self.lines += 1
        self.open_and_close_tag('br')

    def tag_head(self, attrib):
        self.open_tag('h4')

    def tag_hi(self, attrib):
        if attrib.get('rend') == 'italic':
            self.open_tag('span', {'class':'italic'})
        else:
            self.open_tag('span')

    def tag_foreign(self, attrib):
        # note that it is rend="italics", with an 's'
        if attrib.get('rend') == 'italics':
            self.open_tag('span', {'class':'italic'})
        else:
            self.open_tag('span')

    def tag_fw(self, attrib):
        if attrib.get('type') == 'catch' or attrib.get('type') == 'catchword':
            self.open_tag('div', {'class':'catch'})
        elif attrib.get('type') == 'sig':
            self.open_tag('div', {'class':'sig'})
        else:
            self.open_tag('div')

    def tag_pb(self, attrib):
        if attrib.get('type') != 'pdf':
            self.new_page()

    def tag_div(self, attrib):
        if attrib.get('rend') == 'center':
            self.open_tag('div', {'class':'center'})
        else:
            self.open_tag('div')

    def tag_p(self, attrib):
        if attrib.get('rend') == 'center':
            self.open_tag('p', {'class':'center'})
        else:
            self.open_tag('p')



    def tag_cb(self, attrib):
        self.in_column = True
        n_val = attrib.get('n')
        if n_val == '1':
            # value of '1' indicates start of column section
            self.open_tag('div')
            self.open_tag('div', {'class':'col-xs-6'})
        elif n_val == '':
            # empty value indicates end of column section
            self.in_column = False
            self.lines += self.max_col_lines
            self.max_col_lines = 0
            self.close_tag('div')
            self.close_tag('div')
        else:
            self.max_col_lines = max(self.max_col_lines, 
                                     self.this_col_lines)
            self.this_col_lines = 0
            self.close_tag('div')
            self.open_tag('div', {'class':'col-xs-6'})

    def end(self, tag):
        if self.waiting_for and tag == self.waiting_for[-1]:
            self.waiting_for.pop()
        if tag == 'head':
            self.close_tag('h4')
        elif tag == 'hi':
            self.close_tag('span')
        elif tag == 'fw':
            self.close_tag('div')
        elif tag == 'div':
            self.close_tag('div')
        elif tag == 'p':
            self.close_tag('p')
        elif tag == 'foreign':
            self.close_tag('span')

    def data(self, data):
        if not self.waiting_for and not self.in_header:
            self.trb.data(data)

    def open_tag(self, name, attribs={}):
        self.tags.append((name, attribs))
        self.trb.start(name, attribs)

    def open_and_close_tag(self, name, attribs={}):
        self.trb.start(name, attribs)
        self.trb.end(name)

    def close_tag(self, name):
        if len(self.tags) > 0:
            if self.tags[-1][0] == name:
                self.tags.pop()
                self.trb.end(name)
            else:
                msg  = 'trying to close <{}>, '.format(name)
                msg += 'but last tag opened was <{}>'.format(self.tags[-1][0])
                raise SyntaxError(msg)
        else:
            raise SyntaxError('got </{0}> before <{0}>'.format(name))

    def new_page(self):
        self.close_all_tags()
        self.lines = 0
        self.reopen_all_tags()

    def close(self):
        self.close_all_tags()
        out = self.trb.close()
        if out is not None:
            self.as_str = ET.tostring(out, encoding='unicode')
        else:
            self.as_str = ''
        self.trb = ET.TreeBuilder()

    def close_all_tags(self):
        # close all open tags
        for tag, _ in reversed(self.tags):
            self.trb.end(tag)

    def reopen_all_tags(self):
        # reopen the closed tags for the next page
        for tag, attribs in self.tags:
            self.trb.start(tag, attribs)

    def __str__(self):
        if not hasattr(self, 'as_str'):
            self.close()
        return self.as_str

def line_number_div(lines):
    line_nos = '\n'.join('{}<br/>'.format(i + 1) for i in range(lines))
    return '<div class="col-xs-2">{}</div>'.format(line_nos)

def xml_to_html_target(data, spellchoice='orig', abbrchoice='abbr'):
    """Converts the XML string to HTMl and returns the TEItoHTMLTarget object
       used to parse. This is useful if you need to get at the individual pages
       of the document.
    """
    target = TEItoHTMLTarget(spellchoice, abbrchoice)
    parser = ET.XMLParser(target=target)
    parser.feed(data)
    parser.close()
    return target

def xml_to_html(data, spellchoice='orig', abbrchoice='abbr'):
    """Converts the XML string to a corresponding HTML string."""
    return str(xml_to_html_target(data, spellchoice, abbrchoice))
