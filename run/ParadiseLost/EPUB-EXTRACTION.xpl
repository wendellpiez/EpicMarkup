<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  
  type="EPIC:EPUB-EXTRACTION.xpl">
  
  
  <!--

The text is the Wikisource transcript of Book I from the 1674 edition of Paradise Lost (the second, enlarged edition prepared by Milton) in twelve books.

https://en.wikisource.org/wiki/Paradise_Lost_(1674)

Alas, the page hangs up attempting to export txt (plain text) or htmlz (HTML)
So we will take the EPUB and be grateful.

-->
  <p:output serialization="map { 'indent': true() }"/>
  
  <p:variable name="data-path" select="'../../data/ParadiseLost/'"/>
  <!--
  <p:archive-manifest>
    <p:with-input port="source" href="Wikisource/Paradise_Lost_(1674)_Book_I.epub"/>
  </p:archive-manifest>
  
  <p:store href="{ $data-path }/epub-manifest.xml" serialization="map { 'indent': true() }"/>-->

  <!-- If this file is not available, see the ../../Sources/ folder for hints -->
  <p:unarchive relative-to="{ $data-path }" include-filter="\.xhtml$" exclude-filter="(nav|title|about)">
    <p:with-input port="source" href="../../Sources/Wikisource/Paradise_Lost_(1674)_Book_I.epub"/>
  </p:unarchive>
  
  <p:for-each>
    <p:variable name="filepath" select="p:document-property(/, 'base-uri') ! replace(.,'OPS','cache')"/>
    <!--<p:identity/>-->
    <!--<p:identity>
      <p:with-input exclude-inline-prefixes="#all">
        <unarchived-file href="{ $filepath }" content-type="{p:document-property(/, 'content-type')}"/>
      </p:with-input>
    </p:identity>-->
    <p:store href="{ $filepath }" message="STORING { $filepath }"/>
  </p:for-each>
  
</p:declare-step>