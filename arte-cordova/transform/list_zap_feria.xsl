<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:template match="document">
    <xsl:apply-templates />
  </xsl:template>
  <!-- <xsl:template match="//word/words/word">
    <li>
    <xsl:value-of select="item[@type='txt']" /> : <xsl:value-of select="morphemes/morph/item[@type='gls']" />
    </li>
  </xsl:template> -->
  <xsl:template match="//interlinear-text/paragraphs/paragraph/phrases/word/item">
    <xsl:value-of select="//item[@type='lit']"/>
  </xsl:template>
</xsl:stylesheet>

