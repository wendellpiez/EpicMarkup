<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  exclude-inline-prefixes="#all"
  type="mnml:mnml-lmnl_wf-check" version="3.0">


  <!-- Accepts purportely MNML markup and tells us if it parses.
      
      Useful for go/no-go testing of parse examples ('known good' and 'known bad')
      cf TEST_WFCHECK-SAWTEETH.xpl
        
        
      output ports:
          report - tells us about what came back, xMNML or error
          result - the xMNML if it comes back, otherwise the pipeline error report

    -->

  <p:import href="Laminator/lib/xMNML/in/sawtooth-syntax/sawteeth-to-xMNML.xpl"/>

  <p:input  port="source" content-types="text/plain"/>
  
  <p:output port="syntax-report"  primary="true"  pipe="@summary"
    serialization="map { 'indent': true(),
    'omit-xml-declaration': true() }"/>
  
  <p:output port="tagging-report" primary="false" pipe="@mythoi-validation"
    serialization="map { 'indent': true(), 'omit-xml-declaration': true() }"/>
  
  <!--<p:output port="result" pipe="result@parse_result"
    serialization="map { 'indent': true(), 'omit-xml-declaration': true() }"/>-->

  <p:option name="max-tagging-depth" as="xs:nonNegativeInteger" select="xs:nonNegativeInteger(1000)"/>
  
  <p:option   name="show-errors"    select="'show'" as="xs:string"/>
  <p:variable name="showing-errors" select="$show-errors = ('show','yes','true','1')"/>
  
  <p:variable name="filename"
    select="p:document-property(.,'base-uri') => tokenize('/') => reverse() => head()"/>

  <p:variable name="echo" select="string(.) ! normalize-space(.)"/>

  <p:try message="Parsing { $filename } - nominal tagging stack limit is { $max-tagging-depth }">
    <mnml:sawteeth-to-xMNML>
      <p:with-option name="max-tagging-depth" select="$max-tagging-depth"/>
    </mnml:sawteeth-to-xMNML>
    <!-- Extend to Schematron and capture report here -->
    <p:catch>
      <p:identity/>
      <p:wrap-sequence wrapper="RETURNS"/>
      <p:insert match="/*" position="first-child">
        <p:with-input port="insertion">
          <INPUT>{ $echo }</INPUT>
        </p:with-input>
      </p:insert>
      <p:namespace-rename to="http://wendellpiez.com/ns/Laminator" apply-to="elements"/>
    </p:catch>
  </p:try>

  <p:identity name="parse_result"/>

  <p:choose>
    <p:when test="exists(/mnml:LMNL)">
      <p:identity>
        <p:with-input>
          <WHEE file="{ $filename }"
            echo="{ substring($echo,1,30) }{ substring($echo,30)[normalize-space()] ! '...' }"/>
        </p:with-input>
      </p:identity>
    </p:when>
    <p:otherwise>
      <p:identity>
        <p:with-input>
          <OOPS file="{ $filename }"
            echo="{ substring($echo,1,30) }{ substring($echo,30)[normalize-space()] ! '...' }"/>
        </p:with-input>          
      </p:identity>
      <p:if test="$showing-errors">
        <p:insert match="/OOPS" position="first-child">
          <p:with-input port="insertion" pipe="@parse_result" select="/*/c:errors/c:error/(*:message | cx:cause)"/>
        </p:insert>
        <p:namespace-delete prefixes="cx"/>
      </p:if>
    </p:otherwise>
  </p:choose>

  <p:identity name="summary"/>

  <p:group name="mythoi-validation">
    <p:xslt>
      <p:with-input port="source" pipe="result@parse_result"/>
      <p:with-input port="stylesheet" href="src/validate-MYTHOI.xsl"/>
    </p:xslt>
    
  </p:group>
    
</p:declare-step>