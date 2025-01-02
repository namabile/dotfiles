;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq +doom-dashboard-pwd-policy "~")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq confirm-kill-emacs nil)

(setq select-enable-clipboard nil)
(global-set-key (kbd "C-c y") 'clipboard-yank)
(define-key evil-insert-state-map (kbd "C-p") 'clipboard-yank)

(global-set-key (kbd "M-o") 'ace-window)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)

(define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)
(define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
(define-key evil-insert-state-map (kbd "C-n") 'next-line)
(define-key evil-insert-state-map (kbd "C-p") 'previous-line)
(define-key evil-insert-state-map (kbd "C-x") 'delete-char)

(with-eval-after-load 'evil-maps
  (evil-global-set-key 'normal (kbd "C-<tab>") '+workspace/cycle)
  (evil-global-set-key 'normal (kbd "C-w") 'kill-buffer)
  (evil-global-set-key 'normal (kbd "S-RET") '+evil/insert-new-line-below)
  (evil-global-set-key 'normal (kbd "<leader>-d") 'kill-buffer))

(after! treemacs
  (evil-global-set-key 'treemacs (kbd "C-<tab>") '+workspace/cycle))

;; set default size of frame
(setq defaultkframe-alist '((left . 0) (width . 0) (fullscreen . maximized)))

(setq user-full-name "Nick Amabile"
      user-mail-address "nick.amabile@shopify.com")

(setq auth-sources '("~/.authinfo" "~/.authinfo.gpg"))

(setq doom-font (font-spec :size 20 ))

(use-package forge
  :after magit)

(use-package centaur-tabs
  :init
  (setq centaur-tabs-enable-key-bindings t)
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-icons t
        centaur-tabs-show-new-tab-button t
        centaur-tabs-set-modified-marker t
        centaur-tabs-set-bar 'left
        centaur-tabs-show-count nil)
  (centaur-tabs-headline-match)
  (centaur-tabs-mode t)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer name start with * will group to \"Emacs\".
Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
           (memq major-mode '(magit-process-mode
                              magit-status-mode
                              magit-diff-mode
                              magit-log-mode
                              magit-file-mode
                              magit-blob-mode
                              magit-blame-mode
                              )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
                          help-mode))
       "Help")
      ((memq major-mode '(org-mode
                          org-agenda-clockreport-mode
                          org-src-mode
                          org-agenda-mode
                          org-beamer-mode
                          org-indent-mode
                          org-bullets-mode
                          org-cdlatex-mode
                          org-agenda-log-mode
                          diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  :hook
  (dashboard-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (calendar-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  :bind
  (("s-{" . centaur-tabs-backward)
   ("s-}" . centaur-tabs-forward)
   ("s-<" . centaur-tabs-move-current-tab-to-left)
   ("s->" . centaur-tabs-move-current-tab-to-right))
  (:map evil-normal-state-map
        ("g t" . centaur-tabs-forward)
        ("g T" . centaur-tabs-backward)))


(use-package! treemacs
  :config
  ;; alters file icons to be more vscode-esque (better 😼)
  ;; https://github.com/doomemacs/themes/wiki/Extension:-Treemacs
  (setq doom-themes-treemacs-theme "doom-colors")
  (setq treemacs-follow-mode t)
  (setq treemacs-project-follow-into-home nil)
  (setq treemacs-max-git-entries 5000)
  (setq treemacs-missing-project-action 'ask)
  (setq treemacs-is-never-other-window nil)
  (setq treemacs-peek-mode t)
  (setq treemacs-display-in-side-window t)
  (setq treemacs-recenter-after-project-jump 'always)
  (setq treemacs-find-workspace-method 'always-ask))

(use-package treemacs-persp
  :after (treemacs persp)
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(after! persp-mode
  (setq +workspaces-on-switch-project-behavior nil))

(use-package projectile
  :config
  (setq projectile-project-search-path '("~/org "("~/src/github.com/Shopify" . 1)))
  (projectile-mode +1)
  )

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(setq treemacs-width 50)
(treemacs-resize-icons 44)
(treemacs-git-mode 'deferred)

(after! org
  (setq org-todo-keywords
        '((sequence "TODO" "INPROGRESS" "BLOCKED" "WAITING" "LATER" "|" "DONE" "CANCELED")))
  (setq org-log-done t)
  (setq org-log-into-drawer t))

(setq org-agenda-files '("~/org" "~/org/daily"))
(setq org-archive-location (concat "~/archive/" (format-time-string "%Y-%m") ".org::* From %s"))
(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/DONE" 'file))

(setq python-shell-interpreter "python3")

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-database-connector 'sqlite-builtin)
  :custom
  (org-roam-directory (file-truename "~/org/"))
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain (file "~/org/templates/default.org")
      :target
      (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("b" "book notes" plain (file "~/org/templates/book-notes.org")
      :target (file+head "%<%Y%m%d%H%M%S>-book-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("p" "people" plain (file "~/org/templates/people.org")
      :target (file+head "%<%Y%m%d%H%M%S>-people-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("g" "GSD projects" plain (file "~/org/templates/projects.org")
      :target (file+head "%<%Y%m%d%H%M%S>-projects-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("m" "meetings" plain (file "~/org/templates/meetings.org")
      :target (file+head "%<%Y%m%d%H%M%S>-meetings-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)
     ("l" "long-form document" plain "%?"
      :target (file+head "docs/%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n"))))
  (org-roam-db-autosync-mode)
  ;; Ensure the keymap is available
  (require 'org-roam-dailies)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package! org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))


(use-package vertico-posframe :ensure t :after vertico)
(vertico-posframe-mode 1)

(use-package elpy
  :ensure t
  :init
  (elpy-enable))


(add-hook 'elpy-mode-hook (lambda () (flycheck-mode t)))
(setq flycheck-python-mypy-executable "mypy")
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

(use-package shadowenv
  :ensure t
  :hook (after-init . shadowenv-global-mode))

(use-package sqlformat
  :config
  (setq sqlformat-command 'sqlfluff)
  :hook
  ('sql-mode-hook 'sqlformat-on-save-mode)
  )

;; (use-package emacs-slack
;;   :bind (("C-c S K" . slack-stop)
;;          ("C-c S c" . slack-select-rooms)
;;          ("C-c S u" . slack-select-unread-rooms)
;;          ("C-c S U" . slack-user-select)
;;          ("C-c S s" . slack-search-from-messages)
;;          ("C-c S J" . slack-jump-to-browser)
;;          ("C-c S j" . slack-jump-to-app)
;;          ("C-c S e" . slack-insert-emoji)
;;          ("C-c S E" . slack-message-edit)
;;          ("C-c S r" . slack-message-add-reaction)
;;          ("C-c S t" . slack-thread-show-or-create)
;;          ("C-c S g" . slack-message-redisplay)
;;          ("C-c S G" . slack-conversations-list-update-quick)
;;          ("C-c S q" . slack-quote-and-reply)
;;          ("C-c S Q" . slack-quote-and-reply-with-link)
;;          (:map slack-mode-map
;;                (("@" . slack-message-embed-mention)
;;                 ("#" . slack-message-embed-channel)))
;;          (:map slack-thread-message-buffer-mode-map
;;                (("C-c '" . slack-message-write-another-buffer)
;;                 ("@" . slack-message-embed-mention)
;;                 ("#" . slack-message-embed-channel)))
;;          (:map slack-message-buffer-mode-map
;;                (("C-c '" . slack-message-write-another-buffer)))
;;          (:map slack-message-compose-buffer-mode-map
;;                (("C-c '" . slack-message-send-from-buffer)))
;;          )
;;   :init
;;   (slack-register-team
;;    :name "shopify"
;;    :token (auth-source-pick-first-password
;;            :host "shopify.slack.com"
;;            :user "nick.amabile@shopify.com")
;;    :cookie (auth-source-pick-first-password
;;             :host "shopify.slack.com"
;;             :user "nick.amabile@shopify.com^cookie")
;;    :full-and-display-names t
;;    :default t
;;    :subscribed-channels '((corp-data-talk data-eng-community data-community)) ;; using slack-extra-subscribed-channels because I can change it dynamically
;;    ))


(use-package alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifier)
  )

(use-package emojify
  :init (global-emojify-mode))

(with-eval-after-load "persp-mode-autoloads"
  (add-hook 'after-init-hook #'(lambda () (persp-mode 1))))

(require 'zoom-window)
(custom-set-variables
 '(zoom-window-use-persp t))
(zoom-window-setup)

(global-set-key (kbd "C-x C-z") 'zoom-window-zoom)
