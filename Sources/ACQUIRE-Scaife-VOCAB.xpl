<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0" xmlns:xhtml="http://www.w3.org/1999/xhtml">


  <p:load message="Pulling Iliad Vocabulary from Perseus.org" href="https://vocab.perseus.org/word-list/urn:cts:greekLit:tlg0012.tlg001.perseus-grc2/?o=1&amp;page=all"
   />

  <!--<p:store href="Sources/Perseus/Iliad-vocab_ALL.html"/>-->

  <p:group xmlns="http://www.w3.org/1999/xhtml">
    <p:filter select="/descendant::table[contains-token(@class,'word-list')]/tbody"/>

    <p:for-each>
      <p:with-input select="descendant::tr"/>
      <p:identity>
        <p:with-input>
          <p:inline>
            <term count="{ /*/td[@class='count'     ]/normalize-space(.) }">
              <lemma>{     /*/th[@class='lemma_text']/normalize-space(.) }</lemma>
              <def>{       /*/td[@class='shortdef'  ]/normalize-space(.) }</def>
            </term>
          </p:inline>
        </p:with-input>
      </p:identity>
      <p:namespace-delete prefixes="html" xmlns:html="http://www.w3.org/1999/xhtml"/>

    </p:for-each>

  </p:group>

  <p:wrap-sequence wrapper="LEXICON"/>

  <!-- Building and serializing a map (as JSON) might be faster, but we have time -->
  <p:store message="STORING Scaife/Iliad_lexicon.xml" href="Scaife/Iliad_lexicon.xml"
    serialization="map { 'indent': true() }"/>

</p:declare-step>
