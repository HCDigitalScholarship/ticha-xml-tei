import sys
import os
from lxml import etree, sax

class TEIPager(sax.ElementTreeContentHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.in_text = False
        self.tag_stack = []
        self.page = 0
        self.line = 1

    def startElementNS(self, ns_name, qname, attributes=None):
        if qname == 'text':
            self.in_text = True
            super().startElementNS(ns_name, qname, attributes)
            super().startElementNS((None, 'div'), 'div', {(None, 'class'):'printed_text_page',
                                                          (None, 'n'):str(self.page),})
        elif qname == 'pb':
            self.handlePageBreak()
        elif qname == 'cb':
            n = attributes.get((None, 'n'))
            self.handleColumnBreak(n)
        else:
            if qname == 'lb':
                self.line += 1
            if self.in_text:
                self.tag_stack.append( (ns_name, qname, attributes) )
            super().startElementNS(ns_name, qname, attributes)

    def handlePageBreak(self):
        self.line = 1
        self.page += 1
        self.closeAllTags()
        super().endElementNS((None, 'div'), 'div')
        super().startElementNS((None, 'div'), 'div', {(None, 'class'):'printed_text_page',
                                                      (None, 'n'):str(self.page),})
        self.reopenAllTags()

    def handleColumnBreak(self, n):
        if n == '1':
            # value of '1' indicates start of column section
            self.startElementNS((None, 'div'), 'div')
            self.startElementNS((None, 'div'), 'div', {(None, 'class'):'col-xs-6'})
        elif n == '':
            # empty value indicates end of column section
            self.endElementNS((None, 'div'), 'div')
            self.endElementNS((None, 'div'), 'div')
        else:
            self.endElementNS((None, 'div'), 'div')
            self.startElementNS((None, 'div'), 'div', {(None, 'class'):'col-xs-6'})

    def endElementNS(self, ns_name, qname):
        if qname == 'text':
            self.in_text = False
            super().endElementNS((None, 'div'), 'div')
            super().endElementNS(ns_name, qname)
        elif qname != 'pb' and qname != 'cb':
            if self.in_text:
                self.tag_stack.pop()
            try:
                super().endElementNS(ns_name, qname)
            except sax.SaxError as e:
                print('Error on page {0.page}, line {0.line}'.format(self))
                raise e

    def closeAllTags(self):
        for ns_name, qname, _ in reversed(self.tag_stack):
            super().endElementNS(ns_name, qname)

    def reopenAllTags(self):
        for ns_name, qname, attributes in self.tag_stack:
            super().startElementNS(ns_name, qname, attributes)

def xml_to_html(xml_data):
    """Convert the XML data as a string to HTML as a string."""
    html_root = xml_to_html_root(xml_data)
    return etree.tostring(html_root, method='xml', encoding='unicode')

def xml_to_html_root(xml_data):
    """Convert the XML data as a string to HTML as an lxml Element."""
    xml_root = preprocess_xml(xml_data)
    xslt_root = etree.parse('transform.xslt').getroot()
    transform = etree.XSLT(xslt_root)
    return transform(xml_root)

def preprocess_xml(xml_data):
    """Preprocess the XML data to an lxml Element."""
    # I do not understand why it is necessary to cast to bytes here
    xml_root = etree.XML(bytes(xml_data, encoding='utf-8'))
    handler = TEIPager()
    sax.saxify(xml_root, handler)
    return handler.etree
