<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0" xmlns:xhtml="http://www.w3.org/1999/xhtml">


<!-- Purpose: download and save PerseusDL Treebank data for Homer's Iliad.
    
    THIS PIPELINE SAVES THE (LARGE) Treebank file for the Iliad - 20MB - take care you really want it
    (See pipeline ACQUIRE_PerseusDL-TEI.xpl for the basic text)
     -->

  <p:variable name="filename" select="'tlg0012.tlg001.perseus-grc1.tb.xml'"/>
  <p:variable name="repo"     select="'PerseusDL'"/>
  <p:variable name="filepath"
    select="('https://github.com', $repo, 'treebank_data/raw/refs/heads/master/v2.1/Greek/texts', $filename ) => string-join('/')"/>

  <!--<p:output serialization="map { 'indent': true() }"/>-->


  <p:load href="{ $filepath }" message="DOWNLOADING { $filename } from { $repo } ..."/>

  <p:store message="... Saving" href="{ $repo }/{ $filename }"/>

</p:declare-step>
