(setq org-startup-indented t)
(require 'ess-site)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (sh . t)
   (R . t)
  )
)
(setq org-src-fontify-natively t)
