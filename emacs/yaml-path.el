(defcustom yaml-path-bin
  "yaml-path"
  "Path to yaml-path binary."
  :group 'yaml-path
  :type 'string
  :safe 'stringp)


;;;###autoload
(defun yaml-path-at-point()
  (interactive)
  (let* ((path (yaml-path-get-path-at-point)))
    (kill-new path)
    (message "%s" (yaml-path-get-path-at-point)))
  )

(defun yaml-path-get-path-at-point(&optional pline pcol)
  (let ((result "???")
        (line (if pline pline (number-to-string (line-number-at-pos))))
        (col  (if pcol  pcol  (number-to-string (current-column))))
        (outbuf (get-buffer-create "*yaml-path-result*")))

    (when (= 0 (call-process-region
                (point-min) (point-max) yaml-path-bin
                nil outbuf nil
                "-line" line "-col" col))
      (with-current-buffer outbuf
        (setq result (replace-regexp-in-string "\n+" "" (buffer-string)))
        ))
    (kill-buffer outbuf)
    result
    )
  )

;;;###autoload
(defun yaml-path-which-func()
  (add-hook 'which-func-functions 'yaml-path-get-path-at-point t t)
  )

;; --------------------------------------------------------------------------- ;

;;;###autoload
(put 'yaml-path-bin 'safe-local-variable 'stringp)

(provide 'yaml-path)

;; Local Variables:
;; ispell-local-dictionary: "american"
;; End:
