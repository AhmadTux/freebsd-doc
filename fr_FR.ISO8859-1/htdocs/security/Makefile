# $FreeBSD$

# The FreeBSD French Documentation Project
# Original revision: 1.16

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=
DOCS+=	security.sgml
DOCS+=	advisories.sgml

advisories.sgml: advisories.html.inc

INDEXLINK=	security.html

security.html: advisories.html.inc

DEPENDSET.DEFAULT=	advisories
XML.DEFAULT=		${XML_ADVISORIES}

XMLDOCS=	advisories:mkindex.xsl::advisories.html.inc
NO_DATA.advisories=	yes
NO_TIDY.advisories=	yes

.include "${DOC_PREFIX}/share/mk/web.site.mk"
