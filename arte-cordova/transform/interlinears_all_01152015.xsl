<?xml version="1.0" encoding="UTF-8"?>
<!--Interlinears for the Arte transcription
Should be transformed to interlinears_all_xml in ... folder. Before it can be used on the flex export,
you need to add linp elements to the top and bottom-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output indent="yes" method="xhtml" encoding="UTF-8"/>
   
    <!-- The section below produces the first part of the xmlid as a variable called idp3 -->
    
    <xsl:template match="text()"><xsl:value-of select="normalize-space(.)"/></xsl:template>
    <!-- 
        <table xmlns="http://ds.haverford.edu/linp" class="table table-hover" id="arte2.01_03">
            <tr>
               <td>
                  pěni
                  
               </td>
               <td>
                  gönnǎ
                  
               </td>
            </tr>
            <tr>
               <td>
                  person
                  
               </td>
               <td>
                  female
                  
               </td>
            </tr>
            <tr>
               <td colspan="4">
                  'woman'
                  
               </td>
            </tr>
            <tr/>
         </table> -->
    <!-- This section creates the wrapper html page for the tables -->
    <xsl:template match="lingPaper">
        <linp xmlns="http://ds.haverford.edu/linp">
           
                <head>
                    <meta charset="utf-8"></meta>
                    
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
                    
                    
                    <meta name="description" content=""></meta>
                    <meta name="author" content=""></meta>
                    
                    <title>TestymcTesterson</title>
                    
                        <!-- Bootstrap core CSS -->
                    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"/>
                        
                   
                     
                </head>
           
             <xsl:for-each select="//interlinear">
                 <xsl:variable name="id">
                     <xsl:value-of select="count(preceding::example)"></xsl:value-of>
                 </xsl:variable>
                 <div class="container" id="zap_{$id}">
                     <div class="row">
                         <xsl:for-each select="phrase/words/iword/morphemes/morphset/morph/item[@type='txt']">
                            <div class="col-sm-2">
                                <xsl:value-of select="."></xsl:value-of>
                            </div>
                         </xsl:for-each>
                     </div>
                     <div class="row">
                     <xsl:for-each select="phrase/words/iword/morphemes/morphset/morph/item[@type='gls']">
                             <div class="col-sm-2">
                                 <xsl:value-of select="."></xsl:value-of>
                             </div>
                     </xsl:for-each>
                     </div>
                    <xsl:for-each select="phrase/item[@lang='en-literal']">
                        <div class="row" id="english">
                            <div class="col-sm-12">
                                '<xsl:value-of select="."></xsl:value-of>'
                            </div>
                        </div>
                    </xsl:for-each>
                 </div>
                 <hr />
            </xsl:for-each>
        </linp>
    </xsl:template>
</xsl:stylesheet>