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

(setq doom-font (font-spec :family "JetBrains Mono" :size 13)
      doom-theme 'doom-tomorrow-night)

(setq org-image-actual-width nil)
(setq org-agenda-files '("~/CloudStation/Notes/Stitchfix/" "~/.deft"))

(setq deft-directory "~/.deft")
(global-set-key (kbd "C-x C-g") 'deft-find-file)

;; Source: https://www.suenkler.info/docs/emacs-orgmode/
;; (add-to-list 'org-capture-templates
(setq org-capture-templates
   '("w" "Work TODO" entry (file+datetree "~/.deft/standup_2019.org")
     "* TODO %? \n:PROPERTIES:\n:CREATED: %U\n:END:")
)

(setq ns-option-modifier 'meta)

;; (exec-path-from-shell-copy-env "NPM_TOKEN")
;; (exec-path-from-shell-copy-env "GEM_HOME")
;; (exec-path-from-shell-copy-env "GEM_PATH")

(map! :leader
      :desc "Search in project"
      :n  "ps" #'projectile-ag)

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

(setq org-latex-create-formula-image-program 'imagemagick)


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

(evil-define-text-object evgeni-inner-defun (count &optional beg end type)
  (save-excursion
    (mark-defun)
    (evil-range (region-beginning) (region-end) type :expanded t)))

(define-key evil-inner-text-objects-map "m" 'evgeni-inner-defun)
(define-key evil-outer-text-objects-map "m" 'evgeni-inner-defun)

;; Use Emacs terminfo, not system terminfo
(setq system-uses-terminfo nil)
(after! evil-escape (add-to-list 'evil-escape-excluded-major-modes 'shell-mode))


(add-hook 'vterm-mode-hook
          'turn-off-evil-mode)
