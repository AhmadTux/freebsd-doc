# $FreeBSD$

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	machines.sgml refs.sgml
DATA=	i2inside.png mckinley-die.png merced-die.png montecito-die.png

XMLDOCS=	index::news.xml:
XMLDOCS+=	todo::news.xml:

.include "${DOC_PREFIX}/share/mk/web.site.mk"
