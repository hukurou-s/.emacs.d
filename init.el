;; init.el
;;
(require 'cl)
(require 'cask)
(cask-initialize)

;; homebrew
;;(add-to-list 'exec-path (expand-file-name "/usr/local/bin"))

;; Language.
(set-language-environment 'Japanese)

;; Coding system.
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

(require 'company)
(global-company-mode)

;(add-to-list 'load-path "~/.emacs.d/powerline/")
(require 'powerline)

(when (require 'rainbow-delimiters nil 'noerror)
  (add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))


;;-----------------------------------------------------------------------------
;;customize theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/moe-theme.el/")
(add-to-list 'load-path "~/.emacs.d/moe-theme.el/")
(require 'moe-theme)

;; Show highlighted buffer-id as decoration. (Default: nil)
(setq moe-theme-highlight-buffer-id t)

;; Resize titles (optional).
;;(setq moe-theme-resize-markdown-title '(1.5 1.4 1.3 1.2 1.0 1.0))
(setq moe-theme-resize-org-title '(1.5 1.4 1.3 1.2 1.1 1.0 1.0 1.0 1.0))
(setq moe-theme-resize-rst-title '(1.5 1.4 1.3 1.2 1.1 1.0))

;; Choose a color for mode-line.(Default: blue)
(moe-theme-set-color 'cyan)

;; Finally, apply moe-theme now.
;; Choose what you like, (moe-light) or (moe-dark)
(moe-dark)

(moe-theme-set-color 'orange)
;; (Available colors: blue, orange, green ,magenta, yellow, purple, red, cyan, w/b.)

;;(powerline-moe-theme)

;;(require 'moe-theme-switcher)   ;; 時間で変わる?

;;(setq calendar-latitude +25)    ;; タイムゾーン
;;(setq calendar-longitude +121)

(show-paren-mode t)
(setq show-paren-style 'expression)

;;--------------------------------------------------------------------------------

;; load-pathに追加するフォルダ
;; 2つ以上フォルダを指定する場合の引数 => (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "elisp")

(require 'flex-autopair)
(flex-autopair-mode 1)


;(global-flycheck-mode)
;;エラーをツールチップで表示
;;(add-hook 'after-init-hook #'global-flycheck-mode)


;(flycheck-add-next-checker 'javascript-jshint
;			   'javascript-gjslint)


;(with-eval-after-load 'flycheck
;  (flycheck-pos-tip-mode))
;(eval-after-load 'flycheck
;  '(custom-set-variables
;       '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))


;;鬼軍曹.el を読み込む
;;起動時に読み込む
;;(require 'drill-instructor)
;;(setq drill-instructor-global t)

;; 1行づつスクロールする
(setq scroll-conservatively 1)

;; オートセーブファイルを作成しない
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;; 行番号を表示する
(global-linum-mode t)

;; メニューバーを消す
(menu-bar-mode -1)

;; ツールバーを消す
(tool-bar-mode -1)

;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
            (format "%%f - Emacs@%s" (system-name)))

;; 対応する括弧をハイライトする
(show-paren-mode t)

;; 対応する括弧の色の設定
(setq show-paren-style 'mixed)
(set-face-background 'show-paren-match-face "Cyan")
(set-face-foreground 'show-paren-match-face "White")

;; 括弧を ( の後に )を入力すると一文字戻る
;(when (require 'cursor-in-brackets nil t)
;    (global-cursor-in-brackets-mode t))

;;現在行をハイライト
(require 'hl-line)
(global-hl-line-mode 1)

;;カーソルの形
(setq cursor-type 'hbar)
;(setq cursor-type 'grey)

;; c-mode のインデントをスペース4個分のタブにする
(add-hook 'c-mode-common-hook
          '(lambda ()
             (c-set-style "k&r")
             (setq c-basic-offset 4)
             (setq indent-tabs-mode nil)
             (setq tab-width 4)))

;; バックアップファイルを作成しない
(setq make-backup-files nil)

;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;; Macのoptionをメタキーにする
(setq mac-option-modifier 'meta)

;;現在のポイントがある関数名表示
(which-function-mode 1)

;;#!から始まるコードは実行権限を付与する
(add-hook 'after-save-hook
	            'executable-make-buffer-file-executable-if-script-p)

;; C-k １回で行全体を削除する
(setq kill-whole-line t)

;; C-x C-b でバッファリストを開く時に、ウィンドウを分割しない
(global-set-key "\C-x\C-b" 'buffer-menu)

;; 現在行を top にするキーバインドを C-u 0 C-l から C-x C-l
;; ちなみに C-l は現在行を center にする
(defun line-to-top-of-window ()
  "Move the line point is on to top of window."
  (interactive)
  (recenter 0))
(global-set-key "\C-x\C-l" 'line-to-top-of-window)

;; Window 分割・移動を C-t で
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
        (split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))
(global-set-key (kbd "C-t") 'other-window-or-split)


(put 'upcase-region 'disabled nil)


