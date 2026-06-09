<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step  version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-inline-prefixes="#all">

  <p:import href="src/epic-markup.xpl"/>
  
  <!-- Use pipeline ../Sources/ACQUIRE_PerseusDL-TEI.xpl to acquire a copy -->
  <p:input port="source" href="../Sources/PerseusDL/tlg0012.tlg001.perseus-grc2.xml"/>

  
  <!-- 
  x 1st - p:viewport replace text/div contents with their LMNL serializations
    2nd - for-each book - split out and cache LMNL for comparison
  
    3rd - push through mods XSLTs
          for-each text/div in source
            write improved LMNL out again for comparison

  
  -->

  <p:delete match="/processing-instruction()"/>
  <p:identity name="PerseusDL-TEI"/>
  
  <p:viewport match="/TEI/text/body/div/div" name="each_book">
    <p:variable name="book00" select="p:iteration-position() => format-number('00')"/>
    
    <p:delete match="l/text()[normalize-space(.) => not()]"/>
    <p:xslt name="lmnlizer">
      <p:with-input port="stylesheet" href="../lib/Laminator/lib/common/xml-to-lmnl.xsl"/>
    </p:xslt>
    
    <p:text-replace pattern="^\s+" replacement="" flags="m"/>
    <p:variable name="lmnl" select="."/>
    
    <EPIC:store href="../data/Iliad/lmnl/PerseusDL_src/book{ $book00 }.lmnl" hint="PerseusDL source, encoded in LMNL"/>
    
    <p:delete match="/*/node()">
      <p:with-input port="source"    pipe="current@each_book"/>
    </p:delete>
    <p:insert match="/*" position="first-child">
      <p:with-input port="insertion" expand-text="true">
        <ab>{ $lmnl }</ab>
      </p:with-input>
    </p:insert>
  </p:viewport>
  
  <EPIC:teiHeader_update/>
  
  <EPIC:store href="../data/Iliad/tei/PerseusDL_lmnl-tei.xml" hint="PerseusDL TEI, with books in LMNL syntax"/>
  
  
  <!--<p:xslt>
    <p:with-input port="source" pipe="@PerseusDL-TEI"/>
    <p:with-input port="stylesheet" href="src/tei/perseus-fixup.xsl"/>
  </p:xslt>-->



  <!-- Off we go -->

  <!--next: for-each /TEI/text/body/div/div
  
  step build_ILIAD
    $bookN = @n => format-number(number(),'01')
    apply mods
    write LMNL
    write a TEI (injecting a header, milestoning elements)
    write results - HTML, SVG, variant XML
  run for any/all
  
  build mods table, per book
    q adjustments - in an XSLT
      corrections
      @who and @toWhom
    interesting epithets
    4th wall 2.119 ἐσσομένοισι 2.325
      
  -->

 <!-- <p:filter select="/TEI/text/body/div">
    <p:with-input port="source" pipe="result@tracks-TEI"/>
  </p:filter>

  <p:xslt>
    <p:with-input port="stylesheet" href="src/perseus_Iliad-adjust.xsl"/>
  </p:xslt>

  <p:add-attribute match="/*" attribute-name="metadata" attribute-value="ILIAD_teiHeader.xml"/>

  <p:xslt>
    <p:with-input port="stylesheet" href="src/adjustedIliad-to-sawteeth.xsl"/>
  </p:xslt>

  <p:store href="data/ILIAD.lmnl" message="Saving LMNL syntax ILIAD"/>

  <p:store href="data/ILIAD_{ current-date() => format-date('[Y][M01][D01]') }.lmnl"
    message="Saving LMNL syntax ILIAD (cache copy)"/>

  <p:hash algorithm="crc" version="32" match="/" value="{ string(.) }"
    message="making hash for { string(.) => substring(1, 20) }" name="hashing">
    <p:with-input port="source">
      <hash/>
    </p:with-input>
  </p:hash>

  <p:variable name="crc32-hash" select="string(/)"/>

  <p:sink/>-->

  <!--(Merge in quote markup?)-->


  <!-- Build index to quotes -->
  <!--<q from="101" to="120" who="Agamemnon" toWhom="Achilles Achaians"/>-->
  <!--<p:xslt>
    <p:with-input port="source" pipe="@tracks-TEI"/>
    <p:with-input port="stylesheet" href="src/tei/index-quotes.xsl"/>
  </p:xslt>
  
  <p:store href="data/ILIAD_quotes-index.xml" message="Saving ILIAD quotes index"/>-->

 
  <!--<p:insert match="teiHeader/revisionDesc" position="first-child">
    
    <p:with-input port="insertion">
      <change who="Wendell Piez" when="{ current-date() => format-date('[Y]-[M01]-[D01]')}"
        >Enhanced by XProc modification ....</change>
    </p:with-input>
  </p:insert>-->
  
</p:declare-step>