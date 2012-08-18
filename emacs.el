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
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(send-mail-function (quote sendmail-send-it))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tool-bar-mode nil))

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