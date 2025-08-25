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
						      (replace 'wrap-scripts
							       (lambda _
								 (let ((path (search-path-as-list
									      (list "bin")
									      (list #$(this-package-input "docker")
										    #$(this-package-input "wget")))))
								   (for-each (lambda (script)
									       (wrap-script
										(string-append #$output "/bin/distrobox-"
											       script)
										`("PATH" ":" prefix ,path)))
									     '("assemble"
									       "create"
									       "enter"
									       "ephemeral"
									       "generate-entry"
									       "list"
									       "rm"
									       "stop"
									       "upgrade")))))))))))
