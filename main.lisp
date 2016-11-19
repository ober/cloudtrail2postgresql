(in-package :metis)

(defun argv ()
  (or
   #+clisp (ext:argv)
   #+sbcl sb-ext:*posix-argv*
   #+abcl ext:*command-line-argument-list*
   #+clozure (ccl::command-line-arguments)
   #+gcl si:*command-args*
   #+ecl (loop for i from 0 below (si:argc) collect (si:argv i))
   #+cmu extensions:*command-line-strings*
   #+allegro (sys:command-line-arguments)
   #+lispworks sys:*line-arguments-list*
   nil))


(defun main ()
  (init-manard)
  (let* ((args (argv))
	 (verb (nth 1 args))
	 (workers (nth 2 args))
	 (dir (nth 3 args)))
    (cond
      ((equal "main" verb) (main))
      ((equal "a" verb)(time (cloudtrail-report-async workers dir)))
      ((equal "v" verb)(time (vpc-flows-report-async workers dir)))
      ((equal "b" verb)(time (bench-vpc-flows-report-async workers dir)))
      ((equal "s" verb)(time (cloudtrail-report-sync workers)))
      ((equal "sn" verb)(time (get-by-name workers)))
      ((equal "ln" verb)(time (get-name-list)))
      ((equal "lev" verb)(time (get-event-list)))
      ((equal "seca" verb)(time (get-all-errorcodes)))
      ((equal "sev" verb)(time (get-by-event workers)))
      ((equal "sec" verb)(time (get-by-errorcode workers)))
      ((equal "lec" verb)(time (get-errorcode-list)))
      ((equal "r" verb)(time (run-bench)))
      (t (progn
	   (format t "Usage: <~A> <function> <args>~%" (nth 0 args))
	   (format t "Function is (s) for single threaded, and (a) for multithreaded~%")
	   (format t "ex: ~A a 10 ~~/CT/ # Would run 10 works on ~~/CT/~%" (nth 0 args))
	   (format t "ex: ~A s ~~CT/ # Would run 10 works on ~~/CT/~%" (nth 0 args)))))))
  ;;(cl-store:store *q* "~/q.store"))

#+allegro
(in-package :cl-user)

#+allegro
(defun main (&rest args)
  (metis::init-manard)
  ;;(db.ac:open-network-database "localhost" 2222)

  (format t "args :~s %" args)
  (let ((verb (or (nth 1 args) nil))
	(a (or (nth 2 args) nil))
	(b (or (nth 3 args) nil))
	(c (or (nth 4 args) nil)))
    (format t "Got: app:~A verb:~A workers:~A dir:~A~%" a b c d)
    (cond
      ((equal "a" verb)(time (metis::cloudtrail-report-async a b)))
      ((equal "b" verb)(time (metis::bench-vpc-flows-report-async a b)))
      ((equal "da" verb)(metis::find-by-dstaddr a))
      ((equal "date" verb)(metis::find-by-date a))
      ((equal "dp" verb)(metis::find-by-dstport a))
      ((equal "f" verb)(time (metis::find-by-field a b c)))
      ((equal "lec" verb)(time (metis::get-errorcode-list)))
      ((equal "lev" verb)(time (metis::get-event-list)))
      ((equal "ln" verb)(time (metis::get-name-list)))
      ((equal "s" verb)(time (metis::cloudtrail-report-sync a)))
      ((equal "sa" verb)(metis::find-by-srcaddr a))
      ((equal "sec" verb)(time (metis::get-by-errorcode workers)))
      ((equal "seca" verb)(time (metis::get-all-errorcodes)))
      ((equal "sev" verb)(time (metis::get-by-event workers)))
      ((equal "sn" verb)(time (metis::get-by-name workers)))
      ((equal "sp" verb)(metis::find-by-srcport a))
      ((equal "v" verb)(time (metis::vpc-flows-report-async a b)))



      ((equal "r" verb)(time (metis:run-bench)))
      (t (format t "Usage <~A> <p or s> <directory of logs>" app)))))
;; ;;(cl-store:store *q* "~/q.store"))
