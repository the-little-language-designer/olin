(define CLASS
  (lambda class-record
    (lambda argument-record
      (define require-list
        (let ([pair (assq 'require class-record)])
          (if (pair? pair)
            (cdr pair)
            '())))
      (if (member #f
                  (map (lambda (message)
                         (assq message argument-record))
                    require-list))
        (error "- argument do not meet require-list"
          (list "argument:" argument-record
                "require-list:" require-list)))
      (let ()
        (define record
          (let ([result-record
                 (append argument-record
                         class-record)])
            (set! result-record
                  (append result-record
                          (list (cons 'message result-record))))
            result-record))
        (define self
          (lambda (message . rest)
            (cond [(symbol? message)
                   (let ([pair (assq message record)])
                     (cond [(pair? pair)
                            (let ([fun (cdr pair)])
                              (if (procedure? fun)
                                (apply fun (cons self rest))
                                fun))]
                           [else
                            (error "- unknown message: " message)]))]
                  [(vector? message)
                   (let* ([actual-message (vector-ref message 0)]
                          [value (vector-ref message 1)]
                          [pair (assq actual-message record)])
                     (if (pair? pair)
                       (set-cdr! pair value)
                       (error "- unknown message to set: " actual-message)))]
                  [else
                   (error "- unknown argument pattern: " message)])))
        (if (assq `init record)
          (self `init))
        self))))

(define up vector)

(define BUFFER
  (CLASS
   (cons `require `(size init-value))
   (cons `init
         (lambda (self)
           (self (up `vector (make-vector (self `size)
                                          (self `init-value))))))
   (cons `vector `())
   (cons `cursor 0)
   (cons `set
         (lambda (self address value)
           (vector-set! (self `vector) address value)))
   (cons `get
         (lambda (self address)
           (vector-ref (self `vector) address)))))

(define buffer0
  (BUFFER
   (cons `size 64)
   (cons `init-value 555)))

(buffer0 `cursor)
(buffer0 `set 6 666)
(buffer0 `get 6)
;; (buffer0 `message)

(define STACK
  (CLASS
   (cons `require `(size init-value))
   (cons `init
         (lambda (self)
           (self (up `buffer-box
                     (list (BUFFER
                            (cons `size
                                  (self `size))
                            (cons `init-value
                                  (self `init-value))))))))
   (cons `buffer-box '())
   (cons `push
         (lambda (self value)
           (let ([buffer (car (self `buffer-box))])
             (buffer `set (buffer `cursor) value)
             (buffer (up `cursor (+ 1 (buffer `cursor)))))))
   (cons `pop
         (lambda (self)
           (let ([buffer (car (self `buffer-box))])
             (buffer (up `cursor (- (buffer `cursor) 1)))
             (buffer `get (buffer `cursor)))))))

(define argument-stack
  (STACK
   (cons `size 64)
   (cons `init-value 0)))

(argument-stack `push 1)
(argument-stack `push 2)
(argument-stack `push 3)
(argument-stack `pop)
(argument-stack `pop)
(argument-stack `pop)
(argument-stack `size)
