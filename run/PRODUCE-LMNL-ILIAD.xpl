<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns" xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0" exclude-inline-prefixes="#all">

  <!-- Purpose: From downloaded PerseusDL source data:

    Produce a LMNL-encoded version (in a TEI wrapper, with metadata)
    Produce LMNL versions - both extracted, and revised and enhanced
    
    This XProc executes in 32 sec in oXygen 28.1, but only 12 sec
    when run from the CLI using a recent XML Calabash (script calling Java)
    
  -->
  
  <p:import href="src/epic-markup.xpl"/>

  <!-- Use pipeline ../Sources/ACQUIRE_PerseusDL-TEI.xpl to acquire a copy -->
  <p:input port="source" href="../Sources/PerseusDL/tlg0012.tlg001.perseus-grc2.xml"/>

  <p:delete match="/processing-instruction()"/>
  <p:identity name="PerseusDL-TEI"/>

  <p:viewport match="/TEI/text/body/div/div" name="each_book">
    <p:variable name="book00" select="p:iteration-position() => format-number('00')"/>

    <p:delete match="l//text()[normalize-space(.) => not()]"/>
    <p:xslt name="lmnlizer">
      <p:with-input port="stylesheet" href="../lib/Laminator/lib/common/xml-to-lmnl.xsl"/>
    </p:xslt>

    <p:text-replace pattern="^\s+" replacement="" flags="m"/>
    <p:variable name="lmnl" select="."/>

    <EPIC:store href="../data/Iliad/lmnl/PerseusDL_src/book{ $book00 }.lmnl"
      hint="PerseusDL source, encoded in LMNL"/>

    <p:delete match="/*/node()">
      <p:with-input port="source" pipe="current@each_book"/>
    </p:delete>
    <p:insert match="/*" position="first-child">
      <p:with-input port="insertion" expand-text="true">
        <ab>{ $lmnl }</ab>
      </p:with-input>
    </p:insert>
  </p:viewport>

  <EPIC:teiHeader_update/>

  <EPIC:store href="../data/Iliad/tei/PerseusDL_lmnl-tei.xml"
    hint="PerseusDL TEI, with books in LMNL syntax"/>


  <p:xslt>
    <p:with-input port="source" pipe="result@PerseusDL-TEI"/>
    <p:with-input port="stylesheet" href="src/perseus-Iliad-fixup.xsl"/>
  </p:xslt>
  
  <EPIC:store href="../data/Iliad/tei/ILIAD_epicmarkup_tei.xml" hint="TEI, with adjustments"/>
  
  <!-- The next couple of steps include tailored modifications for this data -->
  <p:xslt name="adjusted">
    <p:with-input port="stylesheet" href="src/perseus_Iliad-adjust.xsl"/>
  </p:xslt>
  
  <p:xslt>
    <p:with-input port="stylesheet" href="src/adjustedIliad-to-sawteeth.xsl"/>
  </p:xslt>

  <EPIC:store href="../data/Iliad/lmnl/ILIAD_pages.lmnl" hint="LMNL, improved"/>

  <p:for-each>
    <p:with-input select="//EPIC/book" pipe="result@adjusted"/>
    <p:variable name="book00" select="p:iteration-position() => format-number('00')"/>
    
    <p:xslt>
      <p:with-input port="stylesheet" href="src/adjustedIliad-to-sawteeth.xsl"/>
    </p:xslt>
    <EPIC:store href="../data/Iliad/lmnl/enhanced/book{ $book00 }.lmnl" hint="LMNL, with enhancements"/>
  </p:for-each>

</p:declare-step>