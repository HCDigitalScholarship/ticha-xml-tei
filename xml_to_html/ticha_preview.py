#!/usr/bin/env python3
"""Use this script to generate a browser-viewable version of ticha_magic's output. All it does it
   plug the HTML that ticha_magic spits out into a full document with CSS stylesheets.
"""
import sys
import os
from ticha_magic import xml_to_html

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
    html = xml_to_html(data)
    return TEMPLATE.format(html)

if __name__ == '__main__':
    if 2 <= len(sys.argv) <= 3:
        in_path = sys.argv[1]
        if len(sys.argv) == 2:
            name, ext = os.path.splitext(in_path)
            out_path = name + '_preview.html'
        else:
            out_path = sys.argv[2]
        with open(in_path, 'r', encoding='utf-8') as ifsock:
            data = ifsock.read()
        with open(out_path, 'w', encoding='utf-8') as ofsock:
            ofsock.write(preview(data))
    else:
        print('Usage: ticha_magic <XML filepath> <optional HTML output path>')
