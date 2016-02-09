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
        <ul><xsl:apply-templates select="//foreign[@xml:lang='cvz']"/></ul>
        
    </xsl:template>    
    <xsl:template match="//foreign[@xml:lang='cvz']">
        <xsl:variable name="name">
            <xsl:value-of select="count(preceding::foreign[@xml:lang='cvz'])"/>
        </xsl:variable>
        <xsl:variable name="href"> 
               <xsl:value-of select="concat('#', $name)"/>
        </xsl:variable>
        <li>
            <a>
                <xsl:attribute name="href">
                    <xsl:copy-of select="$href"></xsl:copy-of>
                </xsl:attribute>
            <xsl:value-of select="."/>
            </a>
            <strong> It's Number: <xsl:value-of select="$href"/></strong>
       </li>
    </xsl:template> 
</xsl:stylesheet>

