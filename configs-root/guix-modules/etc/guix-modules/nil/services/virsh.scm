(define-module (nil services virsh)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (guix packages)
  #:use-module (gnu packages virtualization)
  #:use-module (guix utils)
  #:use-module (gnu services)
  #:use-module (gnu services shepherd)
  #:use-module (guix build utils))

(define default-config "
<network>
  <name>default</name>
  <bridge name='virbr0'/>
  <forward/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
")

(define-public virsh-net-default-service
  (let ((config (plain-file "default.xml" default-config)))
    (simple-service 'virsh-net-default-service shepherd-root-service-type
		    (list (shepherd-service
			   (provision '(virsh-net-default))
			   (requirement '(libvirtd NetworkManager))
			   (start #~(lambda ()
				      (invoke
				       #$(file-append libvirt "/bin/virsh")
				       "net-create" #$config)))
			   (stop #~(lambda ()
				     (invoke
				      #$(file-append libvirt "/bin/virsh")
				      "net-destroy" "default")))
			   (respawn? #f))))))
