<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  exclude-result-prefixes="xs math"
  version="3.0">
  
  <xsl:template match="/BOOK" expand-text="true">
    <xsl:copy>
      <xsl:for-each-group select="string(.) => tokenize('\n')"
        group-ending-with=".[normalize-space(.) => not()]">
        <xsl:where-populated>
          <lg>
            <xsl:for-each select="current-group()[normalize-space(.)]">
              <l>{ . }</l>
            </xsl:for-each>
          </lg>
        </xsl:where-populated>
      </xsl:for-each-group>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>