<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xpath-default-namespace="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:linp = "http://ds.haverford.edu">
    
    <xsl:output indent="yes" method="xhtml"/>
    
    <xsl:template match="teiHeader"/>
    
    
    <xsl:template match="text">
        <html>
            <head>
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
                        <title>Ticha ticha ticha</title>
                        <meta name="description" content=""/>
                            <meta name="viewport" content="width=device-width, initial-scale=1"/>
                                
                                <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
                                    <style>
                                        body {
                                        padding-top: 50px;
                                        padding-bottom: 20px;
                                        }
                                    </style>
                                    <link rel="stylesheet" href="bootstrap/css/bootstrap-theme.min.css"/>
                                        <link rel="stylesheet" href="bootstrap/css/main.css"/>
                                            
                                            <script src="bootstrap/js/vendor/modernizr-2.6.2-respond-1.1.0.min.js"></script>
            </head>
            <body>
                <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
              
                
                <!-- Main jumbotron for a primary marketing message or call to action -->
                
                        <xsl:apply-templates/>
                        
                       
                
               
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="div">
        <!-- <div>[expand title="Test"]-->
        <xsl:if test="head[@type='outline']">
            <h4 style="text-align: right;"><span style="color: #999999;"><xsl:value-of select="head[@type='outline']"/></span></h4>
        </xsl:if>
        <xsl:if test="head[@type='cordova']">
            <h4 align="center"><xsl:value-of select="head[@type='cordova']"/></h4>
        </xsl:if>
        <xsl:apply-templates/>
        <!--  [/expand]</div>-->
    </xsl:template>
    
    <xsl:template match="p">
        <div><p><xsl:apply-templates/></p></div>
    </xsl:template>
    
    <xsl:template match="foreign[@xml:lang='cvz']">
        <xsl:variable name="id">
            <xsl:value-of select="@xml:id"/>
        </xsl:variable>
        <strong><dfn id="{$id}"><xsl:value-of select="."/></dfn></strong>
    </xsl:template>
    
    <xsl:template match="foreign[@xml:lang='lat']">
        <dfn style="color:red;"><xsl:value-of select="."/></dfn>
    </xsl:template>
    
    <xsl:template match="corr">
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="replace(., '&#x0A; *', '')"/>
    </xsl:template>
    
    <xsl:template match="fw[@type='catchword']">
        <br/><br/>
        <span style='italic'><xsl:apply-templates/></span>
    </xsl:template>
    
    
    <xsl:template match="pb[@type='arte']">
        <div style="page">
            <xsl:variable name="url" select="following-sibling::pb/@facs" />
            <a href="{$url}" target="blank"><xsl:value-of select="@n" /></a>
        </div>
    </xsl:template>
   
    <xsl:template match="fw[@type='PageNum']">
        <div class="pagenum">
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="lg">
        <xsl:choose>
            <xsl:when test="@type = 'couplet'">
                <xsl:if test="count(l) != 2">
                    <xsl:message terminate="yes">Couplets must have 2 lines</xsl:message>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@type = 'tercet'">
                <xsl:if test="count(l) != 3">
                    <xsl:message terminate="yes">Tercets must have 3 lines</xsl:message>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@type = 'quatrain'">
                <xsl:if test="count(l) != 4">
                    <xsl:message terminate="yes">Quatrains must have 4 lines</xsl:message>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="yes">Found unknown stanza type</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
        
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="l">
        <tr>
            <td style="width: 30">
                <xsl:value-of select="@n"/>
            </td>
            <td>
                <xsl:if test="../@type = 'quatrain' and @n mod 2 = 0">
                    <xsl:attribute name="style">text-indent: 20px</xsl:attribute> 
                </xsl:if>
                <xsl:apply-templates/>
            </td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet> 