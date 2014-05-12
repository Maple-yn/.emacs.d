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

;;; C-hをBackspaceにキーバインド
;(keyboard-translate ?C-h ?\C-?)
(define-key global-map "\C-h" 'delete-backward-char)
;;; C-c C-hをヘルプにキーバインド
(define-key global-map "\C-c\C-h" 'help-for-help)


;;; 背景色変更
(set-face-background 'default "black")
;;; 文字色変更
;(set-face-foreground 'default "white")

;;; 括弧のハイライト
(show-paren-mode t)

;;; Terminal上のEmacsでのみの設定
;(if (not window-system)
;
;)

;	package (sakito.jp/emacs/emacs23.html)

;;; elispパッケージのリポジトリを追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; Twittering Mode の設定 (fukuyama.co/twittering-modeを参考)
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
