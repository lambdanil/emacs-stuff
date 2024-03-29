(define-module (nil packages distrobox-docker)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (gnu packages docker)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (gnu packages containers))

(define-public distrobox-docker
  (package
   (inherit distrobox)
   (name "distrobox-docker")
   (inputs (modify-inputs (package-inputs distrobox)
			  (append docker)
			  (append docker-cli)
			  (delete "podman")))
   (arguments
    (substitute-keyword-arguments (package-arguments distrobox)
				  ((#:phases phases)
				   #~(modify-phases #$phases
						    (replace 'refer-to-inputs
							     (lambda* (#:key inputs #:allow-other-keys)
							       (delete-file-recursively "docs") ; The files in docs directory break the below substitute*, this is a lazy workaround
							       (copy-file "distrobox-init" "dinit") ; Temporarily move distrobox-init so it isn't affected by regex
							       (substitute* (find-files "." "^distrobox.*[^1]$")
									    (("docker") (search-input-file inputs "/bin/docker"))
									    (("wget") (search-input-file inputs "/bin/wget"))
									    (("command -v") "test -x"))
							       (copy-file "dinit" "distrobox-init") ; move distrobox-init back
							       (delete-file "dinit")))))))))
