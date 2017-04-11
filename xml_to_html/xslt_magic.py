#!/usr/bin/env python3
import sys
import os
from lxml import etree

def xml_to_html(xml_data):
    html_root = xml_to_html_root(xml_data)
    return etree.tostring(html_root, method='html', encoding='unicode')

def xml_to_html_root(xml_data):
    xml_root = etree.XML(xml_data)
    xslt_root = etree.parse('transform.xslt').getroot()
    transform = etree.XSLT(xslt_root)
    return transform(xml_root)

if __name__ == '__main__':
    if 2 <= len(sys.argv) <= 3:
        in_path = sys.argv[1]
        if len(sys.argv) == 2:
            name, ext = os.path.splitext(in_path)
            out_path = name + '_from_xslt.html'
        else:
            out_path = sys.argv[2]
        with open(in_path, 'r') as ifsock:
            data = ifsock.read()
        html_root = xml_to_html_root(data)
        html_root.write(out_path, method='html')
    else:
        print('Usage: ./xslt_magic.py <XML filepath> <optional HTML output path>')
