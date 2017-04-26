<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xhtml"/>

  <!-- only transform inside the <text> node -->
  <xsl:template match="text">
    <div>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- transform <head> -->
  <xsl:template match="head">
    <h4>
      <xsl:apply-templates/>
    </h4>
  </xsl:template>
  <!-- don't transform <head type='outline'> -->
  <xsl:template match="head[@type='outline']"></xsl:template>

  <!-- transform (preserve) <div> -->
  <xsl:template match="div[not(@xml:id)]">
    <!-- courtesy of stackoverflow.com/questions/26999058/, copies the div attributes -->
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <!-- transform <p> -->
  <xsl:template match="p">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>
  <xsl:template match="p[@rend='center']">
    <p class="center">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- transform <lb> -->
  <xsl:template match="lb">
    <br/>
  </xsl:template>

  <!-- transform <fw> -->
  <xsl:template match="fw[@type='catch']|fw[@type='catchword']">
    <div class="catch">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="fw[@type='sig']">
    <div class="sig">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- transform <hi> -->
  <xsl:template match="hi[@rend='italic']|hi[@rend='italics']">
    <span class="italic">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- transform <foreign> -->
  <xsl:template match="foreign[@rend='italic']|foreign[@rend='italics']">
    <span class="italic">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
</xsl:stylesheet>
