# $FreeBSD$
# The FreeBSD Russian Documentation Project
# $FreeBSDru: frdp/www/ru/search/Makefile,v 1.3 2003/09/22 09:27:00 den Exp $
# Original revision: 1.9

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif

.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS+= index-site.sgml
DOCS+= search.sgml 
DOCS+= searchhints.sgml
DOCS+= search-mid.sgml

INDEXLINK=	search.html
CLEANFILES+=atoz.sgml site.sgml


index-site.html: atoz.sgml site.sgml
atoz.sgml: web.atoz 
	${SORT} -fu ${.ALLSRC} | ${PERL} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/search/atoz.pl > ${.TARGET}

site.sgml: site.map
	${PERL} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/search/site.pl < ${.ALLSRC} > ${.TARGET}

.include "${DOC_PREFIX}/share/mk/web.site.mk"
