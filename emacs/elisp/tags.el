(setq tags-file-name "D:\\jdk\\jdk15\\src\\JDK15_ETAGS")

; find . -name "*.[chCH]" -print | etags -
;    * F7, ���� TAGS �ļ������� TAGS ��
;    * C-F7, �ڵ�ǰĿ¼�����ɰ������еݹ���Ŀ¼�� TAGS �ļ���ʹ����shell�е�find���
;    * C-. ����С���鿴��괦�� tag
;    * C-, ֻ���µ�ǰ�鿴����Ĵ��ڣ��رղ鿴 tag ��С����
;    * M-. ���ҹ�괦�� tag������ת
;    * M-, ����ԭ������ tag �ĵط�
;    * C-M-, ��ʾҪ���ҵ� tag������ת
;    * C-M-. Ҫƥ��� tag ���ʽ��ϵͳ�Ѷ��壩
;    * Shift-Tab, C/C++ �� lisp ��ģʽ�в�ȫ��������һ�������M-Tab�����ڹ����������ˣ�

(global-set-key [(f1)] 'find-tag)
(global-set-key [(M-f1)] 'visit-tags-table)         ; visit(open) tags table
;(global-set-key [C-f7] 'sucha-generate-tag-table) ; generate tag table
(global-set-key [(f2)] '(lambda () (interactive) (lev/find-tag t)))
(global-set-key [(M-f2)] 'sucha-release-small-tag-window)
(global-set-key [(f3)] 'lev/find-tag)
(global-set-key [(M-f3)] 'pop-tag-mark)

;(define-key lisp-mode-shared-map [(shift tab)] 'complete-tag)
;(add-hook 'c-mode-common-hook      ; both c and c++ mode
;          (lambda ()
;            (define-key c-mode-base-map [(shift tab)] 'complete-tag)))

(defun lev/find-tag (&optional show-only)
  "Show tag in other window with no prompt in minibuf."
  (interactive)
  (let ((default (funcall (or find-tag-default-function
                              (get major-mode 'find-tag-default-function)
                              'find-tag-default))))
    (if show-only
        (progn (find-tag-other-window default)
               (shrink-window (- (window-height) 12)) ;; allow 12 rows
               (recenter 1)
               (other-window 1))
      (find-tag default))))

(defun sucha-generate-tag-table ()
  "Generate tag tables under current directory(Linux)."
  (interactive)
  (let
      ((exp "")
       (dir ""))
    (setq dir
          (read-from-minibuffer "generate tags in: " default-directory)
          exp
          (read-from-minibuffer "suffix: "))
    (with-temp-buffer
      (shell-command
       (concat "find " dir " -name \"" exp "\" | xargs etags ")
       (buffer-name)))))

(defun sucha-release-small-tag-window ()
  "Kill other window also pop tag mark."
  (interactive)
  (delete-other-windows)
  (ignore-errors
    (pop-tag-mark)))
