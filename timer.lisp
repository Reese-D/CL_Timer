(defpackage :CL_Timer
  (:use :common-lisp)
  (:export :defunt_t
	   :times
	   :nothing)
  (:shadow :defun))

(in-package :CL_Timer)

(defvar times '())

;;times contains lists, each list is one function call. Each list has the following structure
;;(Function_Name (Arguments) real_run_time internal_run_time)

(defmacro defun (name args body)
  (let ((return-val (gensym)))
    `(common-lisp:defun ,name ,args
       (let ((real-base (get-internal-real-time))
	     (run-base (get-internal-run-time))
	     (,return-val ,body))
	 (setf times (cons (list ',name
				   (list ,@args)
				   (/ (- (get-internal-real-time) real-base) internal-time-units-per-second)
				   (/ (- (get-internal-run-time) run-base) internal-time-units-per-second))
			     times))
	 ,return-val))))

(defun wait_t (x)
  (sleep x))


(defun nothing (x y z)
  (list x y z))



