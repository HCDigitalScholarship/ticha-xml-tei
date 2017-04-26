#!/usr/bin/env python3
import argparse
import os
from lxml import etree

import ticha_outline
import ticha_magic
import xslt_magic

TEMPLATE = """\
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="https://ticha.haverford.edu/static/zapotexts/css/page_detail_style.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="container">
      <div class="row text-center">
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
          {}
        </div>
      </div>
    </div>
  </body>
</html>
"""
def preview(data):
    html = xslt_magic.xml_to_html(data)
    return TEMPLATE.format(html)

def preprocess_xml_to_string(xml_data):
    html_root = xslt_magic.preprocess_xml(xml_data)
    return etree.tostring(html_root, method='xml', encoding='unicode')

if __name__ == '__main__':
    choice_dispatch = {
        'html':(xslt_magic.xml_to_html, '.html'),
        'outline':(ticha_outline.xml_to_outline, '_outline.html'),
        'preview':(preview, '_preview.html'),
        'magic':(ticha_magic.xml_to_html, '.html'),
        'preprocessed':(preprocess_xml_to_string, '_preprocessed.xml'),
    }
    parser = argparse.ArgumentParser(description='XML to HTML utilities')
    parser.add_argument('output', choices=choice_dispatch.keys(),
                        help='format of output ("html" uses XSLT, while "magic" is pure Python)')
    parser.add_argument('--in', dest='in_', default='../levanto/levanto.xml', 
                        help='file to read XML from')
    parser.add_argument('--out', default='', help='file to write to')
    args = parser.parse_args()
    transform_f, file_ext = choice_dispatch[args.output]
    with open(args.in_, 'r', encoding='utf-8') as ifsock:
        data = transform_f(ifsock.read())
    name = os.path.splitext(args.in_)[0]
    out_path = args.out or (name + file_ext)
    with open(out_path, 'w', encoding='utf-8') as ofsock:
        ofsock.write(data)
