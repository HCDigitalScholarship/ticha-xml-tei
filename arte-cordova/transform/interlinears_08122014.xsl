<?xml version="1.0" encoding="UTF-8"?>
<!--Interlinears for the Arte transcription
Should be transformed to interlinears_08122014.html in the jekyll/_includes folder -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output indent="yes" method="xhtml" encoding="UTF-8"/>
   <!--The Identity Transform. Here for no reason. 
       <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>-->
    
    <!-- thinking through the xmlid's for the zapotec. xmlid_will_become the letters (make a string that is the concatanation of
        the lowercase, and stripped of accents word plus some code. 
        So, we'll match based on word rather than based on xml:id.
    -->
    <!-- The section below produces the first part of the xmlid as a variable called idp3 -->
    
    <xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/></xsl:template>
    
    <!-- This section creates the wrapper html page for the tables -->
    <xsl:template match="//endnote"/>
    <xsl:template match="lingPaper">
        <linp xmlns="http://ds.haverford.edu/linp">
                <!-- For each interlin element, first create div in which the table will live. Then,
                    creat a variable based on the position of the whole interlin, as that's the level
                    that the tei should be encoded at. -->
                <xsl:for-each select="//interlinear">
                    
                    <xsl:variable name="fullword">
                        <xsl:for-each select="lineGroup/line/wrd/langData"><xsl:value-of select="."/></xsl:for-each>
                    </xsl:variable>
                    
                    <xsl:variable name="wordname1">
                        <xsl:value-of select="concat($fullword,1)"></xsl:value-of>
                    </xsl:variable>
                    <xsl:variable name="wordname">
                        <xsl:value-of select="encode-for-uri($wordname1)"/>
                    </xsl:variable>
                        <xsl:variable name="id">
                            <!--<xsl:value-of select="concat($idp3,'_',0,position())"/></xsl:variable>-->
                            <xsl:value-of select="$wordname"/>
                        </xsl:variable>
                    Wordname: <xsl:value-of select="$wordname"></xsl:value-of><br/>
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
                                <td><xsl:apply-templates/></td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                    <xsl:for-each select="lineGroup/line[(*/*/@lang='en-lexGloss')]">
                        <tr>
                            <xsl:for-each select="wrd">
                                <td><xsl:apply-templates/></td>
                            </xsl:for-each>
                        </tr>
                    </xsl:for-each>
                    <xsl:for-each select="free[@lang='en-free']">
                        <tr>
                            <td colspan="4"><xsl:apply-templates/>
                            </td>
                        </tr>
                    </xsl:for-each>
                    <tr>
                        <xsl:for-each select="wrd">
                            <td><xsl:apply-templates/></td>
                        </xsl:for-each>
                    </tr>
                    
                </table>
                    <br/>
            </xsl:for-each>
        </linp>
    </xsl:template>
</xsl:stylesheet>