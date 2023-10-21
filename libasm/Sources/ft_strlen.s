; -----------------------------------------------------------------------------
; A 64-bit function that returns the lenght of a char* given as argument.
; The function has signature:
;
;   size_t strlen( const char *s );
;
; Arg is in rdi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_strlen                      ; make it global so it can be accessed in another file with extern
            global      _Z9ft_strlenPKc
            ;type       ft_strlen, @function

            section     .text
_Z9ft_strlenPKc:                                       ; name in cpp.o .. to research 
ft_strlen:
            mov         rax, -1
loop:
	        inc         rax
	        cmp         byte [rdi + rax], 0
	        jne         loop
	        ret; is this usefull?
