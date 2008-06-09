<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE xsl:stylesheet PUBLIC "-//FreeBSD//DTD FreeBSD XSLT 1.0 DTD Fragment//EN"
				"http://www.FreeBSD.org/XML/www/share/sgml/xslt10-freebsd.dtd" [
<!ENTITY title "FreeBSD Events">
<!ENTITY email "freebsd-www">
<!ENTITY rsslink "&base;/events/rss.xml">
<!ENTITY rsstitle "Upcoming FreeBSD Events">
<!ENTITY % navinclude.about "INCLUDE">
<!ENTITY % header.rss "INCLUDE">
]>

<!-- $FreeBSD: www/share/sgml/templates.events.xsl,v 1.6 2008/06/08 22:29:31 murray Exp $ -->

<!-- Copyright (c) 2003 Simon L. Nielsen <simon@FreeBSD.org>
     All rights reserved.

     Redistribution and use in source and binary forms, with or without
     modification, are permitted provided that the following conditions
     are met:
     1. Redistributions of source code must retain the above copyright
	notice, this list of conditions and the following disclaimer.
     2. Redistributions in binary form must reproduce the above copyright
	notice, this list of conditions and the following disclaimer in the
	documentation and/or other materials provided with the distribution.

     THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
     ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
     ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
     FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
     DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
     OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
     HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
     LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
     OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
     SUCH DAMAGE.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns:cvs="http://www.FreeBSD.org/XML/CVS"
  xmlns:date="http://exslt.org/dates-and-times"
  extension-element-prefixes="date"
  exclude-result-prefixes="cvs">

  <xsl:import href="http://www.FreeBSD.org/XML/www/lang/share/sgml/libcommon.xsl"/>

  <xsl:variable name="date">
    <xsl:value-of select="//cvs:keyword[@name='freebsd']"/>
  </xsl:variable>

  <xsl:output method="xml" encoding="&xml.encoding;"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>

  <xsl:key name="event-by-month" match="event"
    use="concat(startdate/year, format-number(startdate/month, '00'))"/>

  <xsl:key name="event-by-country" match="event"
    use="location/country" />

  <xsl:key name="upcoming-event-by-country" match="event[((number(enddate/year) &gt; number($curdate.year)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) &gt; number($curdate.month)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) = number($curdate.month) and
	     enddate/day &gt;= $curdate.day))]"
    use="location/country" />

  <xsl:variable name="charturl" select="'http://chart.apis.google.com/chart?cht=t&amp;chs=400x200&amp;chtm=world&amp;chco=ffffff,ffbe38,600000&amp;chf=bg,s,4D89F9'" />

  <!-- Template: events -->
  <xsl:template match="events">
  <xsl:variable name="chart-countries">
    <xsl:for-each select="event[
	generate-id() =
	generate-id(key('event-by-country', location/country)[1])]">
      <xsl:sort select="format-number(count(key('event-by-country', location/country)), '000')" order="descending"/>
        <xsl:value-of select="location/country/@code" />
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="chart-country-counts">
    <xsl:for-each select="event[
	generate-id() =
	generate-id(key('event-by-country', location/country)[1])]">
      <xsl:sort select="format-number(count(key('event-by-country', location/country)), '000')" order="descending"/>
        <xsl:if test="count(key('upcoming-event-by-country', location/country)) != 0">100.0</xsl:if>
        <xsl:if test="count(key('upcoming-event-by-country', location/country)) = 0"><xsl:value-of select="count(key('event-by-country', location/country))" />.0</xsl:if>
        <xsl:if test="position()!=last()">,</xsl:if></xsl:for-each>
  </xsl:variable>

  <xsl:variable name="imageurl"><xsl:value-of select="$charturl"/>&amp;chd=t:<xsl:value-of select="$chart-country-counts"/>&amp;chld=<xsl:value-of select="$chart-countries"/></xsl:variable>

    <html>
      &header1;

      <body>

	<div id="containerwrap">
	  <div id="container">
	  &header2;

	    <div id="content">
              <div id="SIDEWRAP">
                &nav;
                <div id="FEEDLINKS">
                  <ul>
                    <li>
                      <a href="&rsslink;" title="&rsstitle;">
                        RSS 2.0 Feed
                      </a>
                    </li>
                  </ul>
                </div> <!-- FEEDLINKS -->
              </div> <!-- SIDEWRAP -->

	      <div id="contentwrap">
		&header3;
 	<!--
	     Note the current date to have a reference, if the
	     upcoming/past events are split incorrectly.
	-->
	<xsl:comment>
	  <xsl:text>Generated on: </xsl:text>
	  <xsl:value-of select="concat($curdate.year,
	    format-number($curdate.month, '00'),
	    format-number($curdate.day, '00'))"/>
	</xsl:comment>

		<xsl:call-template name="html-events-list-preface" />

		<xsl:call-template name="html-events-map">
		  <xsl:with-param name="mapurl" select="$imageurl" />
		</xsl:call-template>

		<xsl:call-template name="html-events-list-upcoming-heading" />

	<xsl:for-each select="event[generate-id() =
          generate-id(key('event-by-month',
	    concat(startdate/year, format-number(startdate/month, '00')))[1])
	  and ((number(enddate/year) &gt; number($curdate.year)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) &gt; number($curdate.month)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) = number($curdate.month) and
	     enddate/day &gt;= $curdate.day))]">

	  <xsl:sort select="startdate/year" order="ascending"/>
	  <xsl:sort select="format-number(startdate/month, '00')" order="ascending"/>
	  <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>

	  <h3>
	    <xsl:attribute name="id">
	      <xsl:text>month:</xsl:text>
	      <xsl:value-of select="concat(startdate/year,
		format-number(startdate/month, '00'))"/>
	    </xsl:attribute>
	    <xsl:call-template name="gen-long-en-month">
	      <xsl:with-param name="nummonth" select="startdate/month"/>
	    </xsl:call-template>
	    <xsl:text> </xsl:text>
	    <xsl:value-of select="startdate/year"/>
	  </h3>

	  <ul>
	    <xsl:for-each select="key('event-by-month',
	      concat(startdate/year, format-number(startdate/month, '00')))">

	      <xsl:sort select="format-number(startdate/day, '00')" order="ascending"/>
	      <xsl:apply-templates select="." mode="upcoming"/>
	    </xsl:for-each>
	  </ul>
	</xsl:for-each>

		<xsl:call-template name="html-events-list-past-heading" />

	<xsl:for-each select="event[generate-id() =
	  generate-id(key('event-by-month', concat(startdate/year,
	    format-number(startdate/month, '00')))[1])
	  and ((number(enddate/year) &lt; number($curdate.year)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) &lt; number($curdate.month)) or
	    (number(enddate/year) = number($curdate.year) and
	     number(enddate/month) = number($curdate.month) and
	     number(enddate/day) &lt; number($curdate.day)))]">

	  <xsl:sort select="number(startdate/year)" order="descending"/>
	  <xsl:sort select="format-number(startdate/month, '00')" order="descending"/>
	  <xsl:sort select="format-number(startdate/day, '00')" order="descending"/>

	  <h3>
	    <xsl:attribute name="id">
	      <xsl:text>month:</xsl:text>
	      <xsl:value-of select="concat(startdate/year,
		format-number(startdate/month, '00'))"/>
	    </xsl:attribute>
	    <xsl:call-template name="gen-long-en-month">
	      <xsl:with-param name="nummonth" select="startdate/month"/>
	    </xsl:call-template >
	    <xsl:text> </xsl:text>
	    <xsl:value-of select="startdate/year"/>
	  </h3>

	  <ul>
	    <xsl:for-each select="key('event-by-month',
	      concat(startdate/year, format-number(startdate/month, '00')))">

	      <xsl:sort select="format-number(startdate/day, '00')" order="descending"/>
	      <xsl:apply-templates select="."/>
	    </xsl:for-each>
	  </ul>
	</xsl:for-each>
	      </div> <!-- contentwrap -->

	      <br class="clearboth" />
	    </div> <!-- content -->

            <div id="FOOTER">
               &copyright;<br />
               &date;
            </div> <!-- FOOTER -->
	  </div> <!-- container -->
	</div> <!-- containerwrap -->
      </body>
    </html>
  </xsl:template>

  <!-- Template: event -->
  <xsl:template name="eventbody">
      <xsl:attribute name="id">
	<xsl:call-template name="generate-event-anchor"/>
      </xsl:attribute>

      <p>
	<b>
	  <xsl:if test="url">
	    <xsl:apply-templates select="url"/>
	  </xsl:if>
	  <xsl:if test="not(url)">
	    <xsl:value-of select="name"/>
	  </xsl:if>
	</b>
	<xsl:if test="location/site!=''">
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="location/site"/>
	</xsl:if>
	<xsl:if test="location/city!=''">
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="location/city"/>
	</xsl:if>
	<xsl:if test="location/state!=''">
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="location/state"/>
	</xsl:if>
	<xsl:if test="location/country!=''">
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="location/country"/>
	</xsl:if>
	<br/>
	<em>
	  <xsl:call-template name="gen-date-interval">
	    <xsl:with-param name="startdate" select="startdate" />
	    <xsl:with-param name="enddate" select="enddate" />
	  </xsl:call-template>
	</em><br/>
	<xsl:copy-of select="description/child::node()"/>
      </p>
      <xsl:if test="link">
	<p><xsl:apply-templates select="link"/></p>
      </xsl:if>
  </xsl:template>

  <!-- Template: event -->
  <xsl:template match="event" mode="upcoming">
    <li>
      <xsl:call-template name="eventbody"/>
      <p>Social links: <a rel="nofollow">
        <xsl:attribute name="href">http://upcoming.yahoo.com/search?type=Events&amp;q=<xsl:value-of select="name" />&amp;Search=GO</xsl:attribute>
upcoming</a></p>
    </li>
  </xsl:template>

  <!-- Template: event -->
  <xsl:template match="event">
    <li>
      <xsl:call-template name="eventbody"/>
      <p>Social links: <a rel="nofollow">
        <xsl:attribute name="href">http://www.flickr.com/search/?w=all&amp;q=<xsl:value-of select="name" />&amp;m=text</xsl:attribute>
      Flickr</a>, <a rel="nofollow">
        <xsl:attribute name="href">http://blogsearch.google.com/blogsearch?q=<xsl:value-of select="name" /></xsl:attribute>Blog Search</a>.</p>
    </li>
  </xsl:template>

  <!-- Template: link -->
  <xsl:template match="link">
    <xsl:apply-templates select="url"/>
    <xsl:if test="not(position()=last())">
      <xsl:text>&nbsp;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- Template: url -->
  <xsl:template match="url">
    <a>
      <xsl:attribute name="href">
	<xsl:if test="@type='freebsd-website'">&base;</xsl:if>
        <xsl:value-of select="."/>
      </xsl:attribute>
      <xsl:value-of select="../name"/>
    </a>
  </xsl:template>
</xsl:stylesheet>