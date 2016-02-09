<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:linp="http://ds.haverford.edu/linp">
    <!-- Above is the declaration of my imaginary namespace linp. It needs to be both here, and in the inital linp element 
    of my target xml document for using the document function.-->
    <!--<xsl:strip-space elements="lb"/>-->
    <xsl:output indent="yes" method="xhtml"/>
    <!--<xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/></xsl:template>-->
    <!--<xsl:template match="text()"><xsl:value-of select="replace(., '&#x0A; *', '')"/></xsl:template>
    -->
   <!--<xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/></xsl:template>-->
     
    <xsl:variable name="interlins" select="document('../interlinsboot.xml')/linp:linp"/>
    <xsl:variable name="tableid" select="$interlins//linp:table/@id"></xsl:variable>
    <xsl:variable name="zapotec" select="//foreign[@xml:lang='cvz']"/>
    <xsl:variable name="foreignid" select="$zapotec/@xml:id"/>    
    <xsl:variable name="interdiv" select="$interlins/linp:html/linp:body/linp:table"/>   
 
<!--<xsl:strip-space elements="head"/>-->
    
<xsl:template match="corr"/> 
<xsl:template match="expan"/>
<xsl:template match="fw"/>
<xsl:template match="teiHeader"/>
<xsl:template match="orig"/>
<xsl:template match="lb"/>
    
<xsl:template match="text">
    <xsl:comment>This version of the arte was transformed using reg_original.xsl. It normalizes line breaks and spacing, and removes forme works.</xsl:comment>
                     <xsl:apply-templates/> 
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
    
<xsl:template match="pb[@type='arte']">
        <div class="page">
            <xsl:variable name="url" select="following-sibling::pb/@facs"/>
            <xsl:variable name="page" select="@n"></xsl:variable>
            <a href="{$url}" target="blank"  data-toggle="tooltip" title="View Page Image">page <xsl:value-of select='$page'/></a>
        </div>
        <!--a data-toggle="modal" class="btn btn-info" href="{$url}" data-target="#{$page}">page</a>
        <div class="modal fade" id="{$page}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content"><xsl:comment>comment</xsl:comment></div> <!-\- /.modal-content -\->
            </div> <!-\- /.modal-dialog -\->
        </div>-->
        <!-- <div data-toggle="modal" data-target="#{$page}">page <xsl:value-of select="$page"/></div>
            <div class="modal fade" id="{$page}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content" data-replace="true">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true"></span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title" id="myModalLabel">Arte en Lengua Zapoteca (page <xsl:value-of select="$page"/>)</h4>
                        </div>
                        <div class="modal-body">
                            <iframe height="70%" width="100%" src="{$url}" seamless="seamless" data-replace="true">x</iframe>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        
                        </div>
                    </div>
                </div>
            </div>-->
        
</xsl:template>      

<xsl:template match="div">
        <div><xsl:apply-templates/></div>
</xsl:template>
    
<xsl:template match="p">
        <p><div>-</div><xsl:apply-templates/></p>
</xsl:template>
    
<xsl:template match="foreign[@xml:lang='cvz']">
        <xsl:variable name="id">
            <xsl:value-of select="@xml:id"/>
        </xsl:variable>
        
        <xsl:variable name="mytable">
            <xsl:copy-of select="$interlins//linp:table[@id= $id]"/>
        </xsl:variable>
    <div class="popover-markup"><mark class="trigger"><xsl:apply-templates/></mark>
        <div class="head hide">Morphological Analysis</div>
        <div class="content hide"><xsl:copy-of select="$mytable"/> More to come</div>
    </div>
 
           <!-- <mark id="{$id}"><xsl:attribute name="title"><xsl:copy-of select="$mytable" /></xsl:attribute><xsl:attribute name="data-html">true</xsl:attribute><xsl:attribute name="rel">tooltip</xsl:attribute>
                <xsl:value-of select="."/><!-\-<xsl:copy-of select="$mytable" />-\->
            </mark>-->
        <!--<mark id="{$id}" data-toggle="tooltip" data-placement="top" data-html="true">
            <xsl:attribute name="title">
                <xsl:copy-of select="$mytable" />
            </xsl:attribute>
            <xsl:value-of select="."/><xsl:copy-of select="$mytable" />
        </mark>-->
</xsl:template>

<xsl:template match="foreign[@xml:lang='lat']">
    <em><xsl:apply-templates/></em>
</xsl:template>

<xsl:template match="pc[@type='hyphen']"/>

<xsl:template match="pc[node()='¶']">
        <xsl:apply-templates/>
</xsl:template>    
   

<!--<xsl:template match="reg">
    <xsl:choose>
        <xsl:when test="@type='spanish'">
            <xsl:choose>
                <xsl:when test="@type='spacing'"><xsl:value-of select="."/></xsl:when>
                <xsl:otherwise><xsl:value-of select="."></xsl:value-of></xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="."></xsl:value-of></xsl:otherwise>
    </xsl:choose>
    
</xsl:template>-->

<xsl:template match="choice">
    <xsl:choose>
        <xsl:when test="abbr">
            <xsl:value-of select="abbr"/>
        </xsl:when>
        <xsl:when test="reg[@type='spanish']">
            <xsl:choose>
                <xsl:when test="reg[@type='spacing']"><xsl:value-of select="reg[@type='spacing']"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="orig"/></xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise><xsl:value-of select="reg[@type='spacing']"/></xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>



