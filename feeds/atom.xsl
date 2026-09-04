<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom">
<xsl:output method="html" encoding="utf-8" indent="yes"/>
<xsl:template match="/">
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover"/>
<title><xsl:value-of select="atom:feed/atom:title"/> — Feed</title>
<link rel="stylesheet" href="/assets/style.css"/>
</head>
<body>
<nav class="navbar" aria-label="Primary navigation">
  <a href="/" class="nav-brand">Dom Colligan</a>
  <div class="nav-links">
    <a href="/" class="nav-link">Home</a>
    <a href="/posts/" class="nav-link">Posts</a>
    <a href="https://github.com/dtcolligan" class="nav-link">GitHub</a>
  </div>
</nav>
<main id="main-content" class="container">
<h1>Feed</h1>
<p class="post-meta"><xsl:value-of select="atom:feed/atom:subtitle"/></p>

<ul class="post-list">
  <xsl:for-each select="atom:feed/atom:entry">
  <li>
    <span class="date">
      <xsl:variable name="m" select="substring(atom:updated, 6, 2)"/>
      <xsl:choose>
        <xsl:when test="$m='01'">January</xsl:when>
        <xsl:when test="$m='02'">February</xsl:when>
        <xsl:when test="$m='03'">March</xsl:when>
        <xsl:when test="$m='04'">April</xsl:when>
        <xsl:when test="$m='05'">May</xsl:when>
        <xsl:when test="$m='06'">June</xsl:when>
        <xsl:when test="$m='07'">July</xsl:when>
        <xsl:when test="$m='08'">August</xsl:when>
        <xsl:when test="$m='09'">September</xsl:when>
        <xsl:when test="$m='10'">October</xsl:when>
        <xsl:when test="$m='11'">November</xsl:when>
        <xsl:otherwise>December</xsl:otherwise>
      </xsl:choose>
      <xsl:text> </xsl:text>
      <xsl:value-of select="number(substring(atom:updated, 9, 2))"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="substring(atom:updated, 1, 4)"/>
    </span>
    <div class="title">
      <a><xsl:attribute name="href"><xsl:value-of select="atom:link/@href"/></xsl:attribute>
      <xsl:value-of select="atom:title"/></a>
    </div>
    <p><xsl:value-of select="atom:summary"/></p>
  </li>
  </xsl:for-each>
</ul>
</main>
<footer class="site-footer">
  <span>Dom Colligan</span>
  <span>
    <a href="https://github.com/dtcolligan">GitHub</a> ·
    <a href="https://x.com/DominicColligan">X</a> ·
    <a href="mailto:dtcolligan@gmail.com">Email</a>
  </span>
</footer>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
