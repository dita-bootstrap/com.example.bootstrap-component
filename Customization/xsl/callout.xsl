<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  version="2.0"
  exclude-result-prefixes="xs dita-ot"
>
  <!-- Handle the callout element transformation -->
  <xsl:template match="*[contains(@class, 'bootstrapCustom-d/callout')]">
    <div>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="setidaname"/>
      <!-- Apply all children, but title and the first p have special handling -->
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Complete control over the class attribute for callouts -->
  <xsl:template match="*[contains(@class, 'bootstrapCustom-d/callout')]" mode="set-output-class" priority="50">
    <xsl:variable name="color" select="(if (@color) then @color else 'primary')"/>
    <xsl:variable name="ancestry">
       <xsl:apply-templates select="." mode="get-element-ancestry"/>
    </xsl:variable>

    <xsl:variable name="classes" as="xs:string*">
       <xsl:sequence select="tokenize('callout p-2 border-start border-5', '\s+')"/>
       <xsl:sequence select="concat('bg-', $color, '-subtle')"/>
       <xsl:sequence select="concat('border-', $color)"/>
       <xsl:sequence select="concat('callout-', $color)"/>
       <xsl:sequence select="concat('text-', $color)"/>
       <xsl:if test="@rounded">
         <xsl:choose>
            <xsl:when test="@rounded='yes'"><xsl:sequence select="'rounded'"/></xsl:when>
            <xsl:when test="@rounded='no'"><xsl:sequence select="'rounded-0'"/></xsl:when>
            <xsl:otherwise><xsl:sequence select="concat('rounded-', @rounded)"/></xsl:otherwise>
         </xsl:choose>
       </xsl:if>
       <xsl:sequence select="tokenize(normalize-space($ancestry), '\s+')"/>
       <xsl:sequence select="tokenize(@outputclass, '\s+')"/>
    </xsl:variable>

    <xsl:if test="exists($classes)">
      <xsl:attribute name="class" select="normalize-space(string-join(distinct-values($classes), ' '))"/>
    </xsl:if>
  </xsl:template>

  <!-- Suppress standalone title processing for callouts -->
  <xsl:template match="*[contains(@class, 'bootstrapCustom-d/callout')]/*[contains(@class, ' topic/title ')]" priority="50"/>

  <!-- Specialized handling for the FIRST paragraph in a callout to include the title -->
  <xsl:template match="*[contains(@class, 'bootstrapCustom-d/callout')]/*[contains(@class, ' topic/p ')][not(preceding-sibling::*[contains(@class, ' topic/p ')])]" priority="50">
    <p>
      <xsl:call-template name="commonattributes"/>
      <xsl:call-template name="setidaname"/>
      
      <!-- Look for the title in the parent callout -->
      <xsl:variable name="title" select="../child::*[contains(@class, ' topic/title ')]"/>
      <xsl:if test="$title">
        <strong>
          <xsl:apply-templates select="$title/node()"/>
        </strong>
        <xsl:text> </xsl:text>
      </xsl:if>
      
      <!-- Standard paragraph content -->
      <xsl:apply-templates/>
    </p>
  </xsl:template>

</xsl:stylesheet>
