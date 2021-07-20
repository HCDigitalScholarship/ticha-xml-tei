<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:linp="http://ds.haverford.edu/linp">
   <!-- This version has no interlinears and is a pure, as transcribed, unregularized version.
       When applying this transformation, save it as original_text in the /jekyll/_includes-->
    
    
    <xsl:variable name="interlins" select="document('../../interlins_all.xml')/linp:linp"/>
    <xsl:variable name="tableid" select="$interlins//linp:table/@id"></xsl:variable>
    <xsl:variable name="zapotec" select="//foreign[@xml:lang='cvz']"/>
    <xsl:variable name="foreignid" select="$zapotec/@xml:id"/>    
    <xsl:variable name="interdiv" select="$interlins/linp:html/linp:body/linp:table"/>  
    
    <xsl:template match="corr"/> 
    <xsl:template match="expan"/>
    <xsl:template match="reg"/>
    <xsl:template match="orig">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="teiHeader"/>
    <xsl:template match="text">
        <xsl:comment>This version of the arte was transformed using original.xsl. It includes original spacing, spelling, forme works and line breaks.</xsl:comment>
            <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="head">
        <xsl:choose>
            <xsl:when test="@type='outline'">
                <h5 align="left">
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

    <xsl:template match="lb"><br/></xsl:template> 
    
    <xsl:template match="div">
        <div>
           <xsl:apply-templates/>
        </div>
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
        
        <xsl:variable name="name">
            <xsl:value-of select="count(preceding::foreign)"/>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$mytable!=''">
                <div class="popover-markup"><mark class="trigger"><xsl:apply-templates/></mark>
                    <div class="head hide">Morphological Analysis<button type="button" id="close" class="close"> X </button></div>
                    <div class="content hide"><xsl:copy-of select="$mytable"/></div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <mark>
                <a>
                    <xsl:attribute name="name">
                        <xsl:copy-of select="$name"></xsl:copy-of>
                    </xsl:attribute>
                <xsl:apply-templates/>
        </a></mark>
            </xsl:otherwise>
        </xsl:choose>
        
      
     
          
       
    </xsl:template>
    
    <xsl:template match="foreign[@xml:lang='lat']">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <xsl:template match="fw[@type='head']">
        <p align="center"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="fw[@type='PageNum']">
        <p class="text-right"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="fw[@type='catchword']">
        <p class="text-right"><xsl:apply-templates/></p>
    </xsl:template>
    
 
<xsl:template match="abbr">
    <xsl:apply-templates/>
</xsl:template>    
    
<xsl:template match="pb[@type='arte']">
        <div class="page">
            <strong><hr class="page-line"/></strong>
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
    
</xsl:stylesheet>

