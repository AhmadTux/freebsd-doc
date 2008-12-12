<!--
	$FreeBSD$
	$FreeBSDde: de-docproj/share/sgml/freebsd.dsl,v 1.14 2003/05/25 18:08:44 mheinen Exp $
	basiert auf: 1.20
-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 

	<!-- Generate links to HTML man pages -->
	(define %refentry-xref-link% #t)

	(define ($email-footer$)
          (make sequence
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Wenn Sie Fragen zu FreeBSD haben, schicken Sie eine E-Mail an <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:de-bsd-questions@de.FreeBSD.org"))
                  (literal "de-bsd-questions@de.FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "Wenn Sie Fragen zu dieser Dokumentation haben, schicken Sie eine E-Mail an <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:de-bsd-translators@de.FreeBSD.org"))
                  (literal "de-bsd-translators@de.FreeBSD.org"))
	        (literal ">.")))))
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>