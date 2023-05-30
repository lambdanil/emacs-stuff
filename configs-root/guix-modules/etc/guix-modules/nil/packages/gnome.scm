(define-module (nil packages gnome)
  #:use-module (guix)
  #:use-module (gnu packages gnome))

(define-public gnome-minimal
  (package
    (inherit gnome)
    (name "gnome-minimal")
    (propagated-inputs
     (append
      (modify-inputs (package-propagated-inputs gnome)
	(delete "epiphany")
	(delete "gnome-weather")
	(delete "simple-scan")
	(delete "gnome-maps")
	(delete "cheese")
	(delete "gnome-boxes")
	(delete "gnome-console")
	(delete "gnome-contacts")
	(append gnome-terminal))))))
