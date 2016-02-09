(load "load.lisp")

(compile-file "pkgdcl.lisp" :system-p t)
(compile-file "utils.lisp" :system-p t)
(compile-file "ctcl.lisp" :system-p t)
(compile-file "main.lisp" :system-p t)


(defconstant +standalone-exe+ (compile-file-pathname "ctcl-ecl" :type :program))

(c::build-program +standalone-exe+
		  :lisp-files
		  (list (compile-file-pathname "load.lisp" :type :object))
		  :epilogue-code
		  'ctcl:main))
