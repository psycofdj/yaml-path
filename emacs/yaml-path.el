(defcustom yaml-path-bin
  "yaml-path"
  "Path to yaml-path binary."
  :group 'yaml-path
  :type 'string
  :safe 'stringp)


;;;###autoload
(defun yaml-path-at-point()
  (interactive)
  (let ((result "unknown")
        (outbuf (get-buffer-create "*yaml-path-result*")))
    (call-process-region
     (point-min) (point-max) "yaml-path"
     nil outbuf nil
     "-line" (number-to-string (line-number-at-pos)) "-col" (number-to-string (current-column)))
    (with-current-buffer outbuf
      (setq result (replace-regexp-in-string "\n+" "" (buffer-string)))
      )
    (kill-buffer outbuf)
    result
    )
  )

;;;###autoload
(defun yaml-path-which-func()
  (add-hook 'which-func-functions 'yaml-path-at-point t t)
  )

;; --------------------------------------------------------------------------- ;

;;;###autoload
(put 'yaml-path-bin 'safe-local-variable 'stringp)

(provide 'yaml-path)

;; Local Variables:
;; ispell-local-dictionary: "american"
;; End:
