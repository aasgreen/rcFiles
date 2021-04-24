;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Adam Green"
      user-mail-address "aagen@fastmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;a
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; maximize the initial screen
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; org mode configs
;;
;;enable logging of tasks
(after! org
  (setq org-log-done t)
  (setq org-log-into-drawer t))
;; mail options

(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(require 'mu4e-context)
(require 'org-mu4e)
 (setq     mu4e-maildir "~/Maildir")
  (setq mu4e-sent-folder   "/work/[Gmail]/Sent Mail"
        mu4e-drafts-folder "/work/[Gmail]/Drafts"
        mu4e-trash-folder  "/work/[Gmail]/Trash"
        mu4e-refile-folder "/work/[Gmail]/All Mail")


(defun enter-mu4e-context-tonline ()
  (setq mu4e-sent-folder   "/private/Sent"
        mu4e-drafts-folder "/private/Drafts"
        mu4e-trash-folder  "/private/Trash"
        mu4e-refile-folder "/private/Archive"))


(defun enter-mu4e-context-gmail ()
  (setq mu4e-sent-folder   "/work/[Gmail]/Sent Mail"
        mu4e-drafts-folder "/work/[Gmail]/Drafts"
        mu4e-trash-folder  "/work/[Gmail]/Trash"
        mu4e-refile-folder "/work/[Gmail]/All Mail"))

(setq mu4e-contexts
      `(,(make-mu4e-context
          :name "Private"
          :enter-func (lambda () (progn
                                   (mu4e-message "Entering Private Context")
                                   (enter-mu4e-context-tonline)
                                   ))
          :leave-func (lambda () (mu4e-message "Leave Private Context"))
          ;; We match based on the contact-fields of the message
	        :match-func (lambda (msg)
			                  (when msg
                                (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
			                    ;;(mu4e-message-contact-field-matches msg
			                    ;;  :to "aagen@fastmail.com")))
          :vars '((user-mail-address . "aagen@fastmail.com"  )
		              (user-full-name . "Adam Green" )
                  ))

        ,(make-mu4e-context
          :name "Work"
          :enter-func (lambda () (progn
                                   (mu4e-message "Entering Work Context")
                                   (enter-mu4e-context-gmail)
                                   ))
          :leave-func (lambda () (mu4e-message "Leave Work Context"))
          ;; We match based on the contact-fields of the message
	        :match-func (lambda (msg)
			                  (when msg
                                (string-prefix-p "/private" (mu4e-message-field msg :maildir))))
			                    ;; (mu4e-message-contact-field-matches msg
			                     ;; :to "aagreen@lbl.gov")))
          :vars '((user-mail-address . "aagreen@lbl.gov"  )
		              (user-full-name . "Adam Green" )
                  ))
        ))

(setq mu4e-context-policy 'always-ask
      mu4e-sent-messages-behavior 'delete
      mu4e-use-maildirs-extension t
      mu4e-enable-async-operations t
      mu4e-attachment-dir "~/Downloads"
      mu4e-confirm-quit nil
      )

      ;; Prefer text over html email
      mu4e-view-html-plaintext-ratio-heuristic  most-positive-fixnum

      ;; mu4e-compose-context-policy nil
;;(setq mu4e-maildir (expand-filename "~/Maildir"))
;;
;;
;;(setq
;; mue4e-headers-skip-duplicates  t
;; mu4e-view-show-images t
;; mu4e-view-show-addresses t
;; mu4e-compose-format-flowed nil
;; mu4e-date-format "%y/%m/%d"
;; mu4e-headers-date-format "%Y/%m/%d"
;; mu4e-change-filenames-when-moving t
;; mu4e-attachments-dir "~/Downloads"
;;)
;;
;;(setq mu4e-context-policy 'pick-first)
;;(setq mu4e-compose-context-policy 'always-ask)
;; ;;
;;
;;(setq mu4e-contexts
;;    `( ,(make-mu4e-context
;;	  :name "Private"
;;	  :enter-func (lambda () (mu4e-message "Entering Private context"))
;;          :leave-func (lambda () (mu4e-message "Leaving Private context"))
;;	  ;; we match based on the contact-fields of the message
;;	  :match-func (lambda (msg)
;;			(when msg
;;			  (string-match-p "^/private" (mu4e-message-field msg :maildir))))
;;	  :vars '( ( user-mail-address	    . "aagen@fastmail.com"  )
;;            ( mu4e-maildir . "~/Maildir/private")
;;            ( mu4e-sent-folder . "~/Maildir/private")
;;		   ( user-full-name	    . "Adam Green" )
;;		   ( mu4e-compose-signature .
;;		     (concat
;;		       "-adam"
;;		       ))))
;;       ,(make-mu4e-context
;;	  :name "Work"
;;	  :enter-func (lambda () (mu4e-message "Switch to the Work context"))
;;	  ;; no leave-func
;;	  ;; we match based on the maildir of the message
;;	  ;; this matches maildir /Arkham and its sub-directories
;;	  :match-func (lambda (msg)
;;			(when msg
;;			  (string-match-p "^/work" (mu4e-message-field msg :maildir))))
;;	  :vars '( ( user-mail-address	     . "aagreen@lbl.gov" )
;;            ( mu4e-maildir . "~/Maildir/work")
;;		   ( user-full-name	     . "Adam Green" )
;;		   ( mu4e-compose-signature  .
;;		     (concat
;;		       "-adam"
;;		       ))))
;;       )
;;    )
;;
;;    ;;,(make-mu4e-context
;;	;;  :name "Cycling"
;;	;;  :enter-func (lambda () (mu4e-message "Switch to the Cycling context"))
;;	;;  ;; no leave-func
;;	;;  ;; we match based on the maildir of the message; assume all
;;	;;  ;; cycling-related messages go into the /cycling maildir
;;	;;  :match-func (lambda (msg)
;;	;;		(when msg
;;	;;		  (string= (mu4e-message-field msg :maildir) "/cycling")))
;;	;;  :vars '( ( user-mail-address	     . "aderleth@example.com" )
;;	;;	   ( user-full-name	     . "AliceD" )
;;	;;	   ( mu4e-compose-signature  . nil)))))
;;
;;  ;; set `mu4e-context-policy` and `mu4e-compose-policy` to tweak when mu4e should
;;  ;; guess or ask the correct context, e.g.
;;
;;  ;; start with the first (default) context;
;;  ;; default is to ask-if-none (ask when there's no context yet, and none match)
;;  ;; (setq mu4e-context-policy 'pick-first)
;;
;;  ;; compose with the current context is no context matches;
;;  ;; default is to ask
;;  ;; (setq mu4e-compose-context-policy nil)
;;;; this setting allows to re-sync and re-index mail
;;;; by pressing U
(setq mu4e-get-mail-command  "mbsync -a")
