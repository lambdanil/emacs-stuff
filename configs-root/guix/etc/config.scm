(add-to-load-path "/etc/guix-modules")

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
	     (nil services virsh)
	     (nil packages gnome)
	     (gnu packages fonts)
	     (gnu packages networking)
	     (guix gexp)
	     (guix packages)
	     (srfi srfi-1))
(use-service-modules linux desktop networking ssh xorg)
(use-package-modules linux package-management)

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
							       (services (list libratbag blueman))))))

(operating-system

 (locale "cs_CZ.utf8")
 (timezone "Europe/Prague")
 (keyboard-layout (keyboard-layout "cz"))

 (host-name "eternity")

(kernel linux)
(initrd microcode-initrd)
(firmware (list linux-firmware))

(groups 
 (cons* 
  (user-group (name "games")) ;; For libratbagd
  (user-group (name "realtime"))
  %base-groups))

(users (cons* (user-account
	       (name "nil")
	       (comment "(lambda () nil)")
	       (group "users")
	       (home-directory "/home/nil")
	       (supplementary-groups
		'("wheel" "netdev" "audio" "video" "lp" "libvirt" "kvm" "games" "docker" "realtime")))
	      %base-user-accounts))

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
	"xdg-desktop-portal-gtk"
	"libratbag"
	"git"))
  %base-packages))

(services
 (append
  (list
   (service xfce-desktop-service-type)

   (service bluetooth-service-type
		 (bluetooth-configuration
		  (auto-enable? #f)))

mount-rshared-service

virsh-net-default-service

(service pam-limits-service-type
	 (list (pam-limits-entry "*" 'hard 'nofile 524288)
	       (pam-limits-entry "@realtime" 'both 'rtprio 99)
	       (pam-limits-entry "@realtime" 'both 'memlock 'unlimited)))

(extra-special-file "/lib64/ld-linux-x86-64.so.2"
		    (file-append glibc "/lib/ld-linux-x86-64.so.2"))

(set-xorg-configuration
 (xorg-configuration
  (keyboard-layout keyboard-layout)))

(service virtlog-service-type
	 (virtlog-configuration
	  (max-clients 1000)))

(service libvirt-service-type
	 (libvirt-configuration
	  (unix-sock-group "libvirt")
	  (tls-port "16555")))

(service docker-service-type)

(service zram-device-service-type
	 (zram-device-configuration
	  (size "8172M")
	  (compression-algorithm 'zstd))))
%my-services))

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
    (uuid "bf1f6abc-05d4-430f-8da3-88af822fd603"
	  'ext4))
   (type "ext4"))
  (file-system
   (mount-point "/boot/efi")
   (device
    (uuid "8111-C019"
	  'fat32))
   (type "vfat"))
  (file-system ;; Second hard drive
   (mount-point "/mnt/media/nil/external")
   (device
    (uuid "6e008012-794a-40ad-99e9-69825235e4c5"
	  'ext4))
   (type "ext4"))
  %base-file-systems)))
