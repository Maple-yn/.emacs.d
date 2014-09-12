;----------------------
;	init.el


;	language (sakito.jp/emacs/emacs23.html)

;;; 言語を日本語にする
(set-language-environment 'Japanese)
;;; 極力UTF-8にする
(prefer-coding-system 'utf-8)


;	path

(add-to-list 'exec-path "/usr/local/bin")


;	general

;; linum-modeをenableに
(global-linum-mode t)
(setq linum-format "%3d  ")    ;;デフォルトで3桁整数＋SPC

;; tab幅を設定
(setq default-tab-width 4)

;	window

;;; 背景色変更
(set-face-background 'default "black")
(set-frame-parameter nil 'alpha '(80 65))

;;; 文字色変更
;(set-face-foreground 'default "white")

;;; 括弧のハイライト
(show-paren-mode t)

;	Terminal上のEmacsでのみの設定
;(if (not window-system)
;
;)


;	 key-bindings

;; C-hをBackspaceにキーバインド
;(keyboard-translate ?C-h ?\C-?)
(define-key global-map "\C-h" 'delete-backward-char)

;; C-c C-hをヘルプにキーバインド
(define-key global-map "\C-c\C-h" 'help-for-help)

;; C-;をanythingにキーバインド
(define-key global-map (kbd "C-;") 'anything)

;; http://d.akinori.org/2012/01/02/ターミナルのemacsでも特殊キーコンボ
;;; iterm側にHexコード送信の設定が必要。URL参照
(defun event-apply-control-shift-modifier (ignore-prompt)
  "\\Add the Control+Shift modifier to the following event.
For example, type \\[event-apply-control-shift-modifier] SPC to enter Control-Shift-SPC."
  (vector (event-apply-modifier
           (event-apply-modifier (read-event) 'shift 25 "S-")
           'control 26 "C-")))
(define-key function-key-map (kbd "C-x @ C") 'event-apply-control-shift-modifier)
(defun event-apply-meta-control-modifier (ignore-prompt)
  "\\Add the Meta-Control modifier to the following event.
For example, type \\[event-apply-meta-control-modifier] % to enter Meta-Control-%."
  (vector (event-apply-modifier
           (event-apply-modifier (read-event) 'control 26 "C-")
           'meta 27 "M-")))
(define-key function-key-map (kbd "C-x @ M") 'event-apply-meta-control-modifier)


;	filename

;; Arduinoファイル(.ino)をarduino-modeで開く
(add-to-list 'load-path "~/.emacs.d/vendor/arduino")
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arudino editting mode." t)


;	package (sakito.jp/emacs/emacs23.html)

;; elispパッケージのリポジトリを追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Twittering Mode の設定 (fukuyama.co/twittering-modeを参考)
;;; twittering-mode 読み込み
(require 'twittering-mode)
;;; 起動時パスワード認証
(setq twittering-use-master-password t)
(setq twittering-use-ssl t)
;;; パスワード暗号ファイル保存先変更
(setq twittering-private-info-file "~/.emacs.d/twittering-mode.gpg")
;;; 表示する書式
;(setq twitteringstatus-format "%i @%s %S %p: n %T  [%@]%r %R %f%Ln --------------------------------------------------")
;;; アイコンを表示する
(setq twittering-icon-mode t)
;;; 更新頻度（秒）
(setq twittering-timer-interval 60)
;;; ツイートの取得数
(setq twittering-number-of-tweets-on-retrieval 200)
;;; o で次のURLをブラウザでオープン
(defun twittering-mode-hook-func ()
 	(define-key twittering-mode-map (kbd "<") 'my-beginning-of-buffer)
 	(define-key twittering-mode-map (kbd ">") 'my-end-of-buffer)
	(define-key twittering-mode-map (kbd "f") 'twittering-favorite)
	(lambda ()
		(local-set-key (kbd "o")
			(lambda ()
				(interactive)
				(twittering-goto-next-uri)
				(execute-kbd-macro (kbd "C-m"))
				))))
(add-hook 'twittering-mode-hook 'twittering-mode-hook-func)

;; apples-mode: AppleScript用拡張（github.com/tequilasunset/apples-mode)
;;; load-pathにapples-modeを追加
(setq load-path
      (cons "~/.emacs.d/elpa/apples-mode" load-path))
;;; apples-modeをロード
(require 'apples-mode)
(add-to-list 'auto-mode-alist '("\\.\\(applescri\\|sc\\)pt\\'" . apples-mode))

;; anything
(require 'anything)
(require 'anything-config)
(add-to-list 'anything-sources 'anything-c-source-recentf)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)
(add-to-list 'anything-sources 'anything-c-source-emacs-functions)
(add-to-list 'anything-sources 'anything-c-source-colors)

