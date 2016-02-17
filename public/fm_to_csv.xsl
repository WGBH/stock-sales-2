<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fm="http://www.filemaker.com/fmpdsoresult">
  <!--
    XSL can be specified for FM export with a URL:
    Putting it here lets us keep it under version control,
    and we can also test that the behavior is what we expect. 
  -->
  <xsl:output method="text" encoding="utf-8"/>

  <xsl:template match="/">
    <!--
      Complete header from template:
      Handle,Title,Body (HTML),Vendor,Type,Tags,Published,Option1 Name,Option1 Value,Option2 Name,Option2 Value,Option3 Name,Option3 Value,Variant SKU,Variant Grams,Variant Inventory Tracker,Variant Inventory Qty,Variant Inventory Policy,Variant Fulfillment Service,Variant Price,Variant Compare At Price,Variant Requires Shipping,Variant Taxable,Variant Barcode,Image Src,Image Alt Text,Gift Card,Google Shopping / MPN,Google Shopping / Age Group,Google Shopping / Gender,Google Shopping / Google Product Category,SEO Title,SEO Description,Google Shopping / AdWords Grouping,Google Shopping / AdWords Labels,Google Shopping / Condition,Google Shopping / Custom Product,Google Shopping / Custom Label 0,Google Shopping / Custom Label 1,Google Shopping / Custom Label 2,Google Shopping / Custom Label 3,Google Shopping / Custom Label 4,Variant Image,Variant Weight Unit
    -->
    <xsl:value-of select='"Handle,Title,Body (HTML),Published,Option1 Name,Option1 Value,Variant SKU,Variant Price&#xA;"'/>
    <xsl:apply-templates select="fm:FMPDSORESULT/fm:ROW" />
  </xsl:template>

  <xsl:template match="fm:ROW">
    <xsl:variable name="comma" select="','"/>
    <xsl:call-template name="row-main">
        <xsl:with-param name="id" select="./fm:artesia_id"/>
        <xsl:with-param name="title" select="./fm:clip_title"/>
        <xsl:with-param name="description" select="./fm:clip_description"/>
    </xsl:call-template>
    <xsl:call-template name="row-var">
        <xsl:with-param name="id" select="./fm:artesia_id"/>
        <xsl:with-param name="format" select="'HD'"/>
        <xsl:with-param name="price" select="'$250'"/>
    </xsl:call-template>
    <xsl:call-template name="row-var">
        <xsl:with-param name="id" select="./fm:artesia_id"/>
        <xsl:with-param name="format" select="'SD'"/>
        <xsl:with-param name="price" select="'$180'"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="row-main">
    <xsl:param name="id"/>
    <xsl:param name="title"/>
    <xsl:param name="description"/>
    <xsl:variable name="comma" select="','"/>
    <xsl:variable name="q" select="'&quot;'"/>
    <xsl:variable name="qnl" select="'&quot;&#xA;'"/>
    
    <!-- TODO: figure out how to escape quotes in XPath 1.0, but for now, just strip. -->
    <xsl:value-of select="concat(
                            $id, $comma,
                            $q,translate($title,$qnl,'  '),$q, $comma,
                            $q,translate($description,$qnl,'  '),$q, $comma,
                            'TRUE', $comma,
                            'Format', '&#xA;'
                          )"/>
  </xsl:template>
  
  <xsl:template name="row-var">
    <xsl:param name="id"/>
    <xsl:param name="format"/>
    <xsl:param name="price"/>
    <xsl:variable name="comma" select="','"/>
    <xsl:value-of select="concat(
                            $id, $comma,
                            '', $comma,
                            '', $comma,
                            '', $comma,
                            'Format', $comma,
                            $format, $comma,
                            $format,'-',$id, $comma,
                            $price, '&#xA;'
                          )"/>
  </xsl:template>
  
</xsl:stylesheet>
