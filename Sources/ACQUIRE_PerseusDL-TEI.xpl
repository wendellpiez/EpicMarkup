<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0" xmlns:xhtml="http://www.w3.org/1999/xhtml">


<!-- Purpose: download and save PerseusDL source data (about 2MB).
    
  By loading the file, XProc also ensures it can be parsed, and reserializes.
  (XProc p:file-copy can be used if this is not wanted.)
  
  Note: this pipeline should only be run to refresh the data for subsequent pipelines
     and may be just as easy to do manually
  
  Note also, to be found in the same repository (June 2036):
  
    Murray translation: tlg0012.tlg001.perseus-eng3.xml 
    Butler translation: tlg0012.tlg001.perseus-eng4.xml
  
  These are encoded in TEI with tei:div[@unit='card'] (chunked for display)
    with occasional milestones for alignment with the original
    and could be useful for aligned translations a la Scaife Reader, etc.

  With eager acknowledgement of the Perseus project, its organizers,
  sponsors and contributors for producing this awesome work.

  -->


  <p:variable name="filename" select="'tlg0012.tlg001.perseus-grc2.xml'"/>
  <p:variable name="path_segments" select="tokenize($filename,'\.')[position() lt 3]"/>
  <p:variable name="repo"     select="'PerseusDL'"/>
  <p:variable name="filepath"
    select="('https://github.com', $repo, 'canonical-greekLit/raw/refs/heads/master/data', $path_segments, $filename ) => string-join('/')"/>

  <!--<p:output serialization="map { 'indent': true() }"/>-->


  <p:load href="{ $filepath }" message="DOWNLOADING { $filename } from { $repo } ..."/>
  
  <p:store message="... Saving" href="{ $repo }/{ $filename }" serialization="map { 'indent': true() }"/>

</p:declare-step>
