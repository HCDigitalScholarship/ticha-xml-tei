import xml.etree.ElementTree as ET
import os
import re
from lxml import etree
#import lxml.etree as ET
#from html5lib.sanitizer import HTMLSanitizerMixin
from bs4 import BeautifulSoup

#deleted ' from line 13750
#Just kidding I just moved something over for this #closed TEI tag on line 93 (from top of page)
#deleted some comments
#moving orig tag in line 19421. orginal line:"                      <foreign xml:lang="nah"><choice><orig>Huaxaca<reg type="spanish">Oaxaca</reg></orig></choice></foreign>," new line:"                     <foreign xml:lang="nah"><choice><orig>Huaxaca</orig><reg type="spanish">Oaxaca</reg></choice></foreign>,"
#Changed all instance of 'hypen' to 'hyphen'

#talk with Laurie about 24507, need to do span spacing for 24691, 


mychoice = 'reg' #options are reg and orig
want_the = 'spanish' #options are spacing and spanish
abbr_expan = 'expan' #options are abbr and expan
#getting the xml
tree = ET.parse('ticha_arte.xml')
root = tree.getroot()
newtree = ET.parse('output.xml')
newroot = newtree.getroot()
html_doc = ET.tostring(newroot,"us-ascii",'html')
soup = BeautifulSoup(html_doc, 'html.parser')
print soup.prettify()

#setting up a namespace
#Totally unclear on this at this point
ns = {'tei': 'http://www.tei-c.org/ns/1.0',
	'other':'preserve'} 

text = root.find('{http://www.tei-c.org/ns/1.0}text')
print text



#Goes deeper into the divs
def go_one_deeper(div):
		for item2 in div.findall("*"):
			#print item2, item2.tag 

			if item2.tag == '{http://www.tei-c.org/ns/1.0}div':
				id_info=item2.attrib['{http://www.w3.org/XML/1998/namespace}id']
				new_tag = soup.new_tag("div",id=id_info)
				html_tag=soup.html
				html_tag.append(new_tag)
				#need to go one deeper if there is more
				if item2.findall("*") != None:
					go_one_deeper(item2)

			#not clear on what to do with the heads, probably should refer back to what Laurie did
			elif item2.tag == '{http://www.tei-c.org/ns/1.0}head':
				head_list = ET.tostringlist(item2,"us-ascii","html")
				if '<ns0:choice' in head_list:
					choice_open = False
					p_tag_open = False
					p_open = False
					reg_tag_open = False
					orig_tag_open = False
					reg_open = False
					orig_open = False
					expan_tag_open = False
					expan_open = False
					abbr_tag_open = False
					abbr_open = False
					head_tag_open = False
					lb_tag_open = False
					lb_open = False
					head_open = False
					pc_tag_open = False
					pc_open = False
					dont_want = False
					spanish_exist = False
					no_break = False
					foreign_tag_open = False
					foreign_open = False
					hi_open = False
					hi_tag_open = False
					pb_tag_open = False
					fw_tag_open = False
					g_tag_open =False
					g_open = False
					ref_tag_open = False
					ref_open = False
					fw_skip = False
					#there are choices inside choices -_-
					another_choice_open = False
					another_reg_tag_open = False
					another_orig_tag_open = False
					another_expan_tag_open = False
					another_abbr_tag_open = False
					another_reg_open = False
					another_orig_open = False
					another_expan_open = False
					another_abbr_open = False
					#something means mystery
					something_tag_open = False
					something_open = False
					full_text = unicode()
					hold=""
					will_be_link = ""
					link_text = ""
					place = ""
					i_got_a_whitespace_baby = re.compile('\s*$') #matches any amount of white space
					index = -1
					for item in head_list:
							index = index + 1
							if item == '<ns0:head':
								head_tag_open = True
							elif head_tag_open and item == '>':
								head_tag_open = False
								head_open = True
								#assumes all is h1, probably not though. Could need to change
								#don't want this, I add tags later with soup								#full_text=full_text+unicode('<h1>')
								continue
							#print head_tag_open
							elif head_tag_open:
								continue
							#if '\n' in item:
							#	print item, "I caught your drift"
							#	continue
							elif item == '</ns0:head>':
								pass
								#full_text=full_text+unicode('</h1>')

							#Don't really care about p, just catches 'em
							elif item == '<ns0:p':
								p_tag_open = True
							elif p_tag_open and item == '>':
								p_tag_open = False
								p_open = True
							elif p_tag_open:
								#can find the type or whatevert
								continue
							elif item == '</ns0:p>':
								p_open = False

							elif item =='<ns0:choice':
								if choice_open:
									another_choice_open = True
								choice_open = True
							elif item =='</ns0:choice>':
								if another_choice_open:
									another_choice_open = False
									continue
								if mychoice == 'reg' and spanish_exist == False and hold != "":
									full_text = full_text + hold
									#print "ADDED", hold
									hold = ""
								choice_open = False
							#this is a long line soz
							elif choice_open and not(another_choice_open or reg_tag_open or orig_tag_open or expan_tag_open or abbr_tag_open or  reg_open or orig_open or expan_open or abbr_open):
								if item == '>':
									continue
								if item == '<ns0:reg':
									reg_tag_open = True

								elif item == '<ns0:orig':
									orig_tag_open = True
								elif item == '<ns0:abbr':
									abbr_tag_open = True
								elif item =='<ns0:expan':
									expan_tag_open = True
								elif i_got_a_whitespace_baby.match(item) != None:
									pass #white space was making it to error so I am blocking it 
								else:
									print "Error in <p>:", item
									print head_list
									print index
									print reg_tag_open, "reg_tag_open"
									print orig_tag_open, "orig_tag_open"
									print expan_tag_open, "expan_tag_open"
									print abbr_tag_open, "abbr_tag_open"
									print reg_open, "reg_open"
									print orig_open, "orig_open"
									print expan_open, "expan_open"
									print abbr_open, "abbr_open"
									print head_list[index-5:index+2]
									print head_list[index]
									print item
									print another_reg_tag_open, 'another_reg_tag_open'
									print another_orig_tag_open, 'another_orig_tag_open'
									print another_expan_tag_open, 'another_expan_tag_open'
									print another_abbr_tag_open, 'another_abbr_tag_open'
									print another_reg_open, 'another_reg_open'
									print another_orig_open, 'another_orig_open'
									print another_expan_open, 'another_expan_open'
									print another_abbr_open, 'another_abbr_open'
									print choice_open, 'choice_open'
									print another_choice_open, 'another_choice_open'
									raw_input()
							elif another_choice_open and not(another_reg_tag_open or another_orig_tag_open or another_expan_tag_open or another_abbr_tag_open or  another_reg_open or another_orig_open or another_expan_open or another_abbr_open): #soz is long
								if item == '>':
									continue
								if item == '<ns0:reg':
									another_reg_tag_open = True

								elif item == '<ns0:orig':
									another_orig_tag_open = True
								elif item == '<ns0:abbr':
									another_abbr_tag_open = True
								elif item =='<ns0:expan':
									another_expan_tag_open = True
								elif i_got_a_whitespace_baby.match(item) != None:
									pass #white space was making it to error so I am blocking it 
								else:
									print "Error in <p> in another:", item
									print index
									print head_list
									print reg_tag_open, "reg_tag_open"
									print orig_tag_open, "orig_tag_open"
									print expan_tag_open, "expan_tag_open"
									print abbr_tag_open, "abbr_tag_open"
									print reg_open, "reg_open"
									print orig_open, "orig_open"
									print expan_open, "expan_open"
									print abbr_open, "abbr_open"
									print head_list[index-5:index+2]
									print head_list[index]
									print item
									print another_reg_tag_open, 'another_reg_tag_open'
									print another_orig_tag_open, 'another_orig_tag_open'
									print another_expan_tag_open, 'another_expan_tag_open'
									print another_abbr_tag_open, 'another_abbr_tag_open'
									print another_reg_open, 'another_reg_open'
									print another_orig_open, 'another_orig_open'
									print another_expan_open, 'another_expan_open'
									print another_abbr_open, 'another_abbr_open'
									print choice_open, 'choice_open'
									print another_choice_open, 'another_choice_open'
									raw_input()

								"""
								elif item == '<ns0:orig':
									print reg_tag_open, "reg_tag_open"
									print orig_tag_open, "orig_tag_open"
									print expan_tag_open, "expan_tag_open"
									print abbr_tag_open, "abbr_tag_open"
									print reg_open, "reg_open"
									print orig_open, "orig_open"
									print expan_open, "expan_open"
									print abbr_open, "abbr_open"
									print head_list
									print index
									print head_list[index-5:index+2]
									print head_list[index]
									print item
									raw_input()
								"""
							elif (another_reg_tag_open or another_orig_tag_open or another_expan_tag_open or another_abbr_tag_open) and item == '>':
								if another_reg_tag_open:
									another_reg_open=True
								elif another_orig_tag_open:
									another_orig_open = True
								elif another_abbr_tag_open:
									another_abbr_open = True
								elif another_expan_tag_open:
									another_expan_open = True
								another_abbr_tag_open = False
								another_expan_tag_open = False
								another_reg_tag_open = False
								another_orig_tag_open = False
							elif (another_reg_tag_open or another_orig_tag_open or another_expan_tag_open or another_abbr_tag_open):
								#might need to do ANOTHER spanish/spacing thing
								continue
							elif another_choice_open and (item == '</ns0:reg>' or item == '</ns0:orig>' or item == '</ns0:abbr>' or item == '</ns0:expan>') :
								#dont_want=False
								another_reg_open = False
								another_orig_open = False
								another_expan_open = False
								another_abbr_open = False
							elif (reg_tag_open or orig_tag_open or abbr_tag_open or expan_tag_open) and item =='>':
								if reg_tag_open:
									reg_open=True
								elif orig_tag_open:
									orig_open = True
								elif abbr_tag_open:
									abbr_open = True
								elif expan_tag_open:
									expan_open = True
								abbr_tag_open = False
								expan_tag_open = False
								reg_tag_open = False
								orig_tag_open = False
							elif (reg_tag_open or orig_tag_open or abbr_tag_open or expan_tag_open):
								#could make a tag

								#assumes that there is no typo's, could be a bad assumption
								#Also, probably will want to add an option for spacing
								if want_the == 'spanish' and item != ' type="spanish"':
									dont_want = True
								elif want_the == 'spanish' and item == ' type="spanish"':
									#found some nice spanish
									spanish_exist = True
								continue
							elif item == '</ns0:reg>' or item == '</ns0:orig>' or item == '</ns0:abbr>' or item == '</ns0:expan>' :
								dont_want=False
								reg_open = False
								orig_open = False
								expan_open = False
								abbr_open = False
							elif item == '<ns0:lb':
								lb_tag_open = True
							elif lb_tag_open and item=='>':
								lb_tag_open=False
								lb_open = True
							#might be some option here
							elif lb_tag_open:
								if mychoice == 'reg' and item == ' break="no"':
									no_break = True
								continue
							elif item  == '</ns0:lb>':
								if not(no_break):
									full_text = full_text + unicode('<br>')
								lb_open = False
							elif item == '<ns0:pc':
								pc_tag_open = True
							elif pc_tag_open:
								if item == '>':
									pc_tag_open = False
									pc_open = True
								elif item != ' type="hyphen"':
									print item, "This is not hyphen"
							elif item == '</ns0:pc>':
								pc_open = False
							elif pc_open:
								if mychoice == 'reg' and not(want_the == 'spanish'):
									full_text = full_text + unicode(item)

							elif item == '<ns0:foreign':
								foreign_tag_open = True
							elif foreign_tag_open and item == '>':
								foreign_tag_open = False
								foreign_open= True
								full_text = full_text + '<em>'
							elif foreign_tag_open:
								#could REALLY add. this stuff is important but ignore for now
								pass
							elif item == '</ns0:foreign>':
								full_text = full_text + '</em>'
								foreign_open = False
							elif foreign_open:
								full_text = full_text + item
							elif item == "<ns0:hi":
								hi_tag_open = True
							elif hi_tag_open and item == '>':
								hi_tag_open = False
								hi_open = True
								full_text = full_text + '<b>'
							elif hi_tag_open:
								#this stuff might be important
								pass
							elif item == "</ns0:hi>":
								full_text = full_text + '</b>'
								hi_open=False
							elif hi_open:
								full_text = full_text + unicode(item)
							elif item == '<ns0:pb':
								pb_tag_open = True
							elif pb_tag_open and item == '>':
								pb_tag_open = False
							elif pb_tag_open and item[:2] == ' n':
								link_text = item[4:-1]
							elif pb_tag_open and item[:5] == " facs":
								if link_text == "":
									print "Error: Link text empty for link:", item
								
								full_text = full_text + "\n<div class='page' > <a title='View Page Image' data-toggle='tooltip' target='blank' href=" + item[7:-1] +">Page " + link_text + '</a> </div>'
								link_text = ""
							elif pb_tag_open: #Don't care?
								continue
							elif item == '</ns0:pb>':
								pass #we don't care
							elif item == '<ns0:fw':
								if mychoice=='orig': #NEED TO ADD TO FOR ORIG
									fw_tag_open = True
								fw_skip = True
							elif fw_tag_open and item == '>':
								fw_tag_open = False
							elif fw_tag_open and item[:6] == ' place':
								place=item[8:-1]
							elif fw_tag_open or fw_skip:
								continue
							elif item == '</ns0:fw>':
								continue
							elif item == '<ns0:g':
								g_tag_open = True
							elif g_tag_open and item == '>':
								g_tag_open =False
								g_open = True
							elif g_tag_open:
								continue
							elif g_open and item == '</ns0:g>':
								g_open = False

							#Does nothing	
							elif item == '<ns0:ref':
								ref_tag_open = True
							elif ref_tag_open and item == ">":
								ref_tag_open = False
								ref_open = True
							elif ref_tag_open:
								continue
							elif item == '</ns0:ref>':
								ref_open=False
							elif ref_open:
								continue


							elif item[0]=='<' and not(something_open):
								print "WE FOUND A MYSTERY:"
								print "Unknown tag:", item ,"used in <p>"
								print item
								if item == '<ns0:orig' or item == '<ns0:reg':
									print index
									print head_list
									print reg_tag_open, "reg_tag_open"
									print orig_tag_open, "orig_tag_open"
									print expan_tag_open, "expan_tag_open"
									print abbr_tag_open, "abbr_tag_open"
									print reg_open, "reg_open"
									print orig_open, "orig_open"
									print expan_open, "expan_open"
									print abbr_open, "abbr_open"
									print head_list[index-5:index+2]
									print head_list[index]
									print item
									print another_reg_tag_open, 'another_reg_tag_open'
									print another_orig_tag_open, 'another_orig_tag_open'
									print another_expan_tag_open, 'another_expan_tag_open'
									print another_abbr_tag_open, 'another_abbr_tag_open'
									print another_reg_open, 'another_reg_open'
									print another_orig_open, 'another_orig_open'
									print another_expan_open, 'another_expan_open'
									print another_abbr_open, 'another_abbr_open'
									print choice_open, 'choice_open'
									print another_choice_open, 'another_choice_open'
									raw_input()

								something_tag_open = True
								mystery_tag=item[5:]
							elif something_tag_open and item == '>':
								something_tag_open = False
								something_open = True
							elif something_tag_open:
								#could add some cool options here
								continue
							elif something_open and item == "</ns0:"+mystery_tag+">":
								something_open = False
							elif dont_want:
								hold = hold + unicode(item)
								continue
							elif reg_open and mychoice=='reg':
								full_text = full_text + unicode(item)
							elif reg_open:
								continue
							elif orig_open and mychoice=='orig':
								full_text = full_text + unicode(item)
							elif orig_open:
								continue
							elif abbr_open and abbr_expan=='abbr':
								full_text = full_text + unicode(item)
							elif abbr_open:
								continue
							elif expan_open and abbr_expan == 'expan':
								full_text = full_text + unicode(item)
							elif expan_open:
								continue
							else:
								#print item, "not got by parser"
								full_text = full_text + unicode(item)
					#print full_text
					#print full_text.encode('utf8', 'replace')
					#raw_input() #debug
					id_info=item2.attrib['type']
					new_tag = soup.new_tag("h4")
					new_tag.string = full_text.encode('utf8', 'replace')
					#print new_tag, "QQQ" #debug
					div_id =  div.attrib['{http://www.w3.org/XML/1998/namespace}id']
					the_div=soup.find(id=div_id)
					the_div.append(new_tag)

				else:
					id_info=item2.attrib['type']
					new_tag = soup.new_tag("h4")
					if item2.text == None:
						return 
					new_tag.string = item2.text
					div_id =  div.attrib['{http://www.w3.org/XML/1998/namespace}id']
					the_div=soup.find(id=div_id)
					the_div.append(new_tag)

				'''id_info=item2.attrib['type']
				new_tag = soup.new_tag("h1")
				div_id =  div.attrib['{http://www.w3.org/XML/1998/namespace}id']
				the_div=soup.find(id=div_id)
				the_div.append(new_tag)
				'''
				#print item.text == None, item.text == ""
				#print type(item.text)
				#print ET.tostringlist(item2,"us-ascii","html") ,"\n\n\n\n\n\n" #debug

			#again, unclear
			elif item2.tag == '{http://www.tei-c.org/ns/1.0}pb':
				#make a pb?
				pass
			elif item2.tag == '{http://www.tei-c.org/ns/1.0}choice':
				if mychoice == 'reg':
					item2.find('reg')
			elif item2.tag == '{http://www.tei-c.org/ns/1.0}p':
				head_list = ET.tostringlist(item2,"us-ascii","html")
				#print head_list
				choice_open = False
				p_tag_open = False
				p_open = False
				reg_tag_open = False
				orig_tag_open = False
				reg_open = False
				orig_open = False
				expan_tag_open = False
				expan_open = False
				abbr_tag_open = False
				abbr_open = False
				head_tag_open = False
				lb_tag_open = False
				lb_open = False
				head_open = False
				pc_tag_open = False
				pc_open = False
				dont_want = False
				spanish_exist = False
				no_break = False
				foreign_tag_open = False
				foreign_open = False
				hi_open = False
				hi_tag_open = False
				pb_tag_open = False
				fw_tag_open = False
				g_tag_open =False
				g_open = False
				ref_tag_open = False
				ref_open = False
				fw_skip = False
				#there are choices inside choices -_-
				another_choice_open = False
				another_reg_tag_open = False
				another_orig_tag_open = False
				another_expan_tag_open = False
				another_abbr_tag_open = False
				another_reg_open = False
				another_orig_open = False
				another_expan_open = False
				another_abbr_open = False
				#something means mystery
				something_tag_open = False
				something_open = False
				full_text = unicode()
				hold=""
				will_be_link = ""
				link_text = ""
				place = ""
				foreign_info = []
				foreign_hold = ""
				i_got_a_whitespace_baby = re.compile('\s*$') #matches any amount of white space
				index = -1
				for item in head_list:
						#useful for debugging, find which item you are on
						index = index + 1

						#head section
						if item == '<ns0:head':
							head_tag_open = True
						elif head_tag_open and item == '>':
							head_tag_open = False
							head_open = True
							continue
						elif head_tag_open:
							continue
						elif item == '</ns0:head>':
							pass


						#p section
						#Don't really care about p, just catches 'em
						elif item == '<ns0:p':
							p_tag_open = True
						elif p_tag_open and item == '>':
							p_tag_open = False
							p_open = True
						elif p_tag_open:
							#can find the type of paragraph or whatever, probably irrelevant 
							continue
						elif item == '</ns0:p>':
							p_open = False


						#choice section
						#This is the tricky part
						elif item =='<ns0:choice':
							if choice_open:
								another_choice_open = True
							choice_open = True
						elif item =='</ns0:choice>':
							#there is sometimes choices in choices, this closes the inner choice
							if another_choice_open:
								another_choice_open = False
								continue
							#adds in held words. This is for the case where there is a reg of type spacing but not of type spanish
							#The parser currently prefers to add the spanish tag if given the choice, but otherwise will do the other one
							if mychoice == 'reg' and spanish_exist == False and hold != "":
								full_text = full_text + hold
								hold = ""
							choice_open = False
						#this is a long line soz
						elif choice_open and not(another_choice_open or reg_tag_open or orig_tag_open or expan_tag_open or abbr_tag_open or  reg_open or orig_open or expan_open or abbr_open):
							if item == '>':
								continue
							if item == '<ns0:reg':
								reg_tag_open = True

							elif item == '<ns0:orig':
								orig_tag_open = True
							elif item == '<ns0:abbr':
								abbr_tag_open = True
							elif item =='<ns0:expan':
								expan_tag_open = True
							elif i_got_a_whitespace_baby.match(item) != None:
								pass #white space was making it to error so I am blocking it 
							#this means something got thru and there is some problem
							#All the printout are useful to figuring out what is up
							else:
								print "Error in <p>:", item
								print head_list
								print index
								print reg_tag_open, "reg_tag_open"
								print orig_tag_open, "orig_tag_open"
								print expan_tag_open, "expan_tag_open"
								print abbr_tag_open, "abbr_tag_open"
								print reg_open, "reg_open"
								print orig_open, "orig_open"
								print expan_open, "expan_open"
								print abbr_open, "abbr_open"
								print head_list[index-5:index+2]
								print head_list[index]
								print item
								print another_reg_tag_open, 'another_reg_tag_open'
								print another_orig_tag_open, 'another_orig_tag_open'
								print another_expan_tag_open, 'another_expan_tag_open'
								print another_abbr_tag_open, 'another_abbr_tag_open'
								print another_reg_open, 'another_reg_open'
								print another_orig_open, 'another_orig_open'
								print another_expan_open, 'another_expan_open'
								print another_abbr_open, 'another_abbr_open'
								print choice_open, 'choice_open'
								print another_choice_open, 'another_choice_open'
								raw_input("Press Enter to Continue")
						

						#another_choice section
						elif another_choice_open and not(another_reg_tag_open or another_orig_tag_open or another_expan_tag_open or another_abbr_tag_open or  another_reg_open or another_orig_open or another_expan_open or another_abbr_open): #soz is long
							if item == '>':
								continue
							if item == '<ns0:reg':
								another_reg_tag_open = True

							elif item == '<ns0:orig':
								another_orig_tag_open = True
							elif item == '<ns0:abbr':
								another_abbr_tag_open = True
							elif item =='<ns0:expan':
								another_expan_tag_open = True
							elif i_got_a_whitespace_baby.match(item) != None:
								pass #white space was making it to error so I am blocking it 
							else:
								print "Error in <p> in another:", item
								print index
								print head_list
								print reg_tag_open, "reg_tag_open"
								print orig_tag_open, "orig_tag_open"
								print expan_tag_open, "expan_tag_open"
								print abbr_tag_open, "abbr_tag_open"
								print reg_open, "reg_open"
								print orig_open, "orig_open"
								print expan_open, "expan_open"
								print abbr_open, "abbr_open"
								print head_list[index-5:index+2]
								print head_list[index]
								print item
								print another_reg_tag_open, 'another_reg_tag_open'
								print another_orig_tag_open, 'another_orig_tag_open'
								print another_expan_tag_open, 'another_expan_tag_open'
								print another_abbr_tag_open, 'another_abbr_tag_open'
								print another_reg_open, 'another_reg_open'
								print another_orig_open, 'another_orig_open'
								print another_expan_open, 'another_expan_open'
								print another_abbr_open, 'another_abbr_open'
								print choice_open, 'choice_open'
								print another_choice_open, 'another_choice_open'
								raw_input()
						elif (another_reg_tag_open or another_orig_tag_open or another_expan_tag_open or another_abbr_tag_open) and item == '>':
							if another_reg_tag_open:
								another_reg_open=True
							elif another_orig_tag_open:
								another_orig_open = True
							elif another_abbr_tag_open:
								another_abbr_open = True
							elif another_expan_tag_open:
								another_expan_open = True
							another_abbr_tag_open = False
							another_expan_tag_open = False
							another_reg_tag_open = False
							another_orig_tag_open = False
						elif (another_reg_tag_open or another_orig_tag_open or another_expan_tag_open or another_abbr_tag_open):
							#might need to do ANOTHER spanish/spacing thing
							#There is one case with it I believe
							continue
						elif another_choice_open and (item == '</ns0:reg>' or item == '</ns0:orig>' or item == '</ns0:abbr>' or item == '</ns0:expan>') :
							#dont_want=False
							another_reg_open = False
							another_orig_open = False
							another_expan_open = False
							another_abbr_open = False

						#back to choice
						elif (reg_tag_open or orig_tag_open or abbr_tag_open or expan_tag_open) and item =='>':
							if reg_tag_open:
								reg_open=True
							elif orig_tag_open:
								orig_open = True
							elif abbr_tag_open:
								abbr_open = True
							elif expan_tag_open:
								expan_open = True
							abbr_tag_open = False
							expan_tag_open = False
							reg_tag_open = False
							orig_tag_open = False
						elif (reg_tag_open or orig_tag_open or abbr_tag_open or expan_tag_open):
							#This deals with the situation where there are both a spanish and spacing in reg
							#assumes that there is no typo's, could be a bad assumption
							#Also, probably will want to add an option for spacing
							if want_the == 'spanish' and item != ' type="spanish"':
								dont_want = True
							elif want_the == 'spanish' and item == ' type="spanish"':
								#found some nice reg spanish
								spanish_exist = True
							continue
						elif item == '</ns0:reg>' or item == '</ns0:orig>' or item == '</ns0:abbr>' or item == '</ns0:expan>' :
							dont_want=False
							reg_open = False
							orig_open = False
							expan_open = False
							abbr_open = False

						#lb section. Doesn't always want line breaks
						elif item == '<ns0:lb':
							lb_tag_open = True
						elif lb_tag_open and item=='>':
							lb_tag_open=False
							lb_open = True
						#might be some option here
						elif lb_tag_open:
							if mychoice == 'reg' and item == ' break="no"':
								no_break = True
							continue
						elif item  == '</ns0:lb>':
							if not(no_break):
								full_text = full_text + unicode('<br>')
							lb_open = False

						#pc section. It can be the paragraph symbol or a hyphen. Maybe other stuff, but I do not think so
						elif item == '<ns0:pc':
							pc_tag_open = True
						elif pc_tag_open:
							if item == '>':
								pc_tag_open = False
								pc_open = True
							elif item != ' type="hyphen"':
								print item, "This is not hyphen"
						elif item == '</ns0:pc>':
							pc_open = False
						elif pc_open:
							if mychoice == 'reg' and not(want_the == 'spanish'):
								full_text = full_text + unicode(item)
						#foreign section
						#This is a huge pain
						elif item == '<ns0:foreign':
							foreign_tag_open = True
						elif foreign_tag_open and item == '>':
							foreign_tag_open = False
							foreign_open= True
							if ' xml:lang="cvz"' in foreign_info:
								has_id = False
								for thing in foreign_info:
									if thing[:7]==' xml:id':
										has_id = True
										the_id = thing[9:-1]

								if has_id:
									full_text = full_text + '<mark class ="trigger" data-original-title="" title="" id='+the_id+'>'
									continue
								else:
									full_text = full_text + '<mark class ="trigger" data-original-title="" title="">'
									continue
							full_text = full_text + '<em>'
						elif foreign_tag_open:
							foreign_info = foreign_info + [item]
							pass
						elif item == '</ns0:foreign>':
							#print foreign_hold
							#raw_input()
							#if ' xml:lang="cvz"' in foreign_info:
							#	full_text = full_text + 'word='+foreign_hold+'>'+foreign_hold+'</mark>'
							#else:
							#	full_text = full_text +foreign_hold+ '</em>'
							if ' xml:lang="cvz"' in foreign_info:
								full_text = full_text + '</mark>'
							else:
								full_text = full_text +'</em>'							
							#foreign_hold = ""
							foreign_open = False
							foreign_info = []
						elif foreign_open and not(choice_open):
							#foreign_hold = foreign_hold + item
							full_text = full_text + item 
						elif item == "<ns0:hi":
							hi_tag_open = True
						elif hi_tag_open and item == '>':
							hi_tag_open = False
							hi_open = True
							full_text = full_text + '<b>'
						elif hi_tag_open:
							#this stuff might be important
							pass
						elif item == "</ns0:hi>":
							full_text = full_text + '</b>'
							hi_open=False
						elif hi_open:
							full_text = full_text + unicode(item)
						elif item == '<ns0:pb':
							pb_tag_open = True
						elif pb_tag_open and item == '>':
							pb_tag_open = False
						elif pb_tag_open and item[:2] == ' n':
							link_text = item[4:-1]
						elif pb_tag_open and item[:5] == " facs":
							if link_text == "":
								print "Error: Link text empty for link:", item
							
							full_text = full_text + "\n<div class='page' > <a title='View Page Image' data-toggle='tooltip' target='blank' href=" + item[7:-1] +">Page " + link_text + '</a> </div>'
							link_text = ""
						elif pb_tag_open: #Don't care?
							continue
						elif item == '</ns0:pb>':
							pass #we don't care
						elif item == '<ns0:fw':
							if mychoice=='orig': #NEED TO ADD TO FOR ORIG
								fw_tag_open = True
							fw_skip = True
						elif fw_tag_open and item == '>':
							fw_tag_open = False
						elif fw_tag_open and item[:6] == ' place':
							place=item[8:-1]
						elif fw_tag_open or fw_skip:
							continue
						elif item == '</ns0:fw>':
							continue
						elif item == '<ns0:g':
							g_tag_open = True
						elif g_tag_open and item == '>':
							g_tag_open =False
							g_open = True
						elif g_tag_open:
							continue
						elif g_open and item == '</ns0:g>':
							g_open = False

						#Does nothing	
						elif item == '<ns0:ref':
							ref_tag_open = True
						elif ref_tag_open and item == ">":
							ref_tag_open = False
							ref_open = True
						elif ref_tag_open:
							continue
						elif item == '</ns0:ref>':
							ref_open=False
						elif ref_open:
							continue


						elif item[0]=='<' and not(something_open):
							print "WE FOUND A MYSTERY:"
							print "Unknown tag:", item ,"used in <p>"
							print item
							if item == '<ns0:orig':
								print index
								print head_list
								print reg_tag_open, "reg_tag_open"
								print orig_tag_open, "orig_tag_open"
								print expan_tag_open, "expan_tag_open"
								print abbr_tag_open, "abbr_tag_open"
								print reg_open, "reg_open"
								print orig_open, "orig_open"
								print expan_open, "expan_open"
								print abbr_open, "abbr_open"
								print head_list[index-5:index+2]
								print head_list[index]
								print item
								print another_reg_tag_open, 'another_reg_tag_open'
								print another_orig_tag_open, 'another_orig_tag_open'
								print another_expan_tag_open, 'another_expan_tag_open'
								print another_abbr_tag_open, 'another_abbr_tag_open'
								print another_reg_open, 'another_reg_open'
								print another_orig_open, 'another_orig_open'
								print another_expan_open, 'another_expan_open'
								print another_abbr_open, 'another_abbr_open'
								print choice_open, 'choice_open'
								print another_choice_open, 'another_choice_open'
								raw_input()

							something_tag_open = True
							mystery_tag=item[5:]
						elif something_tag_open and item == '>':
							something_tag_open = False
							something_open = True
						elif something_tag_open:
							#could add some cool options here
							continue
						elif something_open and item == "</ns0:"+mystery_tag+">":
							something_open = False
						elif dont_want:
							hold = hold + unicode(item)
							continue
						elif reg_open and mychoice=='reg':
							full_text = full_text + unicode(item)
						elif reg_open:
							continue
						elif orig_open and mychoice=='orig':
							full_text = full_text + unicode(item)
						elif orig_open:
							continue
						elif abbr_open and abbr_expan=='abbr':
							full_text = full_text + unicode(item)
						elif abbr_open:
							continue
						elif expan_open and abbr_expan == 'expan':
							full_text = full_text + unicode(item)
						elif expan_open:
							continue
						else:
							#This is the spot where all of the plain text, not directly in tags, comes
							#print item, "not got by parser"
							full_text = full_text + unicode(item)
				#print full_text
				#raw_input()
				#print item2.attrib
				#id_info=item2.attrib['type']
				new_tag = soup.new_tag("p")
				new_tag.string = full_text.encode('utf8', 'replace')
				#print new_tag, "QQQ"
				div_id =  div.attrib['{http://www.w3.org/XML/1998/namespace}id']
				the_div=soup.find(id=div_id)
				the_div.append(new_tag)				
				#raw_input()





for item in text.findall('*'):
	for div in item.findall('*'):
		id_info=div.attrib['{http://www.w3.org/XML/1998/namespace}id']
		new_tag = soup.new_tag("div",id=id_info)
		html_tag=soup.html
		html_tag.append(new_tag)
		#at this point, I might be able to do this repeatedly, i.e. make this badboy a function or loop
		go_one_deeper(div)
		'''
		for item2 in div.findall("*"):
			#print item2, item2.tag 
			if item2.tag == '{http://www.tei-c.org/ns/1.0}div':
				id_info=item2.attrib['{http://www.w3.org/XML/1998/namespace}id']
				new_tag = soup.new_tag("div",id=id_info)
				html_tag=soup.html
				html_tag.append(new_tag)
				#need to go one deeper

			#not clear on what to do with the heads, probably should refer back to what Laurie did
			elif item2.tag == '{http://www.tei-c.org/ns/1.0}head':
				id_info=item2.attrib['type']
				new_tag = soup.new_tag("h1")
				html_tag=soup.html
				html_tag.append(new_tag)
				print item.text, "we might be fucked"
			#again, unclear
			elif item2.tag == '{http://www.tei-c.org/ns/1.0}pb':
				#make a pb?
				pass
			elif item2.tag == '{http://www.tei-c.org/ns/1.0}choice':
				if mychoice == 'reg':
					item2.find('reg')
		'''

#Writing the file
cooked_soup = soup.prettify() 
#print cooked_soup
string_for_output = cooked_soup.encode('utf8', 'replace')
with open('new_output2.html','w') as f:
	f.write(string_for_output)

#Now we reload the html and fix the special chars. I think this is the most convinient way of doing this
#There is probably something programmatically faster but more of a pain in the ass to figure out

with open('new_output2.html','r') as f:
	whole_text = f.read()
	fix_amp = re.sub(r"&amp;","&",whole_text)
	#there are no < or > used in the doc(actual text), but it would be a prooooooblem if there were
	fix_lt = re.sub(r"&lt;","<",fix_amp)
	fix_gt = re.sub(r"&gt;",">",fix_lt)
	with open('new_output2.html', 'w') as fr:
		fr.write(fix_gt)
