<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:linp="http://ds.haverford.edu/linp">
    <!-- Above is the declaration of my imaginary namespace linp. It needs to be both here, and in the inital linp element 
    of my target xml document for using the document function.-->
    <xsl:output indent="no" method="xhtml"/>
    <!--<xsl:template match="text()"><xsl:value-of select="replace(., '&#x0A; *', '')"/></xsl:template>
    -->
   <!--<xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/></xsl:template>-->
     
    <xsl:variable name="interlins" select="document('../interlinsboot.xml')/linp:linp"/>
    <xsl:variable name="tableid" select="$interlins//linp:table/@id"></xsl:variable>
    <xsl:variable name="zapotec" select="//foreign[@xml:lang='cvz']"/>
    <xsl:variable name="foreignid" select="$zapotec/@xml:id"/>
    <xsl:variable name="interdiv" select="$interlins/linp:html/linp:body/linp:table"/>   
    <xsl:strip-space elements="head"/>
 
    <xsl:template match="teiHeader"/>
    <xsl:template match="corr"/>
    <xsl:template match="expan"/>
    <xsl:template match="reg"/>
    <xsl:template match="fw"/>
    <xsl:template match="pc[@type='hyphen']"/>
    
<xsl:template match="text">
       <html lang="en">
            <head>
                <meta charset="utf-8"></meta>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
                <meta name="description" content=""></meta>
                <meta name="author" content=""></meta>
                <title>Arte transcription</title>
            
                <!-- Bootstrap core CSS -->
                <link href="css/bootstrap_journal.css" rel="stylesheet"></link>
            
                <!-- Add custom CSS here -->
                <link href="css/small-business.css" rel="stylesheet"></link>
            	<link href="css/custom.css" rel="stylesheet"></link>
            	<link href="css/small_nav.css" rel="stylesheet"></link>
                <link href="css/divs.css" rel="stylesheet"></link>
            </head>
            <body>
            
                <nav class="navbar navbar-inverse" role="navigation">
                    <div class="container">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
            				
                            <!--<a class="navbar-brand" href="index_new.html">
                                <img src="img/logo2_long.png" alt="" height="120" width="380">
                            </a>-->
            				<p><h2><a href="index.html">Ticha</a></h2></p>
            				<p><h4>a digital text explorer for Colonial Valley Zapotec</h4></p>
            				           
            			</div>
            			<div class="navbar-collapse collapse navbar-ex1-collapse">
                          <ul class="nav navbar-nav navbar-right">
                            <!--<li class="active"><a href="index_new.html">Home</a></li>-->
            				<li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">About<b class="caret"></b></a>
                              <ul class="dropdown-menu">
                                <li><a href="about.html">The project</a></li>
                                <li><a href="use.html">How to use this site</a></li>
            					<li><a href="team.html">The team</a></li>
            					<li><a href="acknowledgements.html">Acknowledgements</a></li>
                                <li><a href="contact.html">Contact us</a></li>
                              </ul>
            				  </li>		
            				  <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Colonial Valley Zapotec<b class="caret"></b></a>
                              <ul class="dropdown-menu">
                                <li><a href="linguistic.html">Linguistic background</a></li>
                                <li><a href="context.html">Cultural context</a></li>						
                              </ul>
            				  </li>		 
            				   <li class="dropdown">
                              <a href="texts.html" class="dropdown-toggle" data-toggle="dropdown">Explore texts<b class="caret"></b></a>
                              <ul class="dropdown-menu">
            					<li class="divider"></li>
                                <li class="dropdown-header"><a href="arte.html">Arte en lengua zapoteca</a></li>
            					<li><a href="cordova.html">About Juan de Cordova</a></li>
            				    <li><a href="outline.html">Outline</a></li>
                                <li><a href="sample_arte.html">Sample pages</a></li>
                                <li><a href="reading_arte.html">Transcription</a></li>	
            					<li class="divider"></li>
                                <li class="dropdown-header"><a href="doctrina.html">Doctrina christiana en lengua castellana y çapoteca</a></li>
            					<li><a href="feria.html">About Pedro de Feria</a></li>
                                <li><a href="doctrina_pdf.html">PDF</a></li>	
            					<li class="divider"></li>
                                <li class="dropdown-header"><a href="handwritten.html">Handwritten texts</a></li>
                                <li><a href="sample_handwritten.html">Sample pages</a></li>					
                              </ul>
            				  </li>
            				  <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">Resources<b class="caret"></b></a>
                              <ul class="dropdown-menu">
                                <li><a href="bibliography.html">Bibliography</a></li>					
                                <li><a href="download.html">Download files</a></li>
                            </ul>
            				</li>
                          </ul>
                        </div>
                      </div>
                </nav>
                            
                            <div class="container">
                                <div class="row">
                                    <div class="col-xs-12">	
                                        <h1 class="center">Transcription of the Arte en lengua zapoteca</h1>
                                        <img class="img-responsive img-rounded center" vspace="35" src="img/titlepage.png" width="927" height="240"/>
                                            <!-- take out img-rounded if you don't want the rounded corners on the image -->
                                    </div>
                                     <div id="listContainer">
                                         <ul id="expList">
                                             <xsl:apply-templates/>
                                         </ul> 
                                     </div>
                                </div>
                              
                                
                           <!-- Approach
                              <div id="listContainer">
                                <ul id="expList">
                                    For each div at level one, create <li><ul>then do stuff to my child divs</ul</li>. Inside the open ul, 
                                    for each div at level two, create <li><ul>then do stuff to my child divs</ul></li> 
                                 </ul> 
                              </div>
                           -->
                           
                        <hr />
                        <footer style="height:150px">	
            		   <div class="col-xs-12">
            		   <p class="blockcenter">
            		       <h5>How to cite:</h5>
            			   Lillehaugen, Brook Danielle, George Aaron Broadwell, Michel R. Oudijk, Laurie Allen &amp; Enrique Valdivia. 2013.
            			      Ticha: a digital text explorer for Colonial Zapotec, prototype version.
            			   <a href="index.html">http://ticha.haverford.edu</a>.</p>
            		   </div>
            		   <div class="col-xs-12">
            		  <p class="text-center">
            				<a href="http://www.haverford.edu/">
            				<img src="img/Haverford_Wordmark_Red_for_web.jpg" class="grouped_elements" alt="" width="170" height="42" />
            			    </a>   
            				<a href="http://tdh.brynmawr.edu/">
            				<img src="http://ds.haverford.edu/wp/ticha/files/2013/08/TDH_72dpi3-300x156.jpg" class="grouped_elements" alt="This project generously supported with funding from the Tri-Co Digital Humanties." width="150" height="79" />
            				</a>
            				<a href="http://www.neh.gov/">
            				<img src="img/neh_at_logo.png" style="margin-right: 50px" class="grouped_elements" alt="All opinions, findings, conclusions, or recommendations expressed in this project do not necessarily represent those of the National Endowment for the Humanities." width="170" height="41" />
            				</a>
            				<a href="#">Back to top</a></p>
            			</div>
            		</footer>
             
                            </div>
                <!-- /.container -->
            
                <!-- JavaScript -->
                <script src="js/jquery-1.10.2.js"></script>
                <script src="js/bootstrap.js"></script>
                <script src="js/popovers.js"></script>
                <script src="js/divs.js"></script>
                    
                    </body>
            
         </html>

        
</xsl:template>
    
    
<xsl:template match="head">
   <xsl:choose>
            <xsl:when test="@type='outline'">
                <h4 align="left" class="outlinehead">
                    <xsl:apply-templates/>
                </h4>
            </xsl:when>
            <xsl:otherwise>
                <h4 align="center">
                    <xsl:apply-templates/>
                </h4>
            </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="div">
      <li><xsl:value-of select="head[@type='outline']"/>
          <ul><xsl:apply-templates select="*except(head[@type='outline'])"/></ul></li>
</xsl:template>

    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="foreign[@xml:lang='cvz']">
        <xsl:variable name="id">
            <xsl:value-of select="@xml:id"/>
        </xsl:variable>
        <xsl:variable name="mytable">
            <xsl:copy-of select="$interlins//linp:table[@id= $id]"/>
        </xsl:variable>
        <div style="display: inline;" class="popover-markup"><mark class="trigger"><xsl:value-of select="."/></mark>
            <div class="head hide">Interlinear</div>
            <div class="content hide">
                <p><xsl:copy-of select="$mytable"/></p>
            </div></div>
    </xsl:template>
    
  
    <xsl:template match="foreign[@xml:lang='lat']">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <xsl:template match="//pc">
        <xsl:choose>
            <xsl:when test="node()='¶'">¶</xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

   <!-- <xsl:template match="lb"><br/><xsl:apply-templates/></xsl:template>-->

<!--    <xsl:template match="pb[@type='arte']">
        <hr/>
        <div style="page">
            <xsl:variable name="url" select="following-sibling::pb/@facs"/>
            <a href="{$url}" target="blank">
                <xsl:value-of select="@n"/>
            </a>
        </div>
    </xsl:template>   --> 
    
</xsl:stylesheet>



