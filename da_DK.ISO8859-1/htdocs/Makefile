# $FreeBSD$

.if exists(Makefile.conf)
.include "Makefile.conf"
.endif
.if exists(../Makefile.inc)
.include "../Makefile.inc"
.endif

# Subdirectories
# SGML
.if !defined(WEB_ONLY) || empty(WEB_ONLY)
SUBDIR=  doc
.endif

WEBDIR?=	data/da

.include "${DOC_PREFIX}/share/mk/web.site.mk"
