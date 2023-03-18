;; Retroarch patched to include the core downloader

(define-module (jan packages emulators)
  #:use-module (ice-9 match)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages emulators))

(define-public retroarch-nonfree
  (package
    (inherit retroarch)
    (name "retroarch-nonfree")
    (inputs (modify-inputs (package-inputs retroarch)
              (append glu)
              (append libaio)))
    (arguments
     (substitute-keyword-arguments (package-arguments retroarch)
       ((#:phases phases)
        #~(modify-phases #$phases
            (replace 'configure
              (lambda* (#:key inputs outputs #:allow-other-keys)
                (let* ((out (assoc-ref outputs "out"))
                       (etc (string-append out "/etc"))
                       (vulkan (assoc-ref inputs "vulkan-loader"))
                       (wayland-protocols (assoc-ref inputs
                                                     "wayland-protocols")))
                  ;; Hard-code some store file names.
                  (substitute* "gfx/common/vulkan_common.c"
                    (("libvulkan.so")
                     (string-append vulkan "/lib/libvulkan.so")))
                  (substitute* "gfx/common/wayland/generate_wayland_protos.sh"
                    (("/usr/local/share/wayland-protocols")
                     (string-append wayland-protocols
                                    "/share/wayland-protocols")))

                  ;; The configure script does not yet accept the extra arguments
                  ;; (like ‘CONFIG_SHELL=’) passed by the default configure phase.
                  (invoke "./configure"
                          (string-append "--prefix=" out)
                          ;; Non-free software are available through the core updater,
                          ;; disable it.  See <https://issues.guix.gnu.org/38360>.
                          "--disable-builtinzlib"))))
            (add-after 'install 'append-extra-libs
              (lambda* (#:key inputs #:allow-other-keys)
                (wrap-program (string-append #$output "/bin/retroarch")
                              `("LD_LIBRARY_PATH" ":" prefix
                                (,(string-append #$(this-package-input "glu")
                                                 "/lib" ":"
                                                 #$(this-package-input
                                                    "libaio") "/lib"))))))))))))
