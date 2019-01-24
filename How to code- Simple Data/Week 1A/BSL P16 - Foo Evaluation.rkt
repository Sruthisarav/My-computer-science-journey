(foo (substring "abcde" 0 3))
(foo ("abc"))
(if (string=? (substring "abc" 0 1) "a")
     (string-append "abc" "a")
     "abc")
(if (string=? "a" "a")
     (string-append "abc" "a")
     "abc")
(if true
     (string-append "abc" "a")
     "abc")
(string-append "abc" "a")
"abca"
