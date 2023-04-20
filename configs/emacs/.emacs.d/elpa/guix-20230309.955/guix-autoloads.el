;;; guix-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "guix-about" "guix-about.el" (0 0 0 0))
;;; Generated autoloads from guix-about.el

(autoload 'guix-version "guix-about" "\
Display Emacs-Guix and Guix versions in the echo area." t nil)

(autoload 'guix-about "guix-about" "\
Display 'About' buffer with fancy Guix logo if available.
Switch to `guix-about-buffer-name' buffer if it already exists." t nil)

(register-definition-prefixes "guix-about" '("guix-"))

;;;***

;;;### (autoloads nil "guix-auto-mode" "guix-auto-mode.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from guix-auto-mode.el

(defvar guix-store-directory "/gnu/store" "\
Name of the Guix store directory.
See Info node `(guix) The Store'.

This string is used in various regular expressions and it
shouldn't end with a trailing slash.")

(defvar guix-hash-regexp (rx (= 32 (any "0-9" "a-d" "f-n" "p-s" "v-z"))) "\
Regexp matching hash part of a store file name.")

(unless (rassq 'guix-build-log-mode auto-mode-alist) (let ((chars-rx (rx (+ (any alnum "-_+."))))) (setq auto-mode-alist (append `((,(rx-to-string `(and "/guix/drvs/" (= 2 alnum) "/" (= 30 alnum) "-" (regexp ,chars-rx) ".drv" string-end) t) . guix-build-log-mode) (,(rx-to-string `(and ,guix-store-directory "/" (regexp ,chars-rx) ".drv" string-end) t) . guix-derivation-mode) (,(rx-to-string `(and "/etc/profile" string-end) t) . guix-env-var-mode) (,(rx-to-string `(and "/tmp/guix-build-" (regexp ,chars-rx) ".drv-" (one-or-more digit) "/environment-variables" string-end) t) . guix-env-var-mode) (,(rx-to-string `(and "/guix/profiles/system" (* (regexp ,chars-rx)) "/" (or "boot" "parameters") string-end) t) . guix-scheme-mode) (,(rx-to-string `(and ,guix-store-directory "/" (regexp ,guix-hash-regexp) "-" (or "activate" "activate-service" "boot" "parameters" "shepherd.conf" (and "shepherd" (regexp ,chars-rx) ".scm") (and (regexp ,chars-rx) "-builder")) string-end) t) . guix-scheme-mode)) auto-mode-alist))))

;;;***

;;;### (autoloads nil "guix-build-log" "guix-build-log.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from guix-build-log.el

(autoload 'guix-build-log-mode "guix-build-log" "\
Major mode for viewing Guix build logs.

\\{guix-build-log-mode-map}

\(fn)" t nil)

(autoload 'guix-build-log-minor-mode "guix-build-log" "\
Toggle Guix Build Log minor mode.

With a prefix argument ARG, enable Guix Build Log minor mode if
ARG is positive, and disable it otherwise.  If called from Lisp,
enable the mode if ARG is omitted or nil.

When Guix Build Log minor mode is enabled, it highlights build
log in the current buffer.  This mode can be enabled
programmatically using hooks, like this:

  (add-hook 'shell-mode-hook 'guix-build-log-minor-mode)

\\{guix-build-log-minor-mode-map}

\(fn &optional ARG)" t nil)

(register-definition-prefixes "guix-build-log" '("guix-build-log-"))

;;;***

;;;### (autoloads nil "guix-command" "guix-command.el" (0 0 0 0))
;;; Generated autoloads from guix-command.el
 (autoload 'guix-command "guix-command" "Popup window for 'guix' shell commands." t)

(register-definition-prefixes "guix-command" '("guix-"))

;;;***

;;;### (autoloads nil "guix-config" "guix-config.el" (0 0 0 0))
;;; Generated autoloads from guix-config.el

(register-definition-prefixes "guix-config" '("guix-"))

;;;***

;;;### (autoloads nil "guix-default-config" "guix-default-config.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from guix-default-config.el

(register-definition-prefixes "guix-default-config" '("guix-config-"))

;;;***

;;;### (autoloads nil "guix-derivation" "guix-derivation.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from guix-derivation.el

(autoload 'guix-derivation-mode "guix-derivation" "\
Major mode for viewing Guix derivations.

\\{guix-derivation-mode-map}

\(fn)" t nil)

(register-definition-prefixes "guix-derivation" '("guix-derivation-"))

;;;***

;;;### (autoloads nil "guix-devel" "guix-devel.el" (0 0 0 0))
;;; Generated autoloads from guix-devel.el

(autoload 'guix-devel-code-block-edit "guix-devel" "\
Edit the current synopsis/description in `texinfo-mode'." t nil)

(autoload 'guix-devel-mode "guix-devel" "\
Minor mode for `scheme-mode' buffers.

With a prefix argument ARG, enable the mode if ARG is positive,
and disable it otherwise.  If called from Lisp, enable the mode
if ARG is omitted or nil.

When Guix Devel mode is enabled, it highlights various Guix
keywords.  This mode can be enabled programmatically using hooks,
like this:

  (add-hook 'scheme-mode-hook 'guix-devel-mode)

\\{guix-devel-mode-map}

\(fn &optional ARG)" t nil)

(register-definition-prefixes "guix-devel" '("guix-devel-"))

;;;***

;;;### (autoloads nil "guix-env-var" "guix-env-var.el" (0 0 0 0))
;;; Generated autoloads from guix-env-var.el

(autoload 'guix-env-var-prettify-variable "guix-env-var" "\
Prettify shell environment variable at current line." t nil)

(autoload 'guix-env-var-prettify-buffer "guix-env-var" "\
Prettify BUFFER with `guix-env-var-prettify-variable'.
Interactively, or if BUFFER is not specified, use the current buffer.

\(fn &optional BUFFER)" t nil)

(autoload 'guix-env-var-mode "guix-env-var" "\
Major mode for viewing Guix environment-variables and profile files.

\\{guix-env-var-mode-map}

\(fn)" t nil)

(register-definition-prefixes "guix-env-var" '("guix-env-var-"))

;;;***

;;;### (autoloads nil "guix-external" "guix-external.el" (0 0 0 0))
;;; Generated autoloads from guix-external.el

(register-definition-prefixes "guix-external" '("guix-"))

;;;***

;;;### (autoloads nil "guix-geiser" "guix-geiser.el" (0 0 0 0))
;;; Generated autoloads from guix-geiser.el

(register-definition-prefixes "guix-geiser" '("guix-geiser-"))

;;;***

;;;### (autoloads nil "guix-graph" "guix-graph.el" (0 0 0 0))
;;; Generated autoloads from guix-graph.el

(autoload 'guix-package-graph "guix-graph" "\
Show BACKEND/NODE-TYPE graph for a PACKAGE.
PACKAGE can be either a package name or a package ID.
Interactively, prompt for arguments.

\(fn PACKAGE BACKEND NODE-TYPE)" t nil)

(register-definition-prefixes "guix-graph" '("guix-"))

;;;***

;;;### (autoloads nil "guix-guile" "guix-guile.el" (0 0 0 0))
;;; Generated autoloads from guix-guile.el

(register-definition-prefixes "guix-guile" '("guix-"))

;;;***

;;;### (autoloads nil "guix-hash" "guix-hash.el" (0 0 0 0))
;;; Generated autoloads from guix-hash.el

(autoload 'guix-hash "guix-hash" "\
Calculate and copy (put into `kill-ring') the hash of FILE.

If FILE is a directory, calculate its hash recursively excluding
version-controlled files.

Interactively, prompt for FILE (see also `guix-support-dired').
With prefix argument, prompt for FORMAT as well.

See also Info node `(guix) Invoking guix hash'.

\(fn FILE &optional FORMAT)" t nil)

;;;***

;;;### (autoloads nil "guix-help" "guix-help.el" (0 0 0 0))
;;; Generated autoloads from guix-help.el

(autoload 'guix-info "guix-help" "\
Show Emacs-Guix info manual.
If ARG is non-nil (interactively with prefix), show Guix info manual.

\(fn &optional ARG)" t nil)

(autoload 'guix-help "guix-help" "\
Display a summary of the available Emacs-Guix commands.
Switch to `guix-help-buffer-name' buffer if it already exists." t nil)

(autoload 'guix-switch-to-buffer "guix-help" "\
Switch to BUFFER.
Interactively, prompt for BUFFER completing only Guix buffer names.
Guix buffers are defined using `guix-define-buffer-function'.

\(fn BUFFER)" t nil)

(autoload 'guix-extended-command "guix-help" "\
Run Emacs-Guix COMMAND.
This is like '\\[execute-extended-command]' but only global Guix
commands are completed (commands displayed with '\\[guix-help]').

\(fn COMMAND)" t nil)

(register-definition-prefixes "guix-help" '("guix-"))

;;;***

;;;### (autoloads nil "guix-help-vars" "guix-help-vars.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from guix-help-vars.el

(register-definition-prefixes "guix-help-vars" '("guix-"))

;;;***

;;;### (autoloads nil "guix-license" "guix-license.el" (0 0 0 0))
;;; Generated autoloads from guix-license.el

(autoload 'guix-find-license-location-file "guix-license" "\
Open FILE with license definitions.
See `guix-license-file' for the meaning of DIRECTORY.
Interactively, with prefix argument, prompt for DIRECTORY.

\(fn &optional DIRECTORY)" t nil)

(autoload 'guix-find-license-definition "guix-license" "\
Open licenses file from DIRECTORY and move to the LICENSE definition.
See `guix-license-file' for the meaning of DIRECTORY.
Interactively, with prefix argument, prompt for DIRECTORY.

\(fn LICENSE &optional DIRECTORY)" t nil)

(autoload 'guix-browse-license-url "guix-license" "\
Browse URL of a LICENSE.

\(fn LICENSE)" t nil)

(register-definition-prefixes "guix-license" '("guix-l"))

;;;***

;;;### (autoloads nil "guix-location" "guix-location.el" (0 0 0 0))
;;; Generated autoloads from guix-location.el

(register-definition-prefixes "guix-location" '("guix-"))

;;;***

;;;### (autoloads nil "guix-misc" "guix-misc.el" (0 0 0 0))
;;; Generated autoloads from guix-misc.el

(autoload 'guix-apply-manifest "guix-misc" "\
Apply manifest from FILE to PROFILE.
This function has the same meaning as 'guix package --manifest' command.
See Info node `(guix) Invoking guix package' for details.

Interactively, use the current profile and prompt for manifest
FILE.  With a prefix argument, also prompt for PROFILE.

\(fn PROFILE FILE &optional OPERATION-BUFFER)" t nil)

(autoload 'guix-set-emacs-environment "guix-misc" "\
Set Emacs environment to match PROFILE.
PROFILE can be a named profile (like '~/.guix-profile',
'~/.config/guix/work') or a direct link to profile from the
store, like GUIX_ENVIRONMENT variable (see Info node `(guix)
Invoking guix environment' for details).

If PROFILE is nil, use `guix-current-profile'.

\(fn &optional PROFILE)" t nil)

(autoload 'guix-pull "guix-misc" "\
Run Guix pull operation.
If VERBOSE is non-nil (with prefix argument), produce verbose output.

\(fn &optional VERBOSE)" t nil)

(autoload 'guix-report-bug "guix-misc" "\
Report GNU Guix bug.
Prompt for bug subject and open a mail buffer.

\(fn SUBJECT)" t nil)

(register-definition-prefixes "guix-misc" '("guix-"))

;;;***

;;;### (autoloads nil "guix-package" "guix-package.el" (0 0 0 0))
;;; Generated autoloads from guix-package.el

(autoload 'guix-package-size "guix-package" "\
Show size of PACKAGE-OR-FILE.
PACKAGE-OR-FILE should be either a package name or a store file name.
TYPE should be on of the following symbols: `text' (default) or `image'.
Interactively, prompt for a package name and size TYPE.

\(fn PACKAGE-OR-FILE &optional TYPE)" t nil)

(autoload 'guix-package-lint "guix-package" "\
Lint PACKAGES using CHECKERS.
PACKAGES is a list of package names.
CHECKERS is a list of checker names; if nil, use all checkers.

Interactively, prompt for PACKAGES and use all checkers.
With prefix argument, also prompt for checkers (should be comma
separated).

See Info node `(guix) Invoking guix lint' for details about linting.

\(fn PACKAGES &optional CHECKERS)" t nil)

(defalias 'guix-lint 'guix-package-lint)

(autoload 'guix-find-package-location-file "guix-package" "\
Open package location FILE.
See `guix-find-location' for the meaning of DIRECTORY.

Interactively, prompt for the location FILE.  With prefix
argument, prompt for DIRECTORY as well.

\(fn FILE &optional DIRECTORY)" t nil)

(autoload 'guix-find-package-definition "guix-package" "\
Go to the location of package with ID-OR-NAME.
See `guix-find-location' for the meaning of package location and
DIRECTORY.
Interactively, with prefix argument, prompt for DIRECTORY.

\(fn ID-OR-NAME &optional DIRECTORY)" t nil)

(defalias 'guix-edit 'guix-find-package-definition)

(register-definition-prefixes "guix-package" '("guix-"))

;;;***

;;;### (autoloads nil "guix-pcomplete" "guix-pcomplete.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from guix-pcomplete.el

(autoload 'pcomplete/guix "guix-pcomplete" "\
Completion for `guix'." nil nil)

(register-definition-prefixes "guix-pcomplete" '("guix-pcomplete-"))

;;;***

;;;### (autoloads nil "guix-popup" "guix-popup.el" (0 0 0 0))
;;; Generated autoloads from guix-popup.el
 (autoload 'guix-popup "guix-popup" nil t)

(defalias 'guix #'guix-popup "\
Popup interface for Emacs-Guix commands.")

(register-definition-prefixes "guix-popup" '("guix-p"))

;;;***

;;;### (autoloads nil "guix-prettify" "guix-prettify.el" (0 0 0 0))
;;; Generated autoloads from guix-prettify.el

(autoload 'guix-prettify-mode "guix-prettify" "\
Toggle Guix Prettify mode.

With a prefix argument ARG, enable Guix Prettify mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil.

When Guix Prettify mode is enabled, hash parts of the Guix store
file names (see `guix-prettify-regexp') are displayed as
`guix-prettify-char' character, i.e.:

  /gnu/store/…-foo-0.1  instead of:
  /gnu/store/72f54nfp6g1hz873w8z3gfcah0h4nl9p-foo-0.1

This mode can be enabled programmatically using hooks:

  (add-hook 'shell-mode-hook 'guix-prettify-mode)

It is possible to enable the mode in any buffer, however not any
buffer's highlighting may survive after adding new elements to
`font-lock-keywords' (see `guix-prettify-special-modes' for
details).

Also you can use `global-guix-prettify-mode' to enable Guix
Prettify mode for all modes that support font-locking.

\(fn &optional ARG)" t nil)

(put 'global-guix-prettify-mode 'globalized-minor-mode t)

(defvar global-guix-prettify-mode nil "\
Non-nil if Global Guix-Prettify mode is enabled.
See the `global-guix-prettify-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-guix-prettify-mode'.")

(custom-autoload 'global-guix-prettify-mode "guix-prettify" nil)

(autoload 'global-guix-prettify-mode "guix-prettify" "\
Toggle Guix-Prettify mode in all buffers.
With prefix ARG, enable Global Guix-Prettify mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Guix-Prettify mode is enabled in all buffers where
`guix-prettify-turn-on' would do it.

See `guix-prettify-mode' for more information on Guix-Prettify mode.

\(fn &optional ARG)" t nil)

(defalias 'guix-prettify-global-mode 'global-guix-prettify-mode)

(register-definition-prefixes "guix-prettify" '("guix-prettify-"))

;;;***

;;;### (autoloads nil "guix-profiles" "guix-profiles.el" (0 0 0 0))
;;; Generated autoloads from guix-profiles.el

(autoload 'guix-set-current-profile "guix-profiles" "\
Set `guix-current-profile' to FILE-NAME.
Interactively, prompt for FILE-NAME.  With prefix, use
`guix-user-profile'.

\(fn FILE-NAME)" t nil)

(register-definition-prefixes "guix-profiles" '("guix-"))

;;;***

;;;### (autoloads nil "guix-read" "guix-read.el" (0 0 0 0))
;;; Generated autoloads from guix-read.el

(register-definition-prefixes "guix-read" '("guix-"))

;;;***

;;;### (autoloads nil "guix-repl" "guix-repl.el" (0 0 0 0))
;;; Generated autoloads from guix-repl.el

(register-definition-prefixes "guix-repl" '("guix-"))

;;;***

;;;### (autoloads nil "guix-scheme" "guix-scheme.el" (0 0 0 0))
;;; Generated autoloads from guix-scheme.el

(autoload 'guix-scheme-mode "guix-scheme" "\
Major mode for editing Scheme code.
This mode is the same as `scheme-mode', except it also reindents
the current buffer after it is enabled.

\(fn)" t nil)

(register-definition-prefixes "guix-scheme" '("guix-scheme-display-message"))

;;;***

;;;### (autoloads nil "guix-service" "guix-service.el" (0 0 0 0))
;;; Generated autoloads from guix-service.el

(autoload 'guix-find-service-location-file "guix-service" "\
Open service location FILE.
See `guix-find-location' for the meaning of DIRECTORY.

Interactively, prompt for the location FILE.  With prefix
argument, prompt for DIRECTORY as well.

\(fn FILE &optional DIRECTORY)" t nil)

(autoload 'guix-find-service-definition "guix-service" "\
Go to the location of service with ID-OR-NAME.
See `guix-find-location' for the meaning of location and
DIRECTORY.
Interactively, with prefix argument, prompt for DIRECTORY.

\(fn ID-OR-NAME &optional DIRECTORY)" t nil)

(register-definition-prefixes "guix-service" '("guix-service-location"))

;;;***

;;;### (autoloads nil "guix-ui" "guix-ui.el" (0 0 0 0))
;;; Generated autoloads from guix-ui.el

(register-definition-prefixes "guix-ui" '("guix-ui-"))

;;;***

;;;### (autoloads nil "guix-ui-generation" "guix-ui-generation.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from guix-ui-generation.el

(autoload 'guix-generations "guix-ui-generation" "\
Display information about all generations.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn &optional PROFILE)" t nil)

(autoload 'guix-last-generations "guix-ui-generation" "\
Display information about last NUMBER generations.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn NUMBER &optional PROFILE)" t nil)

(autoload 'guix-generations-by-time "guix-ui-generation" "\
Display information about generations created between FROM and TO.
FROM and TO should be time values.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn FROM TO &optional PROFILE)" t nil)

(register-definition-prefixes "guix-ui-generation" '("guix-"))

;;;***

;;;### (autoloads nil "guix-ui-license" "guix-ui-license.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from guix-ui-license.el

(autoload 'guix-licenses "guix-ui-license" "\
Display licenses of the Guix packages.
Switch to the `guix-license-list-buffer-name' buffer if it
already exists." t nil)

(register-definition-prefixes "guix-ui-license" '("guix-license"))

;;;***

;;;### (autoloads nil "guix-ui-lint-checker" "guix-ui-lint-checker.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from guix-ui-lint-checker.el

(autoload 'guix-lint-checkers "guix-ui-lint-checker" "\
Display lint checkers of the Guix packages.
TYPE should be one of the following symbols: `all', `local', `network'.
Interactively, with prefix argument, prompt for TYPE.

\(fn &optional TYPE)" t nil)

(register-definition-prefixes "guix-ui-lint-checker" '("guix-lint-checker-"))

;;;***

;;;### (autoloads nil "guix-ui-messages" "guix-ui-messages.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from guix-ui-messages.el

(register-definition-prefixes "guix-ui-messages" '("guix-"))

;;;***

;;;### (autoloads nil "guix-ui-package" "guix-ui-package.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from guix-ui-package.el

(autoload 'guix-packages-by-name "guix-ui-package" "\
Display Guix packages with NAME.
NAME is a string with name specification.  It may optionally contain
a version number.  Examples: \"guile\", \"guile@2.0.11\".

If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn NAME &optional PROFILE)" t nil)

(autoload 'guix-packages-by-regexp "guix-ui-package" "\
Search for Guix packages by REGEXP.
PARAMS are package parameters that should be searched.
If PARAMS are not specified, use `guix-package-search-params'.

If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn REGEXP &optional PARAMS PROFILE)" t nil)

(define-obsolete-function-alias 'guix-search-by-regexp 'guix-packages-by-regexp "0.5.3")

(autoload 'guix-packages-by-name-regexp "guix-ui-package" "\
Search for Guix packages matching REGEXP in a package name.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn REGEXP &optional PROFILE)" t nil)

(define-obsolete-function-alias 'guix-search-by-name 'guix-packages-by-name-regexp "0.5.3")

(autoload 'guix-packages-by-license "guix-ui-package" "\
Display Guix packages with LICENSE.
LICENSE is a license name string.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn LICENSE &optional PROFILE)" t nil)

(autoload 'guix-packages-by-location "guix-ui-package" "\
Display Guix packages placed in LOCATION file.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn LOCATION &optional PROFILE)" t nil)

(autoload 'guix-package-from-file "guix-ui-package" "\
Display Guix package that the code from FILE evaluates to.
If PROFILE is nil, use `guix-current-profile'.
Interactively prompt for FILE (see also `guix-support-dired').
With prefix argument, prompt for PROFILE as well.

\(fn FILE &optional PROFILE)" t nil)

(autoload 'guix-packages-from-system-config-file "guix-ui-package" "\
Display Guix packages from the operating system configuration FILE.

Make sure FILE has a proper 'operating-system' declaration.  You
may check it, for example, by running the following shell command:

  guix system build --dry-run FILE

See also Info node `(guix) System Configuration'.

If PROFILE is nil, use system profile (it is used to show what
packages from FILE are installed in PROFILE).

Interactively, prompt for FILE (see also `guix-support-dired').
With prefix argument, prompt for PROFILE as well.

Note: This command displays only those packages that are placed
in 'packages' field of the 'operating-system' declaration.  An
installed system also contains packages installed by
services (like 'guix' or 'shepherd').  To see all the packages
installed in a system profile, use
'\\[guix-installed-system-packages]' command.

\(fn FILE &optional PROFILE)" t nil)

(autoload 'guix-installed-packages "guix-ui-package" "\
Display information about installed Guix packages.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn &optional PROFILE)" t nil)

(autoload 'guix-installed-user-packages "guix-ui-package" "\
Display information about Guix packages installed in a user profile." t nil)

(autoload 'guix-installed-system-packages "guix-ui-package" "\
Display information about Guix packages installed in a system profile." t nil)

(autoload 'guix-obsolete-packages "guix-ui-package" "\
Display information about obsolete (or unknown) Guix packages.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn &optional PROFILE)" t nil)

(autoload 'guix-superseded-packages "guix-ui-package" "\
Display information about superseded Guix packages.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn &optional PROFILE)" t nil)

(autoload 'guix-dependent-packages "guix-ui-package" "\
Display Guix packages that depend on PACKAGES.
This is similar to 'guix refresh --list-dependent PACKAGES ...'.
See Info node `(guix) Invoking guix refresh' for details.

TYPE should be a symbol `all' or `direct'.  Interactively, prompt
for it.

If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn PACKAGES &optional TYPE PROFILE)" t nil)

(autoload 'guix-hidden-packages "guix-ui-package" "\
Display hidden Guix packages.
If PROFILE is nil, use `guix-current-profile'.

\(fn &optional PROFILE)" t nil)

(autoload 'guix-all-packages "guix-ui-package" "\
Display all available Guix packages.
If PROFILE is nil, use `guix-current-profile'.
Interactively with prefix, prompt for PROFILE.

\(fn &optional PROFILE)" t nil)

(define-obsolete-function-alias 'guix-newest-packages 'guix-all-packages "0.5.2")

(autoload 'guix-number-of-packages "guix-ui-package" "\
Display the number of available Guix packages.
This number includes the packages from GUIX_PACKAGE_PATH (see
Info node `(guix) Package Modules')." t nil)

(register-definition-prefixes "guix-ui-package" '("guix-"))

;;;***

;;;### (autoloads nil "guix-ui-package-location" "guix-ui-package-location.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from guix-ui-package-location.el

(autoload 'guix-package-locations "guix-ui-package-location" "\
Display locations of the Guix packages.
Switch to the `guix-package-location-list-buffer-name' buffer if
it already exists." t nil)

(define-obsolete-function-alias 'guix-locations 'guix-package-locations "0.4")

(register-definition-prefixes "guix-ui-package-location" '("guix-package-location"))

;;;***

;;;### (autoloads nil "guix-ui-profile" "guix-ui-profile.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from guix-ui-profile.el

(autoload 'guix-profiles "guix-ui-profile" "\
Display Guix profiles.
Switch to the `guix-profile-list-buffer-name' buffer if it
already exists.

Modify `guix-profiles' variable to add more profiles." t nil)

(autoload 'guix-system-profile "guix-ui-profile" "\
Display interface for `guix-system-profile'." t nil)

(autoload 'guix-home-profile "guix-ui-profile" "\
Display interface for `guix-home-profile'." t nil)

(autoload 'guix-current-profile "guix-ui-profile" "\
Display interface for `guix-current-profile'." t nil)

(register-definition-prefixes "guix-ui-profile" '("guix-"))

;;;***

;;;### (autoloads nil "guix-ui-service" "guix-ui-service.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from guix-ui-service.el

(autoload 'guix-services-from-system-config-file "guix-ui-service" "\
Display Guix services from the operating system configuration FILE.
See `guix-packages-from-system-config-file' for more details on FILE.
Interactively, prompt for FILE (see also `guix-support-dired').

\(fn FILE)" t nil)

(autoload 'guix-all-services "guix-ui-service" "\
Display all available Guix System services." t nil)

(autoload 'guix-all-home-services "guix-ui-service" "\
Display all available Guix Home services." t nil)

(autoload 'guix-default-services "guix-ui-service" "\
Display Guix services from VAR-NAME.
VAR-NAME is a name of the variable from
`guix-default-services-variables'.

\(fn VAR-NAME)" t nil)

(autoload 'guix-services-by-name "guix-ui-service" "\
Display Guix service(s) with NAME.

\(fn NAME)" t nil)

(autoload 'guix-services-by-regexp "guix-ui-service" "\
Search for Guix services by REGEXP.
PARAMS are service parameters that should be searched.
If PARAMS are not specified, use `guix-service-search-params'.

\(fn REGEXP &optional PARAMS)" t nil)

(autoload 'guix-services-by-location "guix-ui-service" "\
Display Guix services placed in LOCATION file.

\(fn LOCATION)" t nil)

(register-definition-prefixes "guix-ui-service" '("guix-"))

;;;***

;;;### (autoloads nil "guix-ui-service-location" "guix-ui-service-location.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from guix-ui-service-location.el

(autoload 'guix-service-locations "guix-ui-service-location" "\
Display locations of the Guix services.
Switch to the `guix-service-location-list-buffer-name' buffer if
it already exists." t nil)

(register-definition-prefixes "guix-ui-service-location" '("guix-service-location"))

;;;***

;;;### (autoloads nil "guix-ui-store-item" "guix-ui-store-item.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from guix-ui-store-item.el

(autoload 'guix-store-item "guix-ui-store-item" "\
Display store items with FILE-NAMES.
Interactively, prompt for a single file name.

\(fn &rest FILE-NAMES)" t nil)

(autoload 'guix-store-item-referrers "guix-ui-store-item" "\
Display referrers of the FILE-NAMES store item.
This is analogous to 'guix gc --referrers FILE-NAMES' shell
command.  See Info node `(guix) Invoking guix gc'.

\(fn &rest FILE-NAMES)" t nil)

(autoload 'guix-store-item-references "guix-ui-store-item" "\
Display references of the FILE-NAMES store item.
This is analogous to 'guix gc --references FILE-NAMES' shell
command.  See Info node `(guix) Invoking guix gc'.

\(fn &rest FILE-NAMES)" t nil)

(autoload 'guix-store-item-requisites "guix-ui-store-item" "\
Display requisites of the FILE-NAMES store item.
This is analogous to 'guix gc --requisites FILE-NAMES' shell
command.  See Info node `(guix) Invoking guix gc'.

\(fn &rest FILE-NAMES)" t nil)

(autoload 'guix-store-item-derivers "guix-ui-store-item" "\
Display derivers of the FILE-NAMES store item.
This is analogous to 'guix gc --derivers FILE-NAMES' shell
command.  See Info node `(guix) Invoking guix gc'.

\(fn &rest FILE-NAMES)" t nil)

(autoload 'guix-store-failures "guix-ui-store-item" "\
Display store items corresponding to cached build failures.
This is analogous to 'guix gc --list-failures' shell command.
See Info node `(guix) Invoking guix gc'." t nil)

(autoload 'guix-store-live-items "guix-ui-store-item" "\
Display live store items.
This is analogous to 'guix gc --list-live' shell command.
See Info node `(guix) Invoking guix gc'." t nil)

(autoload 'guix-store-dead-items "guix-ui-store-item" "\
Display dead store items.
This is analogous to 'guix gc --list-dead' shell command.
See Info node `(guix) Invoking guix gc'." t nil)

(register-definition-prefixes "guix-ui-store-item" '("guix-"))

;;;***

;;;### (autoloads nil "guix-ui-system" "guix-ui-system.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from guix-ui-system.el

(autoload 'guix-system-from-file "guix-ui-system" "\
Display info on 'operating-system' declaration from FILE.
See `guix-packages-from-system-config-file' for more details on FILE.
Interactively, prompt for FILE (see also `guix-support-dired').

\(fn FILE)" t nil)

(register-definition-prefixes "guix-ui-system" '("guix-system-"))

;;;***

;;;### (autoloads nil "guix-ui-system-generation" "guix-ui-system-generation.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from guix-ui-system-generation.el

(autoload 'guix-system-generations "guix-ui-system-generation" "\
Display information about system generations." t nil)

(autoload 'guix-last-system-generations "guix-ui-system-generation" "\
Display information about last NUMBER of system generations.

\(fn NUMBER)" t nil)

(autoload 'guix-system-generations-by-time "guix-ui-system-generation" "\
Display information about system generations created between FROM and TO.

\(fn FROM TO)" t nil)

(register-definition-prefixes "guix-ui-system-generation" '("guix-system-generation-"))

;;;***

;;;### (autoloads nil "guix-utils" "guix-utils.el" (0 0 0 0))
;;; Generated autoloads from guix-utils.el

(register-definition-prefixes "guix-utils" '("guix-"))

;;;***

;;;### (autoloads nil nil ("guix-pkg.el" "guix.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; guix-autoloads.el ends here
