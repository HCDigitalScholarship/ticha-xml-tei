<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:linp="http://ds.haverford.edu/linp">
    <!-- Above is the declaration of my imaginary namespace linp. It needs to be both here, and in the inital linp element 
    of my target xml document for using the document function.-->
    <!--<xsl:strip-space elements="lb"/>-->
    <!--<xsl:output indent="yes" method="xhtml"/> -->
    <!--<xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/></xsl:template>-->
    <!--<xsl:template match="text()"><xsl:value-of select="replace(., '&#x0A; *', '')"/></xsl:template>
    -->
   <!-- Add a reg type="cvz" template  And add a reg type="lat" to the choices -->
     
    <xsl:variable name="interlins" select="document('../interlinsboot2_edited.xml')/linp:linp"/>
    <xsl:variable name="tableid" select="$interlins//linp:table/@id"></xsl:variable>
    <xsl:variable name="zapotec" select="//foreign[@xml:lang='cvz']"/>
    <xsl:variable name="foreignid" select="$zapotec/@xml:id"/>    
    <xsl:variable name="interdiv" select="$interlins/linp:html/linp:body/linp:table"/>   
 
<!-- <xsl:strip-space elements="head"/> -->
    
<xsl:template match="corr"/> 
<xsl:template match="expan"></xsl:template>
<xsl:template match="fw"/>
<xsl:template match="teiHeader"/>
<xsl:template match="orig"/>
<xsl:template match="pc[@type='hyphen']"/>

  


    
<xsl:template match="text">
    <xsl:comment>This version of the arte was transformed using reg_spanish.xsl. This version of the arte is normalized for spacing, line breaks and includes
    normalized spanish spelling.</xsl:comment>                 
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
    
<xsl:template match="lb">
    <xsl:choose>
        <xsl:when test="@break='no'"/>
            <!-- create a variable equal to the space between the words, plus a hyphen. Call that variable x
            <xsl:value-of select="translate('x',' ','')"></xsl:value-of> -->
        <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
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
    <xsl:apply-templates/>
    <xsl:variable name="id"><xsl:value-of select="@xml:id"/></xsl:variable>
    <xsl:variable name="active_div">
        <xsl:value-of select="'arte2'"></xsl:value-of>
    </xsl:variable>
    <xsl:variable name="active_div_front">
        <xsl:value-of select="'arte1'"></xsl:value-of>
    </xsl:variable>
    <!-- 
    <xsl:if test="$id = string('arte2' or 'arte2.1' or 'arte2.2' or 'arte2.2.1' or 'arte2.2.2' or 'arte2.2.3' or 'arte2.2.4' or 'arte2.2.5' or 'arte2.2.6' or 'arte2.2.7' or 'arte2.2.8' or 'arte2.2.8.2' or 'arte2.2.9' or 'arte2.3' or 'arte2.3.1' or 'arte2.3.2' or 'arte2.3.3' or 'arte2.3.4' or 'arte2.3.5' or 'arte2.3.6' or 'arte2.3.7' or 'arte2.3.8')">
        <div><xsl:apply-templates/></div>
        <xsl:when test="starts-with($id, 'arte2')">
                <div><xsl:apply-templates/></div>
            </xsl:when>
    </xsl:if>
     -->
       <!-- <xsl:choose>
            
            <xsl:when test="matches($id, $active_div, $active_div_front)">
                <div><xsl:apply-templates/></div>
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose> -->
</xsl:template>
    
<xsl:template match="p">
        <div class="paragraph"><xsl:apply-templates/></div>
</xsl:template>
    
<xsl:template match="foreign[@xml:lang='cvz']">
    <xsl:variable name="id">
        <xsl:value-of select="@xml:id"/>
    </xsl:variable>
    <xsl:variable name="mytable">
        <xsl:copy-of select="$interlins//linp:table[@id= $id]"/>
    </xsl:variable>
    <xsl:choose>
        <xsl:when test="$mytable!=''">
            <div class="popover-markup"><mark class="trigger"><xsl:apply-templates/></mark>
                <div class="head hide">Morphological Analysis<button type="button" id="close" class="close"> X </button></div>
                <div class="content hide"><xsl:copy-of select="$mytable"/></div>
            </div>
        </xsl:when>
        <xsl:otherwise>
            <mark><xsl:apply-templates/></mark>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="foreign[@xml:lang='lat']">
    <em><xsl:apply-templates/></em>
</xsl:template>

<xsl:template match="pc[node()='¶']">¶</xsl:template>
    
<xsl:template match="choice">
        <xsl:choose>
            <xsl:when test="abbr">
                <xsl:value-of select="abbr"/>
            </xsl:when>
            <xsl:when test="reg[@type='lat']">
                <xsl:apply-templates select="reg[@type='lat']"/>
            </xsl:when>
            <xsl:when test="reg[@type='spanish']">
                <!--<xsl:value-of select="reg[@type='spanish']"/>-->
                <xsl:apply-templates select="reg[@type='spanish'], pc[@type='hyphen']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="reg[@type='spacing'], pc[@type='hyphen']"/>
            </xsl:otherwise>
        </xsl:choose>
</xsl:template>
    
</xsl:stylesheet>