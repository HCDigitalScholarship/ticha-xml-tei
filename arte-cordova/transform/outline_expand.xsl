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
    <!--<xsl:template match="pc[@type='hyphen']"/>-->
    
<xsl:template match="text">
             
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
            <hr />
          </div>

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



