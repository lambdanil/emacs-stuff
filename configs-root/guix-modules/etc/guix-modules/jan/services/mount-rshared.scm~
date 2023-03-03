(define-module (jan services mount-rshared)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (gnu packages linux)
  #:use-module (guix utils)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module (guix build utils))

(define-public mount-rshared-service
  (simple-service 'mount-rshared shepherd-root-service-type
		  (list (shepherd-service
			 (provision '(mount-rshared))
			 (requirement '(user-processes))
			 (start #~(lambda ()
				    (invoke
				     #$(file-append util-linux "/bin/mount")
				     "--make-rshared" "/")))
			 (respawn? #f)))))
