;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq shell-command-switch "-ic")

(setq-default display-line-numbers-type 'visual)

(remove-hook 'org-mode-hook #'doom|disable-line-numbers)

(setq rspec-use-chruby t)
(setq rspec-use-rvm nil)
(add-hook 'projectile-rails-mode-hook 'chruby-use-corresponding)
(projectile-rails-global-mode)

(setq doom-font (font-spec :family "Source Code Pro" :size 14)
      doom-theme 'doom-nova)

(setq org-plantuml-jar-path
    (expand-file-name "/usr/local/Cellar/plantuml/1.2019.0/libexec/plantuml.jar"))

(setq org-image-actual-width nil)

(setq ns-option-modifier 'meta)

(exec-path-from-shell-copy-env "NPM_TOKEN")
(exec-path-from-shell-copy-env "GEM_HOME")
(exec-path-from-shell-copy-env "GEM_PATH")


(map! :leader
      :desc "Search in project"
      :n  "ps" #'projectile-ag)

(set-popup-rule! "^\\*rspec" :side 'bottom :size 0.4 :quit 'current)

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

(define-key org-mode-map (kbd "C-k")
  (lambda () (interactive) (org-ctrl-c-ctrl-c)
                           (org-display-inline-images)))
