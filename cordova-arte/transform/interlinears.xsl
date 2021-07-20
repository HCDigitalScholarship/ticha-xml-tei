<?xml version="1.0" encoding="UTF-8"?>
<!--Interlinears for the Arte transcription-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output indent="yes" method="xhtml" encoding="UTF-8"/>
   <!--The Identity Transform. Here for no reason. 
       <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>-->
    <!-- The section below produces the first part of the xmlid as a variable called idp3 -->
    <xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/></xsl:template>
    <xsl:variable name="idp3">
        <xsl:analyze-string select="//frontMatter/title" regex="^(.+?) (.+?) ">
            <xsl:matching-substring>
                <xsl:variable name="xmlid1">
                    <xsl:value-of select="lower-case(.)"/>  
                </xsl:variable>
                <xsl:variable name="idp11">
                    <xsl:value-of select="translate($xmlid1,' ','')"/>
                </xsl:variable>
                <xsl:value-of select="$idp11"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:variable>
    <!-- This section creates the wrapper html page for the tables -->
    <xsl:template match="lingPaper">
        <linp xmlns="http://ds.haverford.edu/linp">
            
                <!-- For each interlin element, first create div in which the table will live. Then,
                    creat a variable based on the position of the whole interlin, as that's the level
                    that the tei should be encoded at. -->
                <xsl:for-each select="//interlinear">
                        <xsl:variable name="id">
                            <xsl:value-of select="concat($idp3,'_',0,position())"/></xsl:variable>
                <table class="table table-hover" id="{$id}">
                    <!--<xsl:for-each select="lineGroup/line[not(*/*/@lang='en-wordGloss')]">
                        <tr> 
                            <xsl:for-each select="wrd">
                            <td>
                                <xsl:value-of select="."/>
                            </td>
                            </xsl:for-each>
                            
                        </tr> 
                    </xsl:for-each>-->
                    <xsl:for-each select="lineGroup/line[(*/*/@lang='zab-x-colon-morpheme')]">
                        <tr>
                            <xsl:for-each select="wrd">
                                <td><xsl:value-of select="."/></td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                    <xsl:for-each select="lineGroup/line[(*/*/@lang='en-lexGloss')]">
                        <tr>
                            <xsl:for-each select="wrd">
                                <td><xsl:value-of select="."/></td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                    <xsl:for-each select="free[@lang='en-free']">
                        <tr>
                            <td colspan="4">'<xsl:value-of select="."/>'
                            </td>
                        </tr>
                    </xsl:for-each>
                    <tr>
                        <xsl:for-each select="wrd">
                            <td><xsl:value-of select="."/></td>
                        </xsl:for-each>
                    </tr>
                    
                </table>
                    <br/>
            </xsl:for-each>
        </linp>
    </xsl:template>
</xsl:stylesheet>