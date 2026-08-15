<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc"
  version="3.0"
  xmlns="http://wendellpiez.com/ns/Scholia2025"
  xmlns:cx="http://xmlcalabash.com/ns/extensions"
  xmlns:zone="http://wendellpiez.com/ns/xproc-zone"
   exclude-inline-prefixes="#all"
   xmlns:EPIC="https://github.com/wendellpiez/EpicMarkup/ns"
   type="EPIC:English_s-phr_tagger">
    
    <!--
      Produces a Scholia document with sc elements for sentences and sentence fragments
      
      LIMITATIONS - no provision is made for punctuation around quotes;
        We assume this has been stripped for later restoration when called for.
      Em dashes and colons separate phrases, never sentences.
      Question marks are taken to end sentences.
        Phrases ending with question marks must be merged in a subsequent pass.
    -->
  
  <p:input port="source"/>

  <p:output port="result"/>
  
  <!-- The grammar delimits between clauses as indicated by punctuation -->
  <p:invisible-xml cx:processor="markup-blitz">
    <p:with-input port="source" select="string(.)"/>
    <p:with-input port="grammar" expand-text="false">
      <p:inline content-type="text/plain" expand-text="false">
        RUN       = spacer?, s++spacer, spacer? .
        s         = pphrase**spacer, (spacer?, tphrase), period . { only thing required is tphrase, period }
        -pphrase  = phr, punct . { ends with punctuation }
        -tphrase  = phr .        { doesn't }
        phr       = nows, char* .
        -punct    = (";" | "," | ":" | "—" | "?—" | ":—" | "!—" | ";—" ) .
        -period   = ["." | "?" | "!"] .
        -spacer   =  [#a | #d | #9 | #20 ]+ .
        -char     = ~["." | "?" | "!" | ";" | "," | ":" | "—"] .
        -nows     = ~[#a | #d | #9 | #20 | "—" | "." | "?" | "!" | ";" | "," | ":"] . { no whitespace }
        </p:inline>
    </p:with-input>
  </p:invisible-xml>

  <!--
old: 


RUN      = spacer?, s++spacer .
s        = phr++spacer, period .
phr      = char, moretext, ("," | ";" | ":" | "!" | "—" | "?—" | ":—" )* .
-period   = ["." | "?"] .
-spacer   =  [#a | #d | #9 | #20 ]+ .
-char     = ~[#a | #d | #9 | #20 | "—" | "." | "?" | "!" | ";" | "," | ":"] .
-moretext = ~["—" | "." | "?" | "!" | ";" | "," | ":"]* .

-->
  <!--<p:inline content-type="text/plain" expand-text="false">
    RUN     = -spacer?, s++spacer .
    s       = phr++spacer, -period  .
    phr     = -word++spacer, ("," | ";" | ":" | "!" | "—" ) .
    period  = ["." | "?"] .
    -spacer =  [#a | #d | #9 | #20 ]+ . { spacer includes " }
    word    = ~[#a | #d | #9 | #20 | "—" | '"' | "." | "?" | "!" | ";" | "," | ":"]+ .
  </p:inline>-->
  
  <!--Next - XML to layers -->
</p:declare-step>
