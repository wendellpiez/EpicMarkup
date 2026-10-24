<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  exclude-result-prefixes="xs math"
  version="3.0"
  expand-text="true"
  xmlns="http://www.w3.org/1999/xhtml"
  xpath-default-namespace="http://www.w3.org/1999/xhtml">
  
  <!-- Creates a popover element for any 'title' attribute -->
  
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="*[exists(@title)]">
    <xsl:variable name="thisID">{ local-name() }_{ generate-id(.) }</xsl:variable>
    <span onclick="{ $thisID }.classList.toggle('hiding'); this.classList.toggle('hiding')">
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="style">anchor-name: --{$thisID }</xsl:attribute>
      <!--<xsl:attribute name="popovertarget">{ local-name(..) }_{ generate-id(..) }</xsl:attribute>
-->      <xsl:apply-templates/>
    </span>
    <div class="defn vocab hiding" id="{ $thisID }"
      style="position-anchor: --{ $thisID }; top: anchor(--{ $thisID } bottom);
      left: anchor(--{$thisID} right)">
      <xsl:apply-templates mode="glossing" select="@data-trans, @data-stem, @data-morph"/>
    </div>
  </xsl:template>
  
  <xsl:template match="*[@title]/@class">
    <xsl:attribute name="class">{ . } vocab hiding</xsl:attribute> 
  </xsl:template>

  <xsl:template mode="glossing" match="@data-trans">
    <p class="trans"> &#8212; { . }</p>    
  </xsl:template>
  
  <xsl:template mode="glossing" match="@data-stem">
    <p class="stem"><a href="https://logeion.uchicago.edu/{ . }" target="logeion">{ . }</a></p>    
  </xsl:template>
  
  <xsl:template mode="glossing" match="@data-morph">
    <p class="morph">{ . }</p>    
  </xsl:template>
  
  <xsl:template match="@title | @data-stem | @data-morph | @data-trans"/>
    
  
  
</xsl:stylesheet>