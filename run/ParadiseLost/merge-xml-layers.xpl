<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://wendellpiez.com/ns/xMNML"
  type="mnml:merge-xml-layers"
  exclude-inline-prefixes="#all">

  <!--    
    Merges two (or more?) XML documents with the same string value for string(/)
      building a single LAYERS instance
        with additional result ports
        - an xMNML version and a LMNL syntax serialization (plain text)
    TODO:
    
    unit testing?
    move this into Laminator repo
    
    Merges two LAYERS instances
    
    -->

  <p:input port="source" sequence="true"/>
                                          <!--
    <p:document href="../../data/ParadiseLost/cache/book01_LINES.xml"/>  
    <p:document href="../../data/ParadiseLost/cache/book01_QUOTES.xml"/>  
    <p:document href="../../data/ParadiseLost/cache/book01-PHRASED.xml"/>
  </p:input>-->
  
  <!--A single XML LAYERS instance results -->
  <p:output port="layers" sequence="false"/>
  <!--<p:output port="xMNML"       sequence="false"/>-->
  <!--<p:output port="LMNL-syntax" sequence="false"/>-->
  
  
    <!--1. all inputs valid to ../../lib/Laminator/lib/LAYERS/rules/MNML-LAYERS.rnc ?
    2. all /*/frontier/string(.) the same? (!= test :-)
    3. bring back unified LAYERS-\p:xslt>
     
  -->
  
  <!-- Pulling inputs into common context for evaluation -->
  <p:wrap-sequence wrapper="mnml:INPUTS"/>
  
  <!--The try/catch bubbles an error up if texts are misaligned -->
  <p:if test="/*/child::*/string(.) != /*/child::*/string(.)">
    <p:try>
      <p:error code="mnml:MISALIGNED-INPUTS">
        <p:with-input>
          <message>Frontiers (string values) of input given are not the same, so documents are not suitable for a MNML LAYERS merge</message>
        </p:with-input>
      </p:error>
      <p:catch name="error-catch">
        <p:identity>
          <p:with-input pipe="error@error-catch"/>
        </p:identity>
      </p:catch>
    </p:try>
  </p:if>
  
  <!--Building LAYERS range sets for each input -->
  <p:for-each>
    <p:with-input select="/mnml:INPUTS/child::*"/>
    <p:xslt>
      <p:with-input port="stylesheet" href="../../lib/Laminator/lib/LAYERS/in/xml-to-LAYERS.xsl"/>
    </p:xslt>      
  </p:for-each>

  <!-- Collecting all range sets into a single document -->
  <p:wrap-sequence wrapper="LAYERS">
    <p:with-input select="/LAYERS/child::*"/>
  </p:wrap-sequence>
  
  <!-- Removing extra frontier representations -->
  <p:delete match="/*/frontier[position() lt last()]"/>
  
  <p:namespace-rename apply-to="elements" to="http://wendellpiez.com/ns/xMNML"/>

  <!-- FIXUP: reassign rIDs, merge layers -->
  
  <!-- TODO: PRODUCE xMNML and LMNL syntax -->


</p:declare-step>
