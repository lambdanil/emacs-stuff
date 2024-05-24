(define-module (nil packages throttled)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (gnu packages)
  #:use-module (guix git-download)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pciutils)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages python-xyz)
  #:use-module (guix licenses)
  #:use-module (gnu packages base)
  #:use-module (guix build-system python)
  #:use-module (gnu packages python))

(define-public throttled
  (let ((commit "596ad496e8c5cff2aae6977de6a9e1546bf51cbf")
	(revision "1"))
    (package
      (name "throttled")
      (version (git-version "0.10.99" revision commit))
      (source (origin
		(method git-fetch)
		(uri (git-reference
		      (url "https://github.com/erpalma/throttled/")
		      (commit commit)))
		(file-name (git-file-name name version))
		(sha256
		 (base32
		  "10ki1hjisalsqjknmrj6m6zc7cq3mqkfzi7j5bl9ysh9yh1dlzaq"))))
      (build-system python-build-system)
      (inputs (list pciutils python-pygobject python-dbus-python python-configparser gcc-toolchain pkg-config cairo gobject-introspection dbus))
      (native-inputs (list python))
      (arguments
       `(#:phases
	 (modify-phases %standard-phases
	   (delete 'build)
	   (delete 'check)
	   (replace 'install
	     (lambda* (#:key inputs outputs #:allow-other-keys)
	       (use-modules (guix build utils))
	       (let* ((sitedir (site-packages inputs outputs))
		      (source (assoc-ref %build-inputs "source"))
		      (coreutils (assoc-ref %build-inputs "coreutils"))
		      (pciutils (assoc-ref %build-inputs "pciutils"))
		      (python (assoc-ref %build-inputs "python"))
		      (out (assoc-ref %outputs "out"))
		      (python-sitedir
		       (string-append out "/lib/python"
				      (python-version python)
				      "/site-packages")))
		 (substitute* "throttled.py"
		   (("setpci")
		    (string-append pciutils "/sbin/setpci")))
		 (mkdir-p python-sitedir)
		 (mkdir-p (string-append out "/bin/"))
		 (copy-file "throttled.py" (string-append out "/bin/throttled"))
		 (copy-file "mmio.py" (string-append python-sitedir "/mmio.py"))
		 (wrap-program (string-append out "/bin/throttled")
		   `("GUIX_PYTHONPATH" ":" suffix
		     ,(list sitedir python-sitedir)))
		 ))))))
      (synopsis "")
      (description "")
      (home-page "https://github.com/erpalma/throttled")
      (license expat))))
