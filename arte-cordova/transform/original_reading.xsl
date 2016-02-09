<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:linp="http://ds.haverford.edu/linp">
   <!-- This version has no interlinears and is a pure, as transcribed, unregularized version.
       When applying this transformation, save it as original_text in the /jekyll/_includes-->
    <xsl:template match="teiHeader"/>
    <xsl:template match="lb"/>
    <xsl:template match="fw"/>
    <xsl:template match="expan"/>
    <xsl:template match="reg[@type='spanish']"/>
   <xsl:template match="orig"/>
     
    
    <xsl:template match="text">
        <xsl:comment>This version of the arte was transformed using original_reading.xsl</xsl:comment>
            <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:choose>
            <xsl:when test="@type='outline'">
                <h5 align="right">
                    <xsl:apply-templates/>
                </h5>
            </xsl:when>
            <xsl:otherwise>
                <h4 align="center">
                    <xsl:apply-templates/>
                </h4>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="div">
        <div>
           <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="foreign[@xml:lang='cvz']">
       <strong><xsl:apply-templates/></strong>
    </xsl:template>
    <xsl:template match="foreign[@xml:lang='lat']">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="reg[@type='spacing']">
        <xsl:apply-templates/>
    </xsl:template>

   <xsl:template match="choice">
       <xsl:choose>
           <xsl:when test="reg[@type='spacing']">
               <xsl:apply-templates/>
           </xsl:when>
           <xsl:otherwise>
               <xsl:copy-of select="orig"/>
           </xsl:otherwise>
       </xsl:choose>
   </xsl:template>
    <xsl:template match="reg"/>
  
    <xsl:template match="pb[@type='arte']">
        <hr/>
        <div style="page">
            <xsl:variable name="url" select="following-sibling::pb/@facs"/>
            <a href="{$url}" target="blank">
                <xsl:value-of select="@n"/>
            </a>
        </div>
    </xsl:template>    
    
</xsl:stylesheet>

