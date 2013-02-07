(global-font-lock-mode 't)
(transient-mark-mode 't)
(which-function-mode 't)
(cua-selection-mode 't)
(winner-mode 't)
(put 'narrow-to-region 'disabled nil)
(server-start)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(focus-follows-mouse t)
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(mouse-sel-mode t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(send-mail-function (quote sendmail-send-it))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(tramp-shell-prompt-pattern "\\(?:^\\|\\)[^#$%>→
]*#?[#$%>→] *\\(\\[[0-9;]*[a-zA-Z] *\\)*"))

(setq interprogram-cut-function 'x-set-cut-buffer)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

; Markdown Mode for .md files
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (append
       (list
        '("\\.md" . markdown-mode)
        '("\\.mdwn" . markdown-mode)
        '("\\.markdown" . markdown-mode)
        '("\\.mdt" . markdown-mode))
       auto-mode-alist))

; Tell mmm-mode about Embperl
(mmm-add-group
 'embperl
 '((embperl-perl
    :submode perl
    :front "\\[\\([-\\+!\\*\\$]\\)"
    :front-offset -2
    :back "~1\\]"
    :back-offset 2
    :save-matches 1
    :match-face (("[+" . mmm-output-submode-face)
                 ("[-" . mmm-code-submode-face)
                 ("[!" . mmm-init-submode-face)
                 ("[*" . mmm-code-submode-face)
                 ("[$" . mmm-special-submode-face))
    :insert ((?p embperl "Region Type (Character): " @ "[" str
                 @ " " _ " " @ str "]" @)
             (?+ embperl+ ?p . "+")
             (?- embperl- ?p . "-")
             (?! embperl! ?p . "!")
             (?* embperl* ?p . "*")
             (?$ embperl$ ?p . "$")))
   (embperl-comment
    :submode text-mode
    :face mmm-comment-submode-face
    :front "\\[#"
    :front-offset -2
    :back "#\\]"
    :back-offset 2
    :insert ((?# embperl-comment nil @ "[#" @ " " _ " " @ "#]" @)))))

(or (assoc "\\.epl?$" auto-mode-alist)
    (setq auto-mode-alist (cons '("\\.epl?$" . html-mode)
                                auto-mode-alist)))

(mmm-add-mode-ext-class 'html-mode "\\.epl?$" 'embperl)

; Scroll left and right with the 2D mouse wheel
(setq wheel-scroll-interval 5)
(defun wheel-scroll-left-some-lines ()
  (interactive)
  (scroll-left wheel-scroll-interval))
(defun wheel-scroll-right-some-lines ()
  (interactive)
  (scroll-right wheel-scroll-interval))
(global-set-key [mouse-6] 'wheel-scroll-left-some-lines)
(global-set-key [mouse-7] 'wheel-scroll-right-some-lines)

; Occur inside isearch with easier keybinding.
; Via http://irreal.org/blog/?p=1540
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur)

; magit-status has no keybinding by default
(global-set-key (kbd "C-x g") 'magit-status)
