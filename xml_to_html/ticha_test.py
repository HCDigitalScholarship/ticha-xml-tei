#!/usr/bin/env python3
import unittest
import os
import xml.etree.ElementTree as ET

from ticha_magic import xml_to_html

class TichaMagicTests(unittest.TestCase):
    directories = ('tests',)

    def test_directory(self):
        for directory in self.directories:
            for path in os.listdir(directory):
                _, ext = os.path.splitext(path)
                if ext == '.xml':
                    full_path = os.path.join(directory, path)
                    self.run_file_test(full_path)

    def run_file_test(self, xml_path):
        name, _ = os.path.splitext(xml_path)
        html_path = name + '.html'
        with open(xml_path, 'r', encoding='utf-8') as ifsock:
            xml_data = ifsock.read()
        magic = xml_to_html(xml_data)
        with open(html_path, 'r', encoding='utf-8') as ofsock:
            html_data = ofsock.read()
        magic_root = ET.fromstring(magic)
        file_root = ET.fromstring(html_data)
        self.assertTrue(xml_element_equal(magic_root, file_root))

def xml_element_equal(el1, el2):
    if el1.tag != el2.tag or el1.tail != el2.tail or el1.text != el2.text:
        return False
    if len(el1.attrib) != len(el2.attrib):
        return False
    for key, value in el1.attrib.items():
        if el2.attrib.get(key) != value:
            return False
    return all(xml_element_equal(child1, child2) for child1, child2 in zip(el1, el2))

if __name__ == '__main__':
    unittest.main()
