# $FreeBSD$
# Original revision: 1.7

.if exists(../Makefile.conf)
.include "../Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

DOCS=	announce.sgml
DOCS+=	hardware.sgml
#DOCS+=	installation.sgml
#DOCS+=	qa.sgml
DOCS+=	relnotes.sgml
#DOCS+=	schedule.sgml

DATA=	docbook.css
DATA+=	errata.html
#DATA+=	hardware-alpha.html
#DATA+=	hardware-i386.html
#DATA+=	installation-alpha.html
#DATA+=	installation-i386.html
#DATA+=	readme.html
DATA+=	relnotes-alpha.html
DATA+=	relnotes-i386.html

### Revision checking
REVCHECK=       YES

.include "${DOC_PREFIX}/share/mk/web.site.mk"
