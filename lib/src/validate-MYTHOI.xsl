<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  exclude-result-prefixes="xs math"
  expand-text="true"
  xpath-default-namespace="http://wendellpiez.com/ns/xMNML"
 >
  
  <!-- XSLT pops up results for unexpected inputs -->
  
  <xsl:mode on-no-match="shallow-skip"/>
  
  <xsl:variable name="scheme" as="element()"
    xmlns="http://wendellpiez.com/ns/xMNML">
   <!-- In namespace so it is visible w/o prefixes and xpath-default set as above-->
    <scheme>
      <range gi="BOOK">
        <annotation gi="n"/>
        <annotation gi="ed"/>
        <annotation gi="src"/>
        <annotation gi="repo"/>
      </range>
      <range gi="addr"/><!-- In second person, to a general audience -->
      <range gi="prayer">
        <annotation gi="by"/>
        <annotation gi="to"/>
      </range>
      <range gi="trope"><!-- More or less any trope except simile and onomatopoeia -->
        <annotation gi="glss"/>
      </range>
      <range gi="tale"><!-- Nested narrative, either complete or fragmentary -->
        <annotation gi="glss"/>
      </range>
      <range gi="simile">
        <annotation gi="glss"/>
      </range>
      <range gi="echo"><!-- For repeated lines --></range>
      <range gi="song"><!-- Noteworthy for aural effect or onomatopoeia --></range>
      <range gi="scene">
        <annotation gi="set"/>
      </range>
      <range gi="speech">
        <annotation gi="by"/>
        <annotation gi="to"/>
      </range>
      <range gi="para"/>
      <range gi="l">
        <annotation gi="n"/>
      </range>
      <range gi="assembly">
        <annotation gi="who"/>
      </range>
      <range gi="force">
        <annotation gi="of"/>
      </range>
    </scheme>
  </xsl:variable>

  <xsl:template match="/">
    <report>
      <xsl:apply-templates/>
    </report>
  </xsl:template>
  
  <xsl:template match="/*">
    <SKIPPED_CHECK/>
  </xsl:template>
  
  <xsl:template match="/LMNL" priority="202">
    <xsl:apply-templates/>
    <xsl:on-non-empty>
      <model>
        <xsl:apply-templates select="$scheme" mode="spill"/>
      </model>
    </xsl:on-non-empty>
    <xsl:on-empty>
      <LOOKING_GOOD/>
    </xsl:on-empty>
  </xsl:template>
  
  <xsl:variable name="anon" as="function(*)" select="function($gi as attribute()) as xs:string { ( if (string($gi)) then ('''' || string($gi) || '''') else '(ANONYMOUS)') }"/>
    
  <xsl:template match="start[not(@gi = $scheme/range/@gi)]">
    <finding>Unexpected range type { $anon(@gi) }' at line { @L }, column { @ch }</finding>
    <xsl:next-match/>
  </xsl:template>
  
  <!-- Catches annotations out of place as well as unknowns -->
  <xsl:template priority="99" match="annotation[
    not(../@gi = $scheme/*/annotation[@gi = current()/@gi]/../@gi)]">
    <finding>Unexpected annotation type { $anon(@gi) } appearing on range '{ ../@gi }' at line { @L }, column { @ch }</finding>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="range" mode="spill">
    <xsl:text> [{ @gi }{ child::annotation/(' [' || @gi || '}{]') => string-join('') }]</xsl:text>
  </xsl:template>
</xsl:stylesheet>