<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  exclude-result-prefixes="xs math"
  version="3.0"
  expand-text="true">
  
  <!--Enhances inputs with Iliad treebank data at the word level
  requires line break markup e.g. <lb n="5.8"/> to find words in the treebank
  
  
  -->
  
  <xsl:param name="treebank"     select="()" as="document-node( element(treebank) )?"/>
  
  <xsl:param name="translations" select="()" as="document-node( element(LEXICON) )?"/>
  
  <xsl:mode use-accumulators="lineNo" on-no-match="shallow-copy"/>
  
<!-- 
  <word id="1" form="μῆνιν" lemma="μῆνις"
  postag="n - s - - - f a -"
  head="2" relation="OBJ"
  cite="urn:cts:greekLit:tlg0012.tlg001:1.1"/>
  
  -->

  <xsl:key name="word-in-line" match="word" composite="true"
    use="tokenize(@cite,':')[last()], @form"/>
    
    <!-- translations look like this:
  <term count="3">
    <lemma>σελήνη</lemma>
    <def>the moon</def>
  </term>-->
  
  <xsl:key name="english" match="term" use="child::lemma"/>
  
  <!-- MYTHOI source comes in with handy line numbers
       providing navigability to the usage of the word in the treebank
       even while text() appears at multiple levels -->
  <xsl:accumulator name="lineNo" initial-value="'_'">
    <xsl:accumulator-rule match="lb" select="string(@n)"/>
  </xsl:accumulator>

  <xsl:template match="span[contains-token(@class,'spacer')]//text()">
    <xsl:text expand-text="true">{ . }</xsl:text>
  </xsl:template>
    <!--
    Presuming no markup so far has split up words
    Also since this is just Iliad we don't have pesky orthography to worry about
    (since compound words look like regular words etc.)
    splitting tokens around punctuation and whitespace matches the treebank
    -->
  <xsl:template match="text()">
    <xsl:variable name="lno" select="accumulator-before('lineNo')"/>
    <xsl:variable name="punct_ws" expand-text="false">[\p{P}\s]+</xsl:variable>
    <xsl:analyze-string select="." regex="{$punct_ws}">
      <xsl:matching-substring>{ . }</xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:call-template name="mark-word">
          <xsl:with-param name="word" select="."/>
          <xsl:with-param name="lno"  select="$lno"/>
        </xsl:call-template>
      </xsl:non-matching-substring>
    </xsl:analyze-string>    
  </xsl:template>
  
  <xsl:template name="mark-word">
    <xsl:param name="word" as="xs:string" required="yes"/>
    <xsl:param name="lno"  as="xs:string" required="yes"/>
    <xsl:variable name="treebank-listing"
      select="$treebank/key('word-in-line', ($lno, $word))"/>
    
    <xsl:apply-templates select="$treebank-listing[1]" mode="show"/>
    
    <xsl:on-empty>{ $word }</xsl:on-empty>    
  </xsl:template>

  <xsl:template match="word" mode="show">
    <w>
      <xsl:copy-of select="@lemma, @postag, @relation"/>
      <xsl:apply-templates select="key('english', @lemma, $translations)/def"/>
      <xsl:text>{ @form }</xsl:text>
    </w>
  </xsl:template>
  
  <xsl:template match="term/def">
    <xsl:attribute name="english">{ . }</xsl:attribute>
  </xsl:template>
  
</xsl:stylesheet>