#!/usr/bin/env python3
"""Generate an HTML outline from a TEI-encoded XML document."""
import xml.etree.ElementTree as ET
import sys
import os
from collections import namedtuple

def xml_to_outline(data):
    """Given XML data as a string, return an HTML outline."""
    return sections_to_outline(extract_sections(data))

def sections_to_outline(sections):
    """Given a list of Section objects (i.e., the output of extract_sections), return an HTML 
       outline.

       Look at the HTML source of https://ticha.haverford.edu/en/outline starting around line 123
       to see what HTML structure this function should output, except for now the dropbown buttons
       are not included.
    """
    builder = ET.TreeBuilder()
    builder.start('div', {'class':'index'})
    builder.start('ul')
    current_number = '1'
    for section in sections:
        # note that after each iteration of the loop, there is an unclosed <li> tag
        if len(section.number) > len(current_number):
            # opening a new subsection
            builder.start('ul', {'id':'section' + current_number})
        elif len(section.number) < len(current_number):
            # closing a subsection
            builder.end('ul')
        builder.start('li')
        builder.start('a', {'href':'/en/texts/levanto/{}/original'.format(section.page)})
        # i.e., 1.3.1 Licencia
        builder.data(section.number + ' ' + section.title)
        builder.end('a')
        builder.end('li')
        current_number = section.number
    builder.end('ul')
    builder.end('div')
    el = builder.close()
    return ET.tostring(el, encoding='unicode')


# class to represent Sections
Section = namedtuple('Section', ['number', 'title', 'page'])

def extract_sections(data):
    """Given XML data as a string, return a list of Section objects."""
    # this needs to be filled in to actually extract the sections
    return [Section('1', 'Front matter', '0'), Section('1.1', 'Cover of book', '0'),
            Section('2', 'Contents', '3')]

if __name__ == '__main__':
    if 2 <= len(sys.argv) <= 3:
        in_path = sys.argv[1]
        if len(sys.argv) == 2:
            name, ext = os.path.splitext(in_path)
            out_path = name + '_outline.html'
        else:
            out_path = sys.argv[2]
        with open(in_path, 'r', encoding='utf-8') as ifsock:
            data = ifsock.read()
        with open(out_path, 'w', encoding='utf-8') as ofsock:
            ofsock.write(xml_to_outline(data))
    else:
        print('Usage: ticha_outline <XML filepath> <optional HTML output path>')
