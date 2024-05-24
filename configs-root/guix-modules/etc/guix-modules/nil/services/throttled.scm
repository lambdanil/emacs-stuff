(define-module (nil services throttled)
  #:use-module (nil packages throttled)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix records)
  #:use-module (guix modules)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services configuration)
  #:use-module (gnu services dbus)
  #:use-module (gnu services shepherd)
  #:use-module (guix gexp)
  #:use-module (ice-9 match)
  #:export (throttled-configuration
	    throttled-configuration?
	    throttled-service-type))

(define (non-negative-integer? val)
  (and (exact-integer? val) (not (negative? val))))
(define (non-negative-float? val)
  (not (negative? val)))
(define-maybe file-like)
(define-maybe/no-serialization string)


(define-configuration throttled-configuration
  (throttled
   (file-like throttled)
   "The THROTTLED package.")

  (throttled-enable?
   (boolean #t)
   "Enable or disable the script execution.")

  (sysfs-power-path
   (string "/sys/class/power_supply/AC*/online")
   "SYSFS path for checking if the system is running on AC power.")

  (bat-update-rate-s
   (non-negative-integer 30)
   "Update the registers every this many seconds.")

  (bat-pl1-tdp-w
   (non-negative-integer 29)
   "Max package power for time window #1.")

  (bat-pl1-duration-s
   (non-negative-integer 28)
   "Time window #1 duration.")

  (bat-pl2-tdp-w
   (non-negative-integer 44)
   "Max package power for time window #2.")

  (bat-pl2-duration-s
   (non-negative-float 0.002)
   "Time window #2 duration.")

  (bat-trip-temp-c
   (non-negative-integer 85)
   "Max allowed temperature before throttling.")

  (ac-update-rate-s
   (non-negative-integer 5)
   "Update the registers every this many seconds.")

  (ac-pl1-tdp-w
   (non-negative-integer 44)
   "Max package power for time window #1.")

  (ac-pl1-duration-s
   (non-negative-integer 28)
   "Time window #1 duration.")

  (ac-pl2-tdp-w
   (non-negative-integer 44)
   "Max package power for time window #2.")

  (ac-pl2-duration-s
   (non-negative-float 0.002)
   "Time window #2 duration.")

  (ac-trip-temp-c
   (non-negative-integer 90)
   "Max allowed temperature before throttling.")

  (no-serialization))

(define (generate-throttled-config config)
  (string-append "[GENERAL]\n"
		 "Enabled: "
		 (if (throttled-configuration-throttled-enable? config) "True" "False")
		 "\n"
		 "Sysfs_Power_Path: "
		 (throttled-configuration-sysfs-power-path config)
		 "\n"
		 "Autoreload: True"
		 "\n\n"
		 "[BATTERY]\n"
		 "Update_Rate_s: "
		 (number->string (throttled-configuration-bat-update-rate-s config))
		 "\n"
		 "PL1_Tdp_W: "
		 (number->string (throttled-configuration-bat-pl1-tdp-w config))
		 "\n"
		 "PL1_Duration_s: "
		 (number->string (throttled-configuration-bat-pl1-duration-s config))
		 "\n"
		 "PL2_Tdp_W: "
		 (number->string (throttled-configuration-ac-pl2-tdp-w config))
		 "\n"
		 "PL2_Duration_S: "
		 (number->string (throttled-configuration-bat-pl2-duration-s config))
		 "\n"
		 "Trip_Temp_C: "
		 (number->string (throttled-configuration-bat-trip-temp-c config))
		 "\n"
		 "cTDP: 0\nDisable_BDPROCHOT: False\n\n"
		 "[AC]\n"
		 "Update_Rate_s: "
		 (number->string (throttled-configuration-ac-update-rate-s config))
		 "\n"
		 "PL1_Tdp_W: "
		 (number->string (throttled-configuration-ac-pl1-tdp-w config))
		 "\n"
		 "PL1_Duration_s: "
		 (number->string (throttled-configuration-ac-pl1-duration-s config))
		 "\n"
		 "PL2_Tdp_W: "
		 (number->string (throttled-configuration-ac-pl2-tdp-w config))
		 "\n"
		 "PL2_Duration_S: "
		 (number->string (throttled-configuration-ac-pl2-duration-s config))
		 "\n"
		 "Trip_Temp_C: "
		 (number->string (throttled-configuration-ac-trip-temp-c config))
		 "\n"
		 "cTDP: 0\nDisable_BDPROCHOT: False\n\n"
		 "[UNDERVOLT.BATTERY]\nCORE: 0\nGPU: 0\nCACHE: 0\nUNCORE: 0\nANALOGIO: 0\n\n"
		 "[UNDERVOLT.AC]\nCORE: 0\nGPU: 0\nCACHE: 0\nUNCORE: 0\nANALOGIO: 0\n\n"))

(define (throttled-shepherd-service config)

  (define throttled-command
    #~(list (string-append #$(throttled-configuration-throttled config) "/bin/throttled")))

  (list
   (shepherd-service
    (documentation "Run THROTTLED script.")
    (provision '(throttled))
    (requirement '(user-processes))
    (start #~(make-forkexec-constructor #$throttled-command))
    (stop #~(make-kill-destructor)))))

(define (throttled-activation config)
  (let* ((config-str (generate-throttled-config config))
	 (config-file (plain-file "throttled" config-str)))
    (with-imported-modules '((guix build utils))
      #~(begin
	  (use-modules (guix build utils))
	  (copy-file #$config-file "/etc/throttled.conf")))))

(define throttled-service-type
  (service-type
   (name 'throttled)
   (extensions
    (list
     (service-extension shepherd-root-service-type
			throttled-shepherd-service)
     (service-extension activation-service-type
			throttled-activation)))
   (default-value (throttled-configuration))
   (description "Run THROTTLED, a power management tool.")))
