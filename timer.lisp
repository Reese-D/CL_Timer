;; (defun test (x &optional y &rest c)
;;   (list x y c))

;; (defun test2 (x y z)
;;   (list x y z))

(defmacro defun_test (name args body)
  `(defun ,name ,args ,body))

;; (defun_test d_test (x y c)
;;   (list x y c))

(defun_test test3 (x &optional y &rest c)
  (list x y c))


(defun wait (x)
  (let ((start)
	(end))
    (setf start (get-universal-time))
    (sleep x)
    (setf end (get-universal-time))
    (- end start)))

(defmacro timings (function)
  `(let ((real-base (get-internal-real-time))
	 (run-base (get-internal-run-time)))
     ,function
     (values (/ (- (get-internal-real-time) real-base) internal-time-units-per-second)
	     (/ (- (get-internal-run-time) run-base) internal-time-units-per-second))))


(defvar times '())


(defmacro defun_t (name args body)
  (let ((return-val (gensym)))
    `(defun ,name ,args
       (let ((real-base (get-internal-real-time))
	     (run-base (get-internal-run-time))
	     (,return-val ,body))
	 (setf times (cons (list ',name
				   ',args
				   (/ (- (get-internal-real-time) real-base) internal-time-units-per-second)
				   (/ (- (get-internal-run-time) run-base) internal-time-units-per-second))
			     times))
	 ,return-val))))

(defun_t wait_t (x)
  (sleep x))

