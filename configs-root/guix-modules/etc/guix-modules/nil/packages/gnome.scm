(define-module (nil packages gnome)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (gnu packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages pciutils)
  #:use-module (guix licenses)
  #:use-module (gnu packages base))

(define-public mutter-patched
  (let ((commit "28a6447ff060ae1fbac8f20a13908d6e230eddc2")
	  (revision "1"))
    (package
	(inherit mutter)
	(name "mutter")
	(version (git-version "44" revision commit))
	(source (origin
		  (method git-fetch)
		  (uri (git-reference
			(url "https://gitlab.gnome.org/vanvugt/mutter.git")
			(commit commit)))
		  (file-name (git-file-name name version))
		  (sha256
		   (base32
		    "1ssmflwpmfkn28rmn5glyh96fd5ys9h1j4v70wm4ix2668wk4rr6"))))
	(arguments
	 (substitute-keyword-arguments (package-arguments mutter)
	   ((#:tests? tests? #f) #f)))))) ;; recommend checking tests on version bumps

(define-public gnome-meta-core-shell-patched
  (package
    (inherit gnome-meta-core-shell)
    (name "gnome-meta-core-shell")
    (propagated-inputs
     (modify-inputs (package-propagated-inputs gnome-meta-core-shell)
	 (delete "mutter")
	 (append mutter-patched)))))
