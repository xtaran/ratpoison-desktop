(global-font-lock-mode 't)
(transient-mark-mode 't)
(which-function-mode 't)
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
