<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:linp="http://ds.haverford.edu/linp">
    <!-- Above is the declaration of my imaginary namespace linp. It needs to be both here, and in the inital linp element of my target xml document for using the document function.-->
    <xsl:variable name="latin" select="//foreign[@xml:lang='lat']"/>
    <xsl:variable name="spanish" select="//foreign[@xml:lang='es']"/>
    <xsl:template match="teiHeader"/>
    <xsl:template match="text">
        <div>
            <xsl:apply-templates/>
        </div>       
    </xsl:template>
    
    <xsl:template match="head">
    </xsl:template>
    
    <xsl:template match="entry">
        <div id="{@ana}">
        <h4><xsl:value-of select="form"/></h4>
            <p style="margin-left: .25in">Spanish: <xsl:value-of select="cit[@xml:lang='es']"/><br/>
            English: <xsl:value-of select="cit[@xml:lang='en']"/></p>
        </div>
    </xsl:template>
    
    <xsl:template match="gloss">
        <xsl:choose>
            <xsl:when test="@xml:lang='es'">
                Spanish: <xsl:apply-templates/> 
            </xsl:when>
            <xsl:when test="@xml:lang='eng'">
                <br/>English: <xsl:apply-templates/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>