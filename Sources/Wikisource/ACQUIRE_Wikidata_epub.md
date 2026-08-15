
# Wikidata EPUB acquisition

We save a copy of this 37KB EPUB file in the repository to make it readily available, but if it is lost -- or to replicate the logic for the other eleven books! -- here we go --

Copy the EPUB by hand from here:

Paradise Lost (1674) Book I  https://ws-export.wmcloud.org/?format=epub&amp;lang=en&amp;page=Paradise_Lost_(1674)%2FBook_I

Or for that matter, any book, since processing should be generic and capable across the entire poem.

Here is some XProc which *might* work in a processor that supports file copy from https.


```
<?xml version="1.0" encoding="UTF-8"?>

<p:declare-step version="3.0"
  xmlns:p="http://www.w3.org/ns/xproc" 
  xmlns:c="http://www.w3.org/ns/xproc-step"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">


<!-- Purpose: download and save Wikidata source data - copies the file to local cache where it can be read by pipelines in /run folder -->

<!-- The text is the Wikisource transcript of Book I from the 1674 edition of Paradise Lost (the second, enlarged edition prepared by Milton) in twelve books.

https://en.wikisource.org/wiki/Paradise_Lost_(1674)

Alas, the page hangs up attempting to export txt (plain text) or htmlz (HTML)

So we will take the EPUB and be grateful.

-->

  <p:variable name="filename" select="'ParadiseLost1674.epub'"/>
  <p:variable name="dest"     select="'Wikisource'"/>
  
  <p:variable name="filepath"
    select="'https://ws-export.wmcloud.org/?format=epub&amp;lang=en&amp;page=Paradise_Lost_(1674)%2FBook_I'"/>

  <!--<p:output serialization="map { 'indent': true() }"/>-->


  <p:file-copy 
    fail-on-error="[xs:boolean] true()"
    href="{ $filepath }"
    overwrite="false()"
    target="{ $dest }/{ $filename}"/>
  

</p:declare-step>
```