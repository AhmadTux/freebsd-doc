# $FreeBSD$

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# These are turned into validated, normalized HTML files.

DOCS=  about.sgml
DOCS+= administration.sgml
DOCS+= applications.sgml
DOCS+= art.sgml
DOCS+= availability.sgml
DOCS+= docs.sgml
DOCS+= features.sgml
DOCS+= internet.sgml
DOCS+= logo.sgml
DOCS+= mailto.sgml
DOCS+= privacy.sgml
DOCS+= publish.sgml
DOCS+= relnotes.sgml
DOCS+= send-pr.sgml
DOCS+= support.sgml
DOCS+= where.sgml
DOCS+= y2kbug.sgml

XMLDOCS=	index:xsl:${XML_NEWS_NEWS}:
DEPENDSET.index=transtable mirrors news press events \
		advisories notices

XMLDOCS+=	usergroups:${XSL_USERGROUPS}:${XML_USERGROUPS}:
DEPENDSET.usergroups=transtable usergroups
PARAMS.usergroups=	--param pagename "'FreeBSD User Groups'"

XMLDOCS+=	community::${XML_EVENTS_EVENTS}:
DEPENDSET.community=usergroups events

# These will be directly installed.

DATA=	favicon.ico
DATA+=	freebsd.css
DATA+=	index.css
DATA+=	robots.txt
DATA+=	vendors.html

# Subdirectories
# SGML
SUBDIR= FAQ
SUBDIR+= advocacy
SUBDIR+= commercial
SUBDIR+= community
SUBDIR+= copyright
SUBDIR+= developers
SUBDIR+= docproj
SUBDIR+= docs
SUBDIR+= donations
SUBDIR+= events
SUBDIR+= gnome
SUBDIR+= handbook
SUBDIR+= internal
SUBDIR+= ipv6
SUBDIR+= java
SUBDIR+= kse
SUBDIR+= marketing
SUBDIR+= multimedia
SUBDIR+= news
SUBDIR+= platforms
SUBDIR+= portmgr
SUBDIR+= projects
SUBDIR+= prstats
SUBDIR+= releases
SUBDIR+= releng
SUBDIR+= search
SUBDIR+= security
SUBDIR+= smp
SUBDIR+= snapshots
SUBDIR+= support
SUBDIR+= tutorials
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR+= doc
SUBDIR+= ports
.endif
.if defined(BUILD_RELNOTES)
SUBDIR+= relnotes
.endif

# Non-SGML
SUBDIR+= cgi
SUBDIR+= gifs
SUBDIR+= layout
SUBDIR+= logo

.if !defined(WEB_LANG) || empty(WEB_LANG)
WEB_LANG=	da_DK.ISO8859-1 \
		de_DE.ISO8859-1 \
		el_GR.ISO8859-7 \
		es_ES.ISO8859-1 \
		fr_FR.ISO8859-1 \
		hu_HU.ISO8859-2 \
		it_IT.ISO8859-15 \
		ja_JP.eucJP \
		mn_MN.UTF-8 \
		nl_NL.ISO8859-1 \
		pt_BR.ISO8859-1 \
		ru_RU.KOI8-R \
		zh_CN.GB2312 \
		zh_TW.Big5
.endif
.if !defined(ENGLISH_ONLY) || empty(ENGLISH_ONLY)
.for _D in ${WEB_LANG}
SUBDIR+=	../../${_D}/htdocs
.endfor
.endif

WEBDIR?=	data

.include "${DOC_PREFIX}/share/mk/web.site.mk"
