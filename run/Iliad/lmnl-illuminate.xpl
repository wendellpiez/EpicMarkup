<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  type="EPIC:lmnl-illuminate"
  exclude-inline-prefixes="#all">

  <!-- 
    Expects a LMNL document on the 'source' port
    
    It is:
      Parsed and converted to XML
        (if it fails, a debuggable result is still written)
      Merged with other source
        Word-level markup (morphology and short definitions
        Out of line Butler translation (1898)

  -->

  <p:import href="../../lib/Laminator/lib/parse_mnml-lmnl.xpl"/>
  
  <p:input port="source">
    <p:document href="../../data/Iliad/lmnl/edited/book02.lmnl" content-type="text/plain"/>
  </p:input>

  <p:output port="mythoi-result" primary="true"  pipe="result@MYTHOI_xml"/>
  
  <p:output port="html-display"  primary="false" pipe="result@html-display"/>
  
  <p:output port="tagged-as-XML"  primary="false" pipe="maybe-xml@deliver-xml" content-types="text/plain"/>
  
  <p:declare-step name="xml-ripper" type="EPIC:xml-ripper">
    <p:input  port="xMNML-in"  primary="true"  content-types="application/xml"/>
    <p:output port="xml-out"   primary="true"  content-types="application/xml"/>
    <p:output port="maybe-xml" primary="false" content-types="text/plain" pipe="@attempting"/>
    
    <p:xslt name="attempting">
      <p:with-input port="stylesheet" href="../../lib/Laminator/lib/xMNML/out/xMNML-xml-ripper.xsl"/>
    </p:xslt>
    <!-- Comes out as a text brick with tags -->
    <p:try>
      <p:cast-content-type content-type="application/xml"/>    
      <p:catch>
        <p:identity>
          <p:with-input>
            <ERROR/>
          </p:with-input>
        </p:identity>
      </p:catch>
    </p:try>
  </p:declare-step>
  

  <p:variable name="baseFile" select="replace( p:document-property(.,'base-uri'), '.*/', '')"/>
  <p:variable name="basename" select="replace( $baseFile, '\..*$', '')"/>

  <p:variable name="bookNo" select="replace($basename,'\D','') => number()"/>
  
  
  <mnml:parse_mnml-lmnl/>

  <!-- line ranges are rewritten as empties
       extent="0" gi='lb' -->
  
  <p:identity>
    <p:with-input pipe="LAYERS"/>
  </p:identity>
  
  <p:group xmlns="http://wendellpiez.com/ns/xMNML">

    <!-- wiping paragraph markup -->
    <p:delete match="range[@gi='para']"/>

    <!-- On empty ranges, @ending is the same as @starting -->
    <p:label-elements match="range[@gi='l']" attribute="ending" label="@starting"/>

    <!--Switch up the range name and we're done -->
    <p:add-attribute match="range[@gi='l']" attribute-name="gi" attribute-value="lb"/>
    
    <p:add-attribute match="range[@gi='simile']/annotation[empty(@gi)]" attribute-name="gi" attribute-value="glss"/>
    
  </p:group>
          
  <p:xslt>
    <p:with-input port="stylesheet" href="../../lib/Laminator/lib/LAYERS/out/inscribe-xMNML.xsl"/>
  </p:xslt>

  <EPIC:xml-ripper name="deliver-xml"/>

  <p:identity name="MYTHOI_xml"/>
  
  <!-- MYTHOI XML does *not* have word-level markup -->
  <!-- Adding word-level glossing from the treebank for display -->
  <p:group use-when="true()">
    <p:variable name="ILIAD-treebank" select="/"
      href="../../Sources/PerseusDL/tlg0012.tlg001.perseus-grc1.tb.xml"/>

    <!-- Adding word-level glossing from the treebank for display -->
    <p:variable name="ILIAD-englished" select="/" href="../../Sources/Scaife/Iliad_lexicon_en.xml"/>


    <p:xslt name="glossed-MYTHOI" message="Glossing vocabulary, book { $bookNo } -"
      parameters="map { 'treebank': $ILIAD-treebank,
                      'translations': $ILIAD-englished }">
      <p:with-input port="stylesheet" href="mythoi-word-markup.xsl"/>
    </p:xslt>
  </p:group>
  
  <!-- Next ... merge in overlays from external LMNL files? -->
  
  <!-- HTML next -->
  <p:xslt name="html">
    <!--<p:with-input port="source" pipe="@MYTHOI_xml"/>-->
    <p:with-input port="stylesheet" href="mythoi-htmlbody.xsl"/>
  </p:xslt>
  
  <!-- XSLT pulls word-level vocabulary from attributes into elements for page display -->
  <p:xslt>
    <p:with-input port="stylesheet" href="html-popoverer.xsl"/>
  </p:xslt>

  <p:insert match="/*" position="last-child">
    <p:with-input port="insertion" pipe="result"/>
    <p:with-input port="source">
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head>
          <title>ILIAD ILLUMINATED Book { $bookNo }</title>
        </head>
      </html>
    </p:with-input>
  </p:insert>

  <p:group xmlns="http://www.w3.org/1999/xhtml">
    <p:variable name="last" select="$bookNo - 1"/>
    <p:variable name="next" select="xs:integer($bookNo) + 1" as="xs:integer"/>

    <p:insert match="nav" position="last-child">
      <p:with-input port="insertion">
        <div class="linkbox">
          <a href="ILIAD-illuminated_book{ format-number($last,'00') }.html">Book { $last }</a>
          <span> Book { $bookNo }</span>
          <a href="ILIAD-illuminated_book{ format-number($next,'00') }.html">Book { $next }</a>
        </div>
      </p:with-input>
    </p:insert>

    <p:delete match="nav//a[matches(@href,'(00|25).html$')]"/>
    
    <p:delete match="nav//a[number(replace(@href,'\D','')) gt 5]"
    message="NOTICE: REMOVING links to books after Book 5"/>
    
    <p:variable name="illuminated-css" select=".">
      <p:document href="mythoi-illuminated.css" content-type="text/css"/>
    </p:variable>

    <p:insert match="/*/head" position="last-child">
      <p:with-input port="insertion">
        <style xml:space="preserve" type="text/css">{ $illuminated-css ! normalize-space(.) }</style>
      </p:with-input>
    </p:insert>

  </p:group>
  
  <p:identity name="html-display"/>

</p:declare-step>