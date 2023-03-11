;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2015 Mark H Weaver <mhw@netris.org>
;;; Copyright © 2015 Paul van der Walt <paul@denknerd.org>
;;; Copyright © 2015, 2016, 2021 Sou Bunnbu <iyzsong@member.fsf.org>
;;; Copyright © 2015, 2016 Taylan Ulrich Bayırlı/Kammer <taylanbayirli@gmail.com>
;;; Copyright © 2015, 2018, 2023 David Thompson <dthompson2@worcester.edu>
;;; Copyright © 2016 Manolis Fragkiskos Ragkousis <manolis837@gmail.com>
;;; Copyright © 2016, 2017, 2018, 2020 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2017-2023 Nicolas Goaziou <mail@nicolasgoaziou.fr>
;;; Copyright © 2017, 2020, 2021 Tobias Geerinckx-Rice <me@tobias.gr>
;;; Copyright © 2017, 2018, 2019 Rutger Helling <rhelling@mykolab.com>
;;; Copyright © 2019 Pierre Neidhardt <mail@ambrevar.xyz>
;;; Copyright © 2019 David Wilson <david@daviwil.com>
;;; Copyright © 2020 Jakub Kądziołka <kuba@kadziolka.net>
;;; Copyright © 2020 Christopher Howard <christopher@librehacker.com>
;;; Copyright © 2021 Felipe Balbi <balbi@kernel.org>
;;; Copyright © 2021 Felix Gruber <felgru@posteo.net>
;;; Copyright © 2021 Maxim Cournoyer <maxim.cournoyer@gmail.com>
;;; Copyright © 2021 Guillaume Le Vaillant <glv@posteo.net>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (jan packages emulators)
  #:use-module (ice-9 match)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages emulators))

(define-public retroarch-nonfree
  (package
    (inherit retroarch)
    (name "retroarch-nonfree")
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
                  (substitute* "gfx/common/vulkan_common.c"
                    (("libvulkan.so")
                     (string-append vulkan "/lib/libvulkan.so")))
                  (substitute* "gfx/common/wayland/generate_wayland_protos.sh"
                    (("/usr/local/share/wayland-protocols")
                     (string-append wayland-protocols
                                    "/share/wayland-protocols")))
                  (substitute* "qb/qb.libs.sh"
                    (("/bin/true")
                     (which "true")))
                  (substitute* '("libretro-common/file/archive_file_zlib.c"
                                 "libretro-common/streams/trans_stream_zlib.c")
                    (("<compat/zlib.h>")
                     "<zlib.h>"))
                  (invoke "./configure"
                          (string-append "--prefix=" out)
                          "--disable-builtinminiupnpc"))))))))))
