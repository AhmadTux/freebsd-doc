#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/www/ru/ports/Makefile,v 1.9 2004/03/23 21:09:19 phantom Exp $
#
# Original revision: 1.38
#

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif
.if exists(${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/Makefile.inc)
.include "${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/Makefile.inc"
.endif

FETCH_OPT?=	-am

.if defined(PINDEX_OVERRIDE)
${INDEX}: ${PINDEX_OVERRIDE}
	${CP} ${PINDEX_OVERRIDE} ${INDEX}
.elif defined(NOPORTSNET)
${INDEX}: $${PORTSBASE}/${PINDEX}
	${CP} ${PORTSBASE}/${PINDEX} ${INDEX}
.else
${INDEX}:
	${FETCH} ${FETCH_OPT} -o ${INDEX}.bz2 ${INDEXURI}.bz2
	${BUNZIP2} ${INDEX}.bz2
.endif

# build the list of available packages only on the 
# main FreeBSD machines
hostname!= hostname

#
# don't build the packages links if NO_PACKAGES_LINK
# is set and not empty.
#
# XXX: you can set NO_PACKAGES_LINK to your hostname to
#      test the packages link generation
#
.if defined(NO_PACKAGES_LINK) && !empty(NO_PACKAGES_LINK)
hostname=	${NO_PACKAGES_LINK}
.endif

packages.exists:
.if ${hostname} == "hub.freebsd.org" || ${hostname} == "freefall.freebsd.org" || ${hostname} == "www.freebsd.org"
.if  exists(${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/packages.exists)
	${CP} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/${.TARGET} ${.CURDIR}
.else
	@if ${SH} ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/packages > ${.TARGET}.temp; then \
		${MV} ${.TARGET}.temp ${.TARGET}; \
	else \
		${RM} ${.TARGET}.temp; ${TOUCH} ${.TARGET}; \
	fi;
.endif
.else
	${TOUCH} ${.TARGET}
.endif

Makefile.gen: index.sgml .NOTMAIN
	(	${ECHO_CMD} TIDY=${PERL};\
		${ECHO_CMD} TIDYOPTS="-i'' -npe 's,\"-//FreeBSD//DTD HTML 4.01 Transitional-Based Extension//EN\",\"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\",'";\
		${ECHO_CMD} DOCS= *.sgml;\
		${ECHO_CMD} -n "DYNAMIC_DOCS= ";\
		${ECHO_CMD} -n " master-index.sgml";\
		${ECHO_CMD} -n " index.sgml";\
	) > Makefile.gen
	for categoryfile in ${CATEGORYLIST}; do \
		${ECHO_CMD} -n " $$categoryfile.sgml" >> Makefile.gen; \
	done
.if defined(NO_TIDY)
	${ECHO_CMD} NO_TIDY=${NO_TIDY} >> Makefile.gen
.endif

index.sgml: ${INDEX} categories packages.exists portindex ports.inc .NOTMAIN
	${RM} -f *.sgml
	${PORTINDEX} ${INDEX} ${.CURDIR}

# this builds: categories-alpha.sgml, categories-grouped.sgml,
# master-index.sgml, statistics.ent, <category>.sgml
CATEGORYLIST=`grep "^[a-z]" ${DOC_PREFIX}/en_US.ISO8859-1/htdocs/ports/categories | sed -e s"/,.*//"`

install: all beforeinstall

all install clean:
	cd ${.CURDIR}; \
		${MAKE} ${MAKEFLAGS} -f ${.CURDIR}/Makefile.inc0 ${.TARGET}
#.if defined(WITH_PORTS_GROWTH)
#	cd growth; \
#		${MAKE} ${MAKEFLAGS} ${.TARGET}
#beforeinstall:
#.else
beforeinstall:
	${PERL} -pi -e 's/href=\"growth/href=\"http:\/\/www.FreeBSD.org\/ports\/growth/' index.html
#.endif

.include "${DOC_PREFIX}/share/mk/web.site.mk"
