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
        <annotation gi="type"/>
      </range>
      <range gi="tale"><!-- Nested narrative, either complete or fragmentary -->
        <annotation gi="glss"/>
      </range>
      <range gi="batl">
        <annotation gi="who"/>
      </range>
      <range gi="simile">
        <annotation gi="glss"/>
      </range>
      <range gi="echo"><!-- For repeated lines -->
        <annotation gi="cf"/>
      </range>
      <range gi="song"><!-- Noteworthy for aural effect or onomatopoeia --></range>
      <range gi="scene">
        <annotation gi="set"/>
      </range>
      <range gi="speech">
        <annotation gi="by"/>
        <annotation gi="to"/>
      </range>
      <range gi="para"/>
      <range gi="q"/>
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
  
  <xsl:variable name="ranges" select="//start | //empty"/>
  
  <xsl:template match="/LMNL" priority="202">
    <xsl:on-non-empty>
      <model>
        <xsl:apply-templates select="$scheme" mode="spill"/>
      </model>
      <!--<xsl:copy-of select="$scheme"/>-->
    </xsl:on-non-empty>
    <xsl:apply-templates/>
    <xsl:on-empty>
      <LOOKING_GOOD ranges="{ count( $ranges ) }"
        extent="{ string-length( /*/text => string-join('') ) }">
        <xsl:for-each-group select="$ranges" group-by="@gi">
          <xsl:sort select="count(current-group())"/>
          <range gi="{ (current-grouping-key()[normalize-space(.)],'[ANON]')[1] }"
            count="{ current-group() => count() }">
            <xsl:for-each-group select="current-group()/annotation" group-by="@gi">
              <annotation gi="{ (current-grouping-key()[normalize-space(.)],'[ANON]')[1] }"
                count="{ current-group() => count() }"
                distinct="{ current-group()/string(.) => distinct-values() => count()}"/>
            </xsl:for-each-group>
          </range>
        </xsl:for-each-group>
      </LOOKING_GOOD>
    </xsl:on-empty>
  </xsl:template>
  
  <xsl:variable name="anon" as="function(*)"
    select="function($gi as attribute()) as xs:string { ( if (string($gi)) then ('''' || string($gi) || '''') else '(ANONYMOUS)') }"/>
    
  <xsl:template match="start[not(@gi = $scheme/range/@gi)]">
    <finding>Unexpected range type { $anon(@gi) } at line { @L }, column { @ch }</finding>
    <xsl:next-match/>
  </xsl:template>
  
  <!-- skipping all annotations on unrecognized ranges -->
  <xsl:template priority="101" match="*[not(@gi = $scheme)]/@gi/annotation"/>
  
  <!-- Catches annotations out of place as well as unknowns -->
  <xsl:template priority="99" match="annotation[
    not(../@gi = $scheme/*/annotation[@gi = current()/@gi]/../@gi)]">
    <finding>Unexpected annotation type { $anon(@gi) } appearing on range '{ ../@gi }' at line { @L }, column { @ch }</finding>
    <xsl:next-match/>
  </xsl:template>
  
  <xsl:template match="range" mode="spill">
    <xsl:text>&#xA;[{ @gi }{ child::annotation/(' [' || @gi || ']') => string-join('') }]</xsl:text>
  </xsl:template>
</xsl:stylesheet>