(define-module (nil packages brogue)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix licenses)
  #:use-module (guix gexp)
  #:use-module (gnu packages sdl))

(define-public brogue-ce
  (package
    (name "brogue-ce")
    (version "1.12")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/tmewett/BrogueCE/archive/refs/tags/v" version
                                  ".tar.gz"))
              (sha256
               (base32
                "0a6l7j91iq0mv7zrxnlxx6ll5rfwvgfyk5h1gc9m5qzll1n3zvdf"))))
    (build-system gnu-build-system)
    (arguments
     (list 
      #:make-flags #~(list "CC=gcc")
      #:tests? #f
      #:phases
      #~(modify-phases %standard-phases
	  (delete 'configure)
	  (add-before 'build 'change-datadir-path
	    (lambda _
	      (map
	       (lambda (substitutes)
		 (substitute* "config.mk"
		   (((car substitutes))
		    (cdr substitutes))))
	       `(("^DATADIR := ." . ,(string-append "DATADIR := " #$output "/share"))
		 ("^RELEASE := NO" . "RELEASE := YES")))))
	  (replace 'install
	    (lambda _
	      (mkdir-p (string-append #$output "/bin"))
	      (copy-file "bin/brogue" (string-append #$output "/bin/.brogue_real"))
	      (call-with-output-file (string-append #$output "/bin/brogue") ; Wrap around executable and execute in ~/.local
		(lambda (file)
		  (format file "~A" (string-append
				     "mkdir -p \"$HOME/.local/share/brogue\" && cd \"$HOME/.local/share/brogue\" && "
				     #$output "/bin/.brogue_real"))))
	      (invoke "chmod" "+x" (string-append #$output "/bin/brogue"))
	      (copy-recursively "bin/assets" (string-append #$output "/share/assets"))
	      (make-desktop-entry-file
	       (string-append  #$output "/share/applications/brogue.desktop")
	       #:name "Brogue"
	       #:exec "brogue"
	       #:categories '("RolePlaying" "Game")
	       #:keywords
	       '("adventure" "singleplayer")
	       #:comment
	       '((#f "Brave the Dungeons of Doom!"))))))))
    (inputs (list (sdl-union (list sdl2 sdl2-image))))
    (synopsis "Brogue CE: A dungeon crawler roguelike")
    (description "Community fork of Brogue")
    (home-page "https://github.com/tmewett/BrogueCE")
    (license agpl3)))
