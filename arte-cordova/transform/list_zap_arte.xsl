<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:linp="http://ds.haverford.edu/linp">
   <!-- This version has no interlinears and is a pure, as transcribed, unregularized version.
       When applying this transformation, save it as original_text in the /jekyll/_includes-->
    <xsl:variable name="interlins" select="document('../../interlins_all.xml')/linp:linp"/>
    <xsl:template match="teiHeader"/>   
    <xsl:template match="text">
            <xsl:for-each select="//text">
        <xsl:sort select="foreign[@xml:lang='cvz']"/> 
            </xsl:for-each>
        <ol><xsl:apply-templates select="//foreign[@xml:lang='cvz']"/></ol>
    </xsl:template>    
    <xsl:template match="//foreign[@xml:lang='cvz']">
        <li><xsl:value-of select="."/></li>
    </xsl:template> 
  <!-- 
          
          <xsl:template match="TEI">
        <ul>
    <xsl:for-each select="//text">
        <xsl:sort select="foreign[@xml:lang='cvz']"/>        
        <xsl:for-each select="//div">
        <li>
            <xsl:value-of select="//foreign[@xml:lang='cvz']"/>
         </li>
        </xsl:for-each>
 
    </xsl:for-each>
        </ul>
    </xsl:template> -->
</xsl:stylesheet>

