; -----------------------------------------------------------------------------
; A 64-bit function that returns the length of a char* given as argument.
; The function has signature:
;
;   size_t ft_strlen( const char *s );
;
; S is in rdi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_strlen                      	; make it global so it can be accessed in another file with extern
            global      _ft_strlen                     	; for macos
            global      _Z9ft_strlenPKc					; for cpp
            global      __Z9ft_strlenPKc				; for macos cpp

			extern		ft_debug
			extern		ft_puthexnbr

            section     .text
__Z9ft_strlenPKc:
_Z9ft_strlenPKc:
_ft_strlen:
ft_strlen:
            test        rdi, rdi
            jz          null
            mov         rax, -1
loop:
	        inc         rax
			; call		ft_debug
			; push 		rdi
			; mov			rdi, rax
			; call		ft_puthexnbr
			; pop			rdi
	        cmp         byte [rdi + rax], 0
	        jne         loop
	        ret
null:
            xor         rax, rax
            ret
