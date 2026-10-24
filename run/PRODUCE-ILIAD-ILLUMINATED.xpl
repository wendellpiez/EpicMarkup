<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:mnml="http://wendellpiez.com/ns/xMNML"
  xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
  exclude-inline-prefixes="#all">

  <!-- Purpose: Produce ILLUMINATED HTML/CSS/JS from a library of LMML source data
    Along with MYTHOI XML along the way
    
    Reads the 'edited' folder but you can opt for a different one for comparison
  -->
  
  <!-- The imported pipeline parses a LMNL instance and returns
  MYTHOI XML along with an ILLUMINATED HTML version
  (single standalone HTML/CSS/JS)
  -->
  <p:import href="Iliad/lmnl-illuminate.xpl"/>

  <!-- Switch this to a testing directory for testing -->
  <p:option name="lmnl-dir" select="'edited'"/>
  
  <p:variable name="target-dir" select="'../data/Iliad/lmnl/' || $lmnl-dir"/>  
  
  <p:variable name="datestamp" select="current-date() => format-date('[Y][M][D]')"/>
  
  <p:directory-list path="{$target-dir}" include-filter="\.lmnl$"/>
  
  <p:for-each>
    <p:with-input select="/c:directory/c:file"/>
    <p:variable name="filepath" select="/*/@name => resolve-uri(base-uri(.))"/>
    <p:variable name="basename" select="tokenize($filepath,'/')[last()] ! replace(.,'\.lmnl$','')"/>
    
    <p:load href="{ $filepath }" content-type="text/plain"/>
    
    <EPIC:lmnl-illuminate name="ILLUMINATION"/>
    
    <p:choose>
      <p:when test="exists(/ERROR)">
        <p:store href="../data/Iliad/temp/{ $basename }_myth.broken.xml"
          message="FAILURE converting { $basename } ### SEE ../data/Iliad/temp/{ $basename }_myth.broken.xml">
          <p:with-input port="source" pipe="tagged-as-XML@ILLUMINATION"/>
        </p:store>
      </p:when>

      <p:otherwise>
        <p:insert position="before" match="/*">
          <p:with-input port="source" pipe="@ILLUMINATION"/>
          <p:with-input port="insertion">
            <p:inline xml:space="preserve">
<?xml-stylesheet type="text/css" href="mythoi-xml-authoring.css" title="MYTHOI XML" alternate="no"?>
<?xml-model href="mythoi.rnc" type="application/relax-ng-compact-syntax"?>
</p:inline>
          </p:with-input>
        </p:insert>

        <p:store href="../data/Iliad/mythoi_{ $datestamp}/{ $basename }_myth.xml"
          message="Storing { $basename } MYTHOI xml ............ ../data/Iliad/mythoi_{ $datestamp}/{ $basename }_myth.xml ..."/>

        <p:store href="../data/Iliad/illuminated/ILIAD-illuminated_{ $basename }.html"
          message="Storing { $basename } MYTHOI display page ... ../data/Iliad/illuminated/ILIAD-illuminated_{ $basename }.html">
          <p:with-input port="source" pipe="html-display@ILLUMINATION"/>
        </p:store>
      </p:otherwise>
    </p:choose>
  </p:for-each>

</p:declare-step>