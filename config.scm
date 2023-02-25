;; https://github.com/CuBeRJAN/guix-config

(use-modules (gnu)
             (gnu services)
	     (gnu services dbus)
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
;;		   (dbus-root-service-type config =>
;;                        (dbus-configuration (inherit config)
;;                                 (services (list blueman))))
		   ))

(operating-system
 (locale "cs_CZ.utf8")
 (timezone "Europe/Prague")
 (keyboard-layout (keyboard-layout "cz"))
 (host-name "eternity")
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 (users (cons* (user-account
                (name "jan")
                (comment "Jan Novotný")
                (group "users")
                (home-directory "/home/jan")
                (supplementary-groups
                 '("wheel" "netdev" "audio" "video" "lp" "libvirt")))
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
         "git"))
   %base-packages))
 (services
  (cons*
   (append
    (list (service gnome-desktop-service-type)
          (bluetooth-service #:auto-enable? #f)
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
           (uuid ""
                 'ext4))
          (type "ext4"))
         (file-system
          (mount-point "/boot/efi")
          (device
           (uuid ""
                 'fat32))
          (type "vfat"))
	 (file-system
          (mount-point "/mnt/media/jan/external")
          (device
           (uuid ""
                 'ext4))
          (type "ext4"))
         %base-file-systems)))
