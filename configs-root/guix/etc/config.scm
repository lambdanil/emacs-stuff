;; https://github.com/CuBeRJAN/emacs-config

(use-modules (gnu)
             (gnu services)
	     (gnu services dbus)
	     (gnu packages gnome)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu services virtualization)
             (gnu packages fonts)
	     (gnu packages networking)
             (guix packages)
	     (srfi srfi-1))
(use-service-modules linux nix desktop networking ssh xorg)
(use-package-modules linux package-management)

;; Enable nonguix substitutes
(define %my-services
  (modify-services %desktop-services
                   (guix-service-type config => (guix-configuration
                                                 (inherit config)
                                                 (substitute-urls
                                                  (append (list "https://substitutes.nonguix.org")
                                                          %default-substitute-urls))
                                                 (authorized-keys
                                                  (append (list (local-file "./signing-key.pub"))
                                                          %default-authorized-guix-keys))))
		   (dbus-root-service-type config =>
                        (dbus-configuration (inherit config)
                                 (services (list libratbag))))
		   ))

(operating-system
 (locale "cs_CZ.utf8")
 (timezone "Europe/Prague")
 (keyboard-layout (keyboard-layout "cz"))
 (host-name "eternity")
 (kernel linux)
 (groups 
   (cons* 
     (user-group (name "games"))
     %base-groups))
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (users (cons* (user-account
                (name "jan")
                (comment "Jan Novotný")
                (group "users")
                (home-directory "/home/jan")
                (supplementary-groups
                 '("wheel" "netdev" "audio" "video" "lp" "libvirt" "games")))
               %base-user-accounts))
 (packages
  (append
   (map specification->package
        (list
         "nss-certs"
	 "xf86-video-amdgpu"
	 "amdgpu-firmware"
	 "bluez"
         "vim"
	 "libratbag"
         "git"))
   %base-packages))
 (services
  (cons*
   (append
    (list (service gnome-desktop-service-type)
          (bluetooth-service #:auto-enable? #f)
	  (pam-limits-service
           ;; For Lutris / Wine esync
           (list (pam-limits-entry "*" 'hard 'nofile 524288)))
	  ;; For executing binaries
          (extra-special-file "/lib64/ld-linux-x86-64.so.2"
           (file-append glibc "/lib/ld-linux-x86-64.so.2"))
          (set-xorg-configuration
           (xorg-configuration
            (keyboard-layout keyboard-layout)))
          (service libvirt-service-type
                   (libvirt-configuration
                    (unix-sock-group "libvirt")
                    (tls-port "16555")))
          (service zram-device-service-type
                   (zram-device-configuration
                    (size "8172M")
                    (compression-algorithm 'zstd))))
    %my-services)
;;   (remove (lambda (service)
;;	     (eq? (service-kind service) gdm-service-type))
;;	   %my-services)
   ))
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets '("/boot/efi"))
   (keyboard-layout keyboard-layout)))
 (file-systems
  (cons* (file-system
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
	 (file-system
          (mount-point "/mnt/media/jan/external")
          (device
           (uuid "6e008012-794a-40ad-99e9-69825235e4c5"
                 'ext4))
          (type "ext4"))
         %base-file-systems)))
