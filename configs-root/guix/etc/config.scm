;; ------------------------------------------
;;  https://github.com/CuBeRJAN/emacs-config
;; ------------------------------------------

(add-to-load-path "/etc/guix-modules") ;; Add custom modules

;; Import necessary modules ----------------------------------------------------
(use-modules (gnu)
             (gnu services)
	     (gnu services dbus)
	     (gnu packages gnome)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu services virtualization)
	     (gnu services shepherd)
	     (gnu services admin)
	     (guix channels)
	     (gnu services mcron)
	     (gnu services docker)
	     (nil services mount-rshared)
             (gnu packages fonts)
	     (gnu packages networking)
	     (guix gexp)
             (guix packages)
	     (srfi srfi-1))
(use-service-modules linux desktop networking ssh xorg)
(use-package-modules linux package-management)
;; -----------------------------------------------------------------------------

;; Service modifications -------------------------------------------------------
(define %my-services
  (modify-services %desktop-services

		   ;; nonguix substitutes --------------------------------------
                   (guix-service-type config => (guix-configuration
                                                 (inherit config)
                                                 (substitute-urls
                                                  (append (list "https://substitutes.nonguix.org")
                                                          %default-substitute-urls))
                                                 (authorized-keys
                                                  (append (list (local-file "./signing-key.pub"))
                                                          %default-authorized-guix-keys))))
		   ;; ----------------------------------------------------------


		   ;; additional dbus services ---------------------------------
		   (dbus-root-service-type config =>
		        (dbus-configuration (inherit config)
			        (services (list libratbag blueman))))))
                   ;; ----------------------------------------------------------
;; -----------------------------------------------------------------------------

;; OS config -------------------------------------------------------------------
(operating-system

 ;; Localization ---------------------------------------------------------------
 (locale "cs_CZ.utf8")
 (timezone "Europe/Prague")
 (keyboard-layout (keyboard-layout "cz"))
 ;; ----------------------------------------------------------------------------

 ;; Account and group configuration --------------------------------------------
 (host-name "eternity")
 (kernel linux)
 (groups 
  (cons* 
   (user-group (name "games")) ;; For libratbagd
   (user-group (name "realtime"))
   %base-groups))
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (users (cons* (user-account
                (name "nil")
                (comment "(lambda () nil)")
                (group "users")
                (home-directory "/home/nil")
                (supplementary-groups
                 '("wheel" "netdev" "audio" "video" "lp" "libvirt" "kvm" "games" "docker" "realtime")))
               %base-user-accounts))
  ;; ---------------------------------------------------------------------------

 ;; System packages ------------------------------------------------------------
 (packages
  (append
   (map specification->package
        (list
         "nss-certs"
	 "xf86-video-amdgpu"
	 "amdgpu-firmware"
	 "bluez"
	 "blueman"
         "vim"
	 "libratbag"
         "git"))
   %base-packages))
  ;; ---------------------------------------------------------------------------

 ;; System services ------------------------------------------------------------
 (services
   (append
    (list (service xfce-desktop-service-type)
	  
          (service bluetooth-service-type
		   (bluetooth-configuration
		    (auto-enable? #f)))
	  
	  mount-rshared-service ;; Automatically mount / with --make-rshared, necessary for distrobox
	  
	  (pam-limits-service ;; For Lutris / Wine esync
           (list (pam-limits-entry "*" 'hard 'nofile 524288)
		 (pam-limits-entry "@realtime" 'both 'rtprio 99) ;; For jackd in realtime
		 (pam-limits-entry "@realtime" 'both 'memlock 'unlimited)))
	  
          (extra-special-file "/lib64/ld-linux-x86-64.so.2" ;; For executing precompiled binaries
			      (file-append glibc "/lib/ld-linux-x86-64.so.2"))
	  
          (set-xorg-configuration
           (xorg-configuration
            (keyboard-layout keyboard-layout)))

	  ;; VM stuff ----------------------------------------------------------
	  (service virtlog-service-type
		   (virtlog-configuration
		    (max-clients 1000)))
	  
          (service libvirt-service-type
                   (libvirt-configuration
                    (unix-sock-group "libvirt")
                    (tls-port "16555")))
	  ;; -------------------------------------------------------------------

	  (service docker-service-type)
	  
          (service zram-device-service-type
                   (zram-device-configuration
                    (size "8172M")
                    (compression-algorithm 'zstd))))
    %my-services))
;;   (remove (lambda (service)
;;	     (eq? (service-kind service) gdm-service-type))
;;	   %my-services)
 ;; ----------------------------------------------------------------------------

 ;; Bootloader and disk config -------------------------------------------------
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets '("/boot/efi"))
   (timeout 3)
   (keyboard-layout keyboard-layout)))
 (file-systems
  (cons*   
   (file-system
     (mount-point "/")
     (device
      (uuid "fd02d6c6-5ff1-48d9-b9cb-a444ceb260dd"
            'ext4))
     (type "ext4"))
   (file-system
     (mount-point "/boot/efi")
     (device
      (uuid "D846-4633"
            'fat32))
     (type "vfat"))
   (file-system ;; Second hard drive
     (mount-point "/mnt/media/nil/external")
     (device
      (uuid "6e008012-794a-40ad-99e9-69825235e4c5"
            'ext4))
     (type "ext4"))
   %base-file-systems)))
;; -----------------------------------------------------------------------------
;; -----------------------------------------------------------------------------
