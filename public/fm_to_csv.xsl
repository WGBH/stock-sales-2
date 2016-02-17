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
    <xsl:value-of select='"Handle,Title,Body (HTML),Published,Option1 Name,Option1 Value,Variant SKU&#xA;"'/>
    <xsl:apply-templates select="fm:FMPDSORESULT/fm:ROW" />
  </xsl:template>

  <xsl:template match="fm:ROW">
    <xsl:variable name="comma" select="','"/>
    <xsl:value-of select="concat(
                            ./fm:artesia_id, $comma,
                            ./fm:clip_title, $comma,
                            ./fm:clip_description, $comma,
                            'TRUE', $comma,
                            'Format', $comma,
                            '', '&#xA;'
                          )"/>
    <xsl:value-of select="concat(
                            ./fm:artesia_id, $comma,
                            '', $comma,
                            '', $comma,
                            '', $comma,
                            'Format', $comma,
                            'HD-',./fm:artesia_id, '&#xA;'
                          )"/>
    <xsl:value-of select="concat(
                            ./fm:artesia_id, $comma,
                            '', $comma,
                            '', $comma,
                            '', $comma,
                            'Format', $comma,
                            'SD-',./fm:artesia_id, '&#xA;'
                          )"/>
  </xsl:template>
  
</xsl:stylesheet>
