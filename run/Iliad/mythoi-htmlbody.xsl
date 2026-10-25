<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xs math"
  version="3.0">

  <xsl:mode on-no-match="fail" use-accumulators="hemistich"/>
  
  <xsl:param name="n" select="/BOOK/@n"/>
  
  <!-- An Aligned English-language rendition in XML
   such as (in LMNL) ../../data/Iliad/Butler_1898/ILIAD-en_book01.lmnl-->
   
  <xsl:param name="english" as="document-node()?" select="()"/>
  
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="text()">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:message expand-text="true">### XSLT [mythoi-htmlbody.xsl] 27 - sliding on element '{ local-name() }'</xsl:message>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="/*" expand-text="true">
    <body>
      <header>
        <h1><i>Iliad Illuminated</i> Book { $n }</h1>
      </header>
      <!-- Side notes first so main will appear over them -->
      <aside id="side_notes">
        <xsl:apply-templates mode="callout"/>
      </aside>
      <aside id="line_numbering">
        <xsl:apply-templates select=".//lb" mode="label"/>
      </aside>
      <nav><!-- Placing nav over callouts -->
        <div class="controlbox">
          <button style="margin: 0em 0.3em"
            onclick="document.querySelectorAll('.vocab').forEach(e=>e.classList.add('hiding')); document.querySelectorAll('.shining').forEach(f=>f.classList.remove('shining'))"
            >Clear</button>
          <div class="linkbox">
            <span>Illuminated</span>
            <input type="checkbox" id="illuminator"/>
          </div>
        </div>
      </nav>
      <main>
        <xsl:apply-templates/>
      </main>
      <xsl:call-template name="make-footer"/>      
    </body>
  </xsl:template>
  
  <xsl:template name="make-footer">
    <footer>
      <details>
        <summary
          onclick="if (!this.parentElement.open) requestAnimationFrame(() => foot.scrollIntoView())"
            ><i>Iliad Illuminated</i> is a project of Wendell Piez, from 2026</summary>
        <p>With grateful acknowledgement of forerunners and sources including (among many) the <a
            href="https://github.com/PerseusDL">Perseus Digital Library</a> and <a
            href="https://tei-c.org/">Text Encoding Initiative</a> (TEI), this derivative work is
          made available under the terms of <a
            href="https://creativecommons.org/licenses/by-sa/4.0/">CC&#xA0;BY-SA</a> (Creative
          Commons license: free to use with acknowledgement; share alike).</p>
        <p>Design goals include complementarity with <a href="https://scaife.perseus.org/">other open source resources</a>, while pages are standalone and independent, suitable for cache, copy, and off-network use. If you like what you see, make a copy.</p>
        <p>Code in this project is made by hand, or under automation using deterministic methods (data transformations). The foundation is the XML stack (XProc, XSLT, XPath), with the assistance of the Laminator library. No LLMs, probabilistic code generators or AI coding assistants have been used, except for occasional and incidental background research. No connections are made and no one reads or records you, your inputs or interactions.</p>
        <p><a href="https://github.com/wendellpiez/EpicMarkup/">Project source code</a> is available to inspect and acquire from Github in the developer's <a href="https://github.com/wendellpiez/EpicMarkup/" style="font-family: monospace" >EpicMarkup</a> repository.</p>
        <p class="raventracks-plug">For more study materials on Homer and Ancient Greek by the developer, see the <a style="font-weight: bold" href="https://raventracks.org" >RavenTracks</a> project; see <a style="font-weight: bold" href="https://pellucidliterature.org">Pellucid Literature</a> for more declarative markup for — and as — literary study.</p>
      </details>
      <p id="foot"/>
    </footer>
  </xsl:template>
  
  <xsl:variable name="lNO" as="function(*)"
    select="function($s as xs:string) as xs:string { (tokenize($s,'\.') ! number(.) ! format-number(.,'000')) => string-join('_') => substring(2) }"/>
  
  <xsl:variable name="mythID" as="function(*)"
    select="function($n as node()) as xs:string { $n/(name(), generate-id()) => string-join('_') }"/>
  
  <xsl:variable name="capz" as="function(*)"
    select="function($c as xs:string) as xs:string { (substring($c,1,1) => upper-case()) || substring($c,2) }"/>
  
  <xsl:variable name="starts-a-div" as="function(*)"
    select="function($lb as element(lb)) as xs:boolean { 
      some $d in (
        $lb/following::scene[1] |
        $lb/following::prayer[1] |
        $lb/following::assembly[1] |
        $lb/following::speech[1] )
      satisfies ( $lb/following::text()[normalize-space(.)][1] >> $d )  }"/>
  
  <!-- line breaks that start divs will reappear just inside them -->
  <xsl:template match="lb[$starts-a-div(.)]"/>
  
  <xsl:template match="lb" name="make_lb">
    <br class="lb"/>  
    <a class="lnchr" style="anchor-name: --L{ $lNO(@n) }">&#x200B;<!-- zero-width space --></a>  
  </xsl:template>
  
  <xsl:key name="english-at-line" match="p" use="@ends"/>
  
  <xsl:template match="lb" mode="label" expand-text="true">
    <span class="lno" style="position-anchor: --L{ $lNO(@n) }">{ @n }</span>
  </xsl:template>
  
  <!-- Accumulator keeps track of the line so far -->  
  <xsl:accumulator name="hemistich" initial-value="''">    
    <xsl:accumulator-rule match="lb" select="''"/>
    <xsl:accumulator-rule match="text()" select="$value || ."/>
  </xsl:accumulator>
  
  <xsl:template match="scene | prayer | assembly | speech">
    <div class="illumination { local-name() }" id="{ $mythID(.) }" style="anchor-name: --{ $mythID(.) }">
      <!-- make a spacer for the last line part if there is a first line part -->
      
      <xsl:if test="descendant::lb[1] >> descendant::text()[normalize-space(.)][1]">
        <xsl:variable name="start-spacer" as="text()">
          <xsl:value-of select="accumulator-before('hemistich')"/>
        </xsl:variable>  
        <xsl:apply-templates mode="spacer" select="$start-spacer[normalize-space(.)]"/>
      </xsl:if>
        <xsl:for-each select="preceding::lb[1][$starts-a-div(.)]">
        <xsl:call-template name="make_lb"/>
      </xsl:for-each>

      <xsl:apply-templates/>   
    </div>
    <!-- make a spacer for the last line part if there is a subsequent line part -->
    <xsl:variable name="end-spacer" as="text()">
      <xsl:value-of select="accumulator-after('hemistich')"/>
    </xsl:variable>
    <xsl:apply-templates mode="spacer" select="$end-spacer[normalize-space(.)]"/>
  </xsl:template>
  
  <xsl:mode name="callout" on-no-match="shallow-skip"/>
  
  <xsl:template match="scene" expand-text="true" mode="callout">
    <xsl:call-template name="make-callout">
      <xsl:with-param name="contents">
        <h3>Scene</h3>
        <p>{ @set }</p>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates mode="#current"/>
  </xsl:template>
  
  <xsl:template match="prayer | speech" mode="callout" expand-text="true">
    <xsl:call-template name="make-callout">
      <xsl:with-param name="contents">
        <h3>{ local-name() => $capz() }</h3>
        <p>{ @by }{ @by/', ' }to { @to }</p>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates mode="#current"/>
  </xsl:template>
  
  <xsl:template name="make-callout">
    <xsl:param name="contents">
      <h3>{ local-name() => $capz() }</h3>      
    </xsl:param>
    <div class="callout { local-name() }" style="position-anchor: --{ $mythID(.) }"
      onclick="{ $mythID(.) }.classList.toggle('shining'); this.classList.toggle('shining')">
      <xsl:copy-of select="$contents"/>
    </div>
  </xsl:template>
  
  <xsl:template match="assembly" mode="callout" expand-text="true">
    <xsl:call-template name="make-callout"/>
    <xsl:apply-templates mode="#current"/>
  </xsl:template>
  
  <xsl:template match="simile | trope | tale | force | song | echo" mode="callout" expand-text="true">
    <div class="callout { local-name() } { $mythID(.) }" id="{ $mythID(.) }" style="position-anchor: --{ $mythID(.) }"
      onclick="document.querySelectorAll('.{ $mythID(.) }').forEach(e=>e.classList.toggle('shining'));">
      <p><b>{ local-name() }</b> { @glss/'— ' }{ @glss }</p>
    </div>
    <xsl:apply-templates mode="#current"/>
  </xsl:template>
  
  <!-- Mode spacer produces text hidden to take up space
  where lines continue into and after blocks (divs) -->
  
  <xsl:template mode="spacer" match="text()[normalize-space(.) => not()]"/>
    
  <xsl:template mode="spacer" match="text()">
    <span class="spacer" style="color: transparent; user-select: none">
      <xsl:text expand-text="true">{ . }</xsl:text>
    </span>
  </xsl:template>
  
  <xsl:template match="simile | trope | force | tale | song | echo">
    <span class="{ local-name() } { $mythID(.) }" style="anchor-name: --{ $mythID(.) }">
      <!-- onclick="{ $mythID(.) }.click()" actually works -->
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="w">
    <xsl:variable name="gloss">
      <xsl:apply-templates select="@postag"/>
    </xsl:variable>
    <span class="w" data-stem="{ @lemma }" data-morph="{ $gloss }"
      title="{ @lemma } { $gloss }" style="anchor-name: --{ $mythID(.) }">
      <xsl:for-each select="@english">
        <xsl:attribute name="data-trans" select="."/>
      </xsl:for-each>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:import href="expand-tb-postagging.xsl"/>
  
</xsl:stylesheet>