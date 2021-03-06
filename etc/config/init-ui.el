;;;===========================================
;;;					模块介绍
;;; 用户交互界面模块
;;;===========================================

;; MODULE: USER INTERFACE

;; AUTHOR: EvanMeek the_lty_mail@foxmail.com

;;; Code:

(setq evan/font-name "Sarasa Mono Slab SC Semibold"
	  evan/font-style "Regular"
	  evan/font-size 20)

;; 设置光标颜色
;; (set-cursor-color "green2")
;; 设置光标样式
(setq-default cursor-type 'box)
;; 去除默认启动界面
(setq inhibit-startup-message t)
;; 设置英文字体
(push '(if (fontp (font-spec
				   ;; :name "Fira Code Nerd Font"
				   ;; :style "Retina"
				   :name evan/font-name
				   :style evan/font-style
				   ;; :name "Sarasa Mono SC"
				   ;; :style "Regular"
				   :size evan/font-size))
		   (progn
			 (set-face-attribute 'default nil
								 :font (font-spec
										:name evan/font-name
										:style evan/font-style
										:size evan/font-size))
			 (set-fontset-font t ?中 (font-spec
										:name evan/font-name
										:style evan/font-style
										:size evan/font-size)))
		   
		 (message "无法找到%s字体，你可以更换其他字体或安装它让这条消息消失." evan/font-name)) graphic-only-plugins-setting)


;; 高亮当前行
(global-hl-line-mode 1)

;; 切换buffer焦点时高亮动画
(use-package beacon
  :disabled
  :ensure t
  :hook (after-init . beacon-mode))



;; 主题包									
(use-package
  doom-themes
  :ensure t)
(use-package
  spacemacs-common
  :ensure spacemacs-theme)

;; (use-package base16-theme
;;   :ensure t
;;   :defer)

(use-package modus-operandi-theme
  :defer 0
  :ensure t)
 ;; (load-file "~/.emacs.d/themes/solo-jazz-theme.el")

(use-package modus-vivendi-theme
    :defer 0
	:ensure t )


;; 自动切换主题
(use-package
  circadian
  :defer 0
  :ensure t
  :config
  ;; 经纬度，可以在https://www.latlong.net/获取，默认是广州的
  (setq calendar-latitude 23.130280
		calendar-longitude 113.288879)
  ;; sunrise 白天用的主题 sunset 晚上用的主题
  (setq circadian-themes '((:sunrise . spacemacs-light)
						   (:sunset . doom-dracula)))
  (circadian-setup)
  ;; 解决切换主题spaceline色块显示问题
  (add-hook 'circadian-after-load-theme-hook
			#'(lambda (theme)
				(spaceline-emacs-theme))))


;; 根据时间切换高亮当前行颜色
;; (if (and (> (car (circadian-now-time)) (car (circadian-sunrise)))
;; 		 (< (car (circadian-now-time)) (car (circadian-sunset))))
;; 	(set-face-background 'hl-line "light gray")
;;   (set-face-background 'hl-line "gray17"))

(push '(progn
		 ;; 图标支持
		 (use-package
		   all-the-icons
		   :defer 0
		   :ensure t)
		 ;; dired模式图标支持
		 (use-package
		   all-the-icons-dired
		   :defer 0
		   :ensure t
		   :hook ('dired-mode . 'all-the-icons-dired-mode))
		 ;; 表情符号
		 (use-package
		   emojify
		   :defer 0
		   :ensure t
		   :custom (emojify-emojis-dir "~/.emacs.d/var/emojis")
		   :hook telega-mode)
		 ;; 浮动窗口支持
		 (use-package
		   posframe
		   :defer 0
		   :ensure t
		   :custom
		   (posframe-mouse-banish nil))) graphic-only-plugins-setting)

;; 竖线
(use-package
  page-break-lines
  :ensure t
  :hook (after-init . page-break-lines-mode)
  :config (turn-on-page-break-lines-mode))

;; 启动界面
(use-package
  dashboard
  :disabled
  :ensure t
  :init
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text") 
                                    (bookmarks . "book")))
  ;; 设置标题
  (setq dashboard-banner-logo-title
        "欢迎您使用此Emacs配置文件，有任何问题可加QQ群:46689842                  ")
  ;; 设置banner
  (setq dashboard-startup-banner "~/.emacs.d/var/banner/evan-emacs-banner.png")
  (setq dashboard-center-content t) 
  (setq dashboard-set-heading-icons t) 
  ;; (setq dashboard-set-file-icons t) 
  (setq dashboard-set-navigator t))


;; modeline样式
(use-package 
  doom-modeline
  :disabled
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 10)
  (doom-modeline-bar-width 3)
  (doom-modeline-buffer-file-name-style 'file-name)
  :config
  (custom-set-faces '(mode-line ((t 
                                  (:family evan/font-name
                                           :style evan/font-style
                                           :height 125)))) 
                    '(mode-line-inactive ((t 
                                           (:family evan/font-name
                                                    :style evan/font-size
                                                    :height 125))))))

(use-package spaceline
  :defer 0
  :ensure t
  :config
  (spaceline-emacs-theme))

;; 彩虹括号
(use-package 
  rainbow-delimiters 
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode)
  :config
  ;; 设置每一级括号的颜色
  (set-face-foreground 'rainbow-delimiters-depth-1-face "chartreuse3") 
  (set-face-foreground 'rainbow-delimiters-depth-2-face "DodgerBlue1") 
  (set-face-foreground 'rainbow-delimiters-depth-3-face "DarkOrange2")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "deep pink") 
  (set-face-foreground 'rainbow-delimiters-depth-5-face "medium orchid") 
  (set-face-foreground 'rainbow-delimiters-depth-6-face "turquoise") 
  (set-face-foreground 'rainbow-delimiters-depth-7-face "lime green") 
  (set-face-foreground 'rainbow-delimiters-depth-8-face "gold") 
  (set-face-foreground 'rainbow-delimiters-depth-9-face "cyan") 
  (set-face-bold 'rainbow-delimiters-depth-1-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-2-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-3-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-4-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-5-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-6-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-7-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-8-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-9-face "t") 
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
;; 让info帮助信息中关键字有高亮
(use-package 
  info-colors 
  :ensure t 
  :hook ('Info-selection-hook . 'info-colors-fontify-node))

;; 缩进线
(use-package
  indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode))

;; 彩虹猫进度条
(use-package nyan-mode
  :defer 1
  :ensure t
  :hook (after-init . nyan-mode)
  :config
  (setq nyan-wavy-trail t
		nyan-animate-nyancat nil))

;; 对齐表格
(use-package valign
  :disabled
  :load-path "~/.emacs.d/site-lisp/valign"
  :hook ((org-mode markdown-mode) . valign-mode)
  :config
  (setq valign-fancy-bar nil))

;; 懒猫的超简洁modeline
(use-package awesome-tray
  :disabled
  :load-path "~/.emacs.d/site-lisp/awesome-tray"
  :hook (after-init . awesome-tray-mode))

;; tab-bar
(use-package tab-bar
  :defer 2
  :config
  (setq tab-bar-tab-name-truncated-max 8))


;; 为上层提供 init-ui 模块

(use-package centaur-tabs
  :init (setq centaur-tabs-enable-key-bindkings t)
  :ensure t
  :defer 0
  :config
  (centaur-tabs-mode +1)
  (centaur-tabs-headline-match)
  (centaur-tabs-enable-buffer-reordering)
  (setq centaur-tabs-height 35
		centaur-tabs-style "bar"
		centaur-tabs-set-icons t
		centaur-tabs-gray-out-icons 'buffer
		centaur-tabs-set-bar 'under
		x-underline-at-descent-line t
		;; 开启已修改标记
		centaur-tabs-set-modified-marker t
		;; 自动排序
		;; centaur-tabs-adjust-buffer-order t
		;; 默认按键设置为Nil
		centaur-tabs-prefix-map nil
		;; 是否要显示导航按钮
		centaur-tabs-show-navigation-buttons nil)
  (centaur-tabs-change-fonts evan/font-name 160)
  ;; centaur show tabs rules
  ;; Centuar-tabs 显示规则
  (defun centaur-tabs-hide-tab (x)
	"Do no to show buffer X in tabs."
	(let ((name (format "%s" x)))
      (or
       ;; Current window is not dedicated window.
       (window-dedicated-p (selected-window))

       ;; Buffer name not match below blacklist.
	   ;; 黑名单
       (string-prefix-p "*Compile-Log*" name)
       (string-prefix-p "*lsp" name)
       (string-prefix-p "*company" name)
       (string-prefix-p "*Flycheck" name)
       (string-prefix-p " *Mini" name)
       (string-prefix-p "*help" name)
       (string-prefix-p "*straight" name)
       (string-prefix-p " *temp" name)
       (string-prefix-p "*Help" name)
	   (derived-mode-p 'eaf-mode)
	   (string-prefix-p " *snails" name)
       ;; Is not magit buffer.
       (and (string-prefix-p "magit" name)
			(not (file-name-extension name))))))

  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

    Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
    All buffer name start with * will group to \"Emacs\".
    Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
	 (cond
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
	  ((or (derived-mode-p 'prog-mode)
		   (string-prefix-p "*scratch" (buffer-name))) 
	   "Programming")
	  ((derived-mode-p 'dired-mode)
	   "Dired") ''
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
	  ((or (string-prefix-p "◀[" (buffer-name))
		   (string-prefix-p "◀{" (buffer-name))) 
	   "Telega")
	  ((derived-mode-p 'vterm-mode)
	   "Vterm")
	  (t
	   (centaur-tabs-get-group-name (current-buffer))))))
  :bind
  (("C-c h" . centaur-tabs-backward-tab)
   ("C-c l" . centaur-tabs-forward-tab)
   ("C-c H" . centaur-tabs-backward-tab-other-window)
   ("C-c L" . centaur-tabs-forward-tab-other-window)
   ("C-c 0" . centaur-tabs--kill-this-buffer-dont-ask)
   ("C-c B" . centaur-tabs-counsel-switch-group)))

(provide 'init-ui)
