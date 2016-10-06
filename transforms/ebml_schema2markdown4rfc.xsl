<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output encoding="UTF-8" method="text" version="1.0" indent="yes"/>
  <xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
  <xsl:template match="EBMLSchema">
    <xsl:apply-templates select="//element"/>
  </xsl:template>
  <xsl:template match="element">
    <xsl:text>### </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text> Element&#xa;&#xa;</xsl:text>
    <xsl:if test="@name">
      <xsl:text>name: `</xsl:text>
      <xsl:value-of select="@name"/>
      <xsl:text>`&#xa;&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="@id">
      <xsl:text>id: `</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>`&#xa;&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="@type">
      <xsl:text>type: `</xsl:text>
      <xsl:value-of select="@type"/>
      <xsl:text>`&#xa;&#xa;</xsl:text>
    </xsl:if>
    <xsl:text>minver: `</xsl:text>
    <xsl:choose>
      <xsl:when test="@minver">
        <xsl:value-of select="@minver"/>
      </xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
    <xsl:text>`&#xa;&#xa;</xsl:text>
    <xsl:text>maxver: `</xsl:text>
    <xsl:choose>
      <xsl:when test="@maxver">
        <xsl:value-of select="@maxver"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="//EBMLSchema/@version"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="//EBMLSchema/@version > @maxver">
      <xsl:text> (DEPRECATED)</xsl:text>
    </xsl:if>
    <xsl:text>`&#xa;&#xa;</xsl:text>
    <xsl:text>parent: </xsl:text>
    <xsl:choose>
      <xsl:when test="parent::element/@name">
        <xsl:text>`</xsl:text>
        <xsl:value-of select="parent::element/@name"/>
        <xsl:text>` (see [the section on </xsl:text>
        <xsl:value-of select="parent::element/@name"/>
        <xsl:text>](#</xsl:text>
        <xsl:value-of select="translate(parent::element/@name, $uppercase, $smallcase)"/>
        <xsl:text>-element))</xsl:text>
      </xsl:when>
      <xsl:otherwise>None</xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;&#xa;</xsl:text>
    <xsl:text>children: </xsl:text>
    <xsl:choose>
      <xsl:when test="element">
        <xsl:for-each select="element">
          <xsl:text>`</xsl:text>
          <xsl:value-of select="@name"/>
          <xsl:text>` (see [the section on </xsl:text>
          <xsl:value-of select="@name"/>
          <xsl:text>](#</xsl:text>
          <xsl:value-of select="translate(@name, $uppercase, $smallcase)"/>
          <xsl:text>-element))</xsl:text>
          <xsl:if test="following-sibling::element">, </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>None</xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;&#xa;</xsl:text>
    <xsl:text>context: `</xsl:text>
    <xsl:choose>
      <xsl:when test="ancestor::element">
        <xsl:for-each select="ancestor::element">
          <xsl:text>/</xsl:text>
          <xsl:value-of select="@name"/>
        </xsl:for-each>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="@name"/>
      </xsl:when>
      <xsl:otherwise>None</xsl:otherwise>
    </xsl:choose>
    <xsl:text>`&#xa;&#xa;</xsl:text>
    <xsl:text>minOccurs: `</xsl:text>
    <xsl:value-of select="@minOccurs"/>
    <xsl:choose>
      <xsl:when test="not(@minOccurs)">0` (Not Mandatory)</xsl:when>
      <xsl:when test="@minOccurs = 0">` (Not Mandatory)</xsl:when>
      <xsl:when test="@minOccurs = 1">` (Mandatory)</xsl:when>
      <xsl:otherwise>
        <xsl:text> (A minimum of </xsl:text>
        <xsl:value-of select="@minOccurs"/>
        <xsl:text> must occur.)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;&#xa;</xsl:text>
    <xsl:text>maxOccurs: `</xsl:text>
    <xsl:value-of select="@maxOccurs"/>
    <xsl:choose>
      <xsl:when test="not(@maxOccurs)">1` (Not Repeatable)</xsl:when>
      <xsl:when test="@maxOccurs = 'unbounded'">` (Repeatable)</xsl:when>
      <xsl:when test="@maxOccurs = 'identical'">` (Repeatable, but must only repeat as identical copies for redundancy)</xsl:when>
      <xsl:when test="@maxOccurs = '1'"> (Not Repeatable)</xsl:when>
      <xsl:otherwise>
        <xsl:text> (A maximum of </xsl:text>
        <xsl:value-of select="@maxOccurs"/>
        <xsl:text> may occur.)</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>&#xa;&#xa;</xsl:text>
    <xsl:if test="@recursive">
      <xsl:text>recursive: </xsl:text>
      <xsl:value-of select="@recursive"/>
      <xsl:choose>
        <xsl:when test="@recursive = 1"> (Recursive)</xsl:when>
        <xsl:otherwise> (Not Recursive)</xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:text>&#xa;&#xa;</xsl:text>
    <xsl:for-each select="documentation">
      <xsl:choose>
        <xsl:when test="@type">
          <xsl:value-of select="@type"/>
        </xsl:when>
        <xsl:otherwise>documentation</xsl:otherwise>
      </xsl:choose>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>&#xa;&#xa;</xsl:text>
    </xsl:for-each>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
</xsl:stylesheet>
