;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq shell-command-switch "-ic")

(setq-default display-line-numbers-type 'visual)

(remove-hook 'org-mode-hook #'doom|disable-line-numbers)

(setq rspec-use-chruby t)
(setq rspec-use-rvm nil)
(setq rspec-use-spring-when-possible nil)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
(add-hook 'rspec-before-verification-hook 'turn-off-evil-mode)
;; (add-to-list 'evil-emacs-state-modes 'inf-ruby-mode)

;; (add-hook 'projectile-rails-mode-hook 'chruby-use-corresponding)
;; (projectile-rails-global-mode)

;; (setq doom-font (font-spec :family "JetBrains Mono" :size 13)
;;       doom-theme 'doom-tomorrow-night)
(setq doom-font (font-spec :family "JetBrains Mono" :size 13)
      doom-theme 'doom-one)

(setq org-image-actual-width nil)
(setq org-agenda-files '("~/org" "~/.deft"))

(setq deft-directory "~/.deft")
(global-set-key (kbd "C-x C-g") 'deft-find-file)

(after! org-fancy-priorities
  (setq org-fancy-priorities-list '("⚑" "▲" "▼"))
)

(after! org
;;         ;; Org-Modern
;;         (setq
;;         org-hide-emphasis-markers t
;;         org-pretty-entities t
;;         org-ellipsis "…"
;;         )
;;         (add-hook 'org-mode-hook #'org-modern-mode)
;;         (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)


  ;; Source: https://www.suenkler.info/docs/emacs-orgmode/
  ;; (add-to-list 'org-capture-templates
  (setq org-capture-templates
        '(
          ("t" "Work TODO"
           entry (file+datetree "~/org/work-log.org")
           "* TODO [#B] %? \nCreated: %T\n "
           :empty-lines 0
           :tree-type week)

          ("j" "Work Journal"
           entry (file+datetree "~/org/work-log.org")
           "* %?"
           :empty-lines 0
           :tree-type week)

          ("m" "Meeting"
           entry (file+datetree "~/org/work-log.org")
           "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
           :tree-type week
           :empty-lines 0)
          ))

  ;; https://github.com/james-stoup/emacs-org-mode-tutorial/blob/main/org-mode-config.el
  ;;
  ;; When a TODO is set to a done state, record a timestamp
  (setq org-log-done 'time)

  ;; Follow the links
  (setq org-return-follows-link  t)


  (setq org-todo-keywords
        '((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)"  "|" "DONE(d!)" "OBE(o@!)" "WONT-DO(w@/!)" )
          ))

  (setq org-todo-keyword-faces
        '(
          ("TODO" . (:foreground "GoldenRod" :weight bold))
          ("PLANNING" . (:foreground "DeepPink" :weight bold))
          ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
          ("VERIFYING" . (:foreground "DarkOrange" :weight bold))
          ("BLOCKED" . (:foreground "Red" :weight bold))
          ("DONE" . (:foreground "LimeGreen" :weight bold))
          ("OBE" . (:foreground "LimeGreen" :weight bold))
          ("WONT-DO" . (:foreground "LimeGreen" :weight bold))
          ))

  ;; Tags
  (setq org-tag-alist '(
                        ;; TODO types
                        (:startgroup . nil)
                        ("sprint" . ?s)
                        ("project" . ?p)
                        ("learn" . ?p)
                        (:endgroup . nil)
                        ;;

                        ;; Meeting types
                        (:startgroup . nil)
                        ("1on1" . ?i)
                        ("retro" . ?d)
                        ("grooming" . ?g)
                        (:endgroup . nil)

                        ;; Special tags
                        ("CRITICAL" . ?x)
                        ("obstacle" . ?o)

                        ;; Meeting tags
                        ("general" . ?l)
                        ("meeting" . ?m)
                        ("misc" . ?z)
                        ;; ("planning" . ?p)

                        ;; Work Log Tags
                        ("accomplishment" . ?a)
                        ("retro" . ?r)
                        ))


  ;; Tag colors
  (setq org-tag-faces
        '(
          ("sprint"    . (:foreground "lightSeaGreen" :weight bold))
          ("project"   . (:foreground "goldenrod2"    :weight bold))
          ("1on1"      . (:foreground "darkSeaGreen"  :weight bold))
          ("meeting"   . (:foreground "tomato1"       :weight bold))
          ("CRITICAL"  . (:foreground "red1"          :weight bold))
          )
        )


  (add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)
  (setq org-super-agenda-header-map (make-sparse-keymap))
  (setq org-agenda-custom-commands
        '(
          ("r" "Retro Topics"
           ((tags "retro"
                  ((org-agenda-overriding-header "Retro Items"))
           )))

          ;; Daily Agenda & TODOs
          ("d" "Daily agenda and all TODOs"

           ;; Display items with priority A
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))

            ;; View 7 days in the calendar view
            (agenda "" ((org-agenda-span 7)))

            ;; Display items with priority B (really it is view all items minus A & C)
            (alltodo ""
                     ((org-agenda-skip-function '(or (air-org-skip-subtree-if-priority ?A)
                                                     (air-org-skip-subtree-if-priority ?C)
                                                     (org-agenda-skip-if nil '(scheduled deadline))))
                      (org-agenda-overriding-header "ALL normal priority tasks:")))

            ;; Display items with pirority C
            (tags "PRIORITY=\"C\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "Low-priority Unfinished tasks:")))
            )

           ;; Don't compress things (change to suite your tastes)
           ((org-agenda-compact-blocks nil)))

          ;; James's Super View
          ("g" "Super View"
           (
            (agenda ""
                    (
                     (org-agenda-span 7)
                     )
                    )

            (alltodo ""
                     (
                      (org-agenda-prefix-format "  %t  %s")
                      (org-agenda-overriding-header "CURRENT STATUS")

                      ;; Define the super agenda groups (sorts by order)
                      (org-super-agenda-groups
                       '(
                         ;; Filter where tag is CRITICAL
                         (:name "Critical Tasks"
                          :tag "CRITICAL"
                          :order 0
                          )
                         ;; Filter where TODO state is IN-PROGRESS
                         (:name "Currently Working"
                          :todo "IN-PROGRESS"
                          :order 1
                          )
                         ;; Filter where TODO state is PLANNING
                         (:name "Planning Next Steps"
                          :todo "PLANNING"
                          :order 2
                          )
                         ;; Filter where TODO state is BLOCKED or where the tag is obstacle
                         (:name "Problems & Blockers"
                          :todo "BLOCKED"
                          :tag "obstacle"
                          :order 3
                          )
                         ;; Filter where tag is @write_future_ticket
                         (:name "Tickets to Create"
                          :tag "@write_future_ticket"
                          :order 4
                          )
                         ;; Filter where tag is @research
                         (:name "Research Required"
                          :tag "@research"
                          :order 7
                          )
                         ;; Filter where tag is meeting and priority is A (only want TODOs from meetings)
                         (:name "Meeting Action Items"
                          :tag "meeting"
                          :order 8
                          )
                         ;; Filter where state is TODO and the priority is A and the tag is not meeting
                         (:name "Other Important Items"
                          :and (:todo "TODO" :priority "A" :not (:tag "meeting"))
                          :order 9
                          )
                         ;; Filter where state is TODO and priority is B
                         (:name "Sprint Backlog"
                          :and (:todo "TODO" :tag "sprint")
                          :order 10
                          )
                         ;; Filter where state is TODO and tag is project
                         (:name "Project Backlog"
                          :and (:todo "TODO" :tag "project")
                          :order 11
                          )
                         ;; Filter where state is TODO and priority is B
                         (:name "General Backlog"
                          :and (:todo "TODO" :priority "B")
                          :order 12
                          )
                         ;; Filter where the priority is C or less (supports future lower priorities)
                         (:name "Non Critical"
                          :priority<= "C"
                          :order 13
                          )
                         ;; Filter where TODO state is VERIFYING
                         (:name "Currently Being Verified"
                          :todo "VERIFYING"
                          :order 20
                          )
                         )
                       )
                      )
                     )
            ))
          ))

  )


(setq ns-option-modifier 'meta)

;; (exec-path-from-shell-copy-env "NPM_TOKEN")
;; (exec-path-from-shell-copy-env "GEM_HOME")
;; (exec-path-from-shell-copy-env "GEM_PATH")

(map! :leader
      :desc "Search in project"
      :n  "ps" #'projectile-ag)

(map! :leader
      :desc "Org Agenda"
      :n "a" #'org-agenda)

(map! :leader
      :desc "Open Scratch Buffer"
      :n "X" #'doom/open-scratch-buffer)

(map! :leader
      :desc "Org Capture"
      :n "x" #'org-capture)

(set-popup-rules!
 '((".deft/standup_2019.org" :side bottom :size 0.4 :quit 'current)
   ("*doom:vterm-popup:.*" :side left :size 0.25 :slot -4 :select t :quit nil :ttl 0)
   ("^\\*rspec" :slot 0 :size 0.4 :quit 'current)))

;; set up tikz as one of the default packages for LaTeX
(setq org-latex-packages-alist
      (quote (("" "color" t)
              ("" "minted" t)
              ("" "parskip" t)
              ("" "tikz" t))))

(setq minibuffer-line-format '((:eval
                                (let ((time-string (format-time-string "%l:%M %b %d %a")))
                                  (concat
                                   (make-string (- (frame-text-cols)
                                                   (string-width time-string)) ? )
                                   time-string)))))
(minibuffer-line-mode)


(add-hook 'org-mode-hook
  (lambda ()
    (define-key org-mode-map (kbd "C-k")
      (lambda () (interactive) (org-ctrl-c-ctrl-c)
                               (org-display-inline-images)))))

(define-key evil-inner-text-objects-map "m" 'evgeni-inner-defun)
(define-key evil-outer-text-objects-map "m" 'evgeni-inner-defun)

;; Use Emacs terminfo, not system terminfo
(setq system-uses-terminfo nil)
(after! evil-escape (add-to-list 'evil-escape-excluded-major-modes 'shell-mode))


(add-hook 'vterm-mode-hook
          'turn-off-evil-mode)

(with-eval-after-load 'tramp
        (tramp-set-completion-function "ssh"
        '((tramp-parse-sconfig "~/.ssh/codespaces")
        (tramp-parse-sconfig "~/.ssh/config")))
        )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (http . t)))


(let ((ghcs (assoc "ghcs" tramp-methods))
      (ghcs-methods '((tramp-login-program "gh")
                      (tramp-login-args (("codespace") ("ssh") ("-c") ("%h")))
                      (tramp-remote-shell "/bin/sh")
                      (tramp-remote-shell-login ("-l"))
                      (tramp-remote-shell-args ("-c")))))
  ;; just for debugging the methods
  (if ghcs (setcdr ghcs ghcs-methods)
    (push (cons "ghcs" ghcs-methods) tramp-methods)))
