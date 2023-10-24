; -----------------------------------------------------------------------------
; A 64-bit function that copies content of src into dest, and returns a pointer to dest.
; The function has signature:
;
;   char *ft_strcpy( char *dest, const char *src );
;
; Dest is in rdi, src is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_strcpy
            global      _Z9ft_strcpyPcPKc

            section     .text
_Z9ft_strcpyPcPKc:
ft_strcpy:
			test 		rdi, rdi       ;strcpy from man segfaults .. tbd
			jz			.error
			test 		rsi, rsi
			jz			.error
            mov         rcx, -1
.loop:
	        inc         rcx
			mov 		al, byte [rsi + rcx]
			mov 		byte [rdi + rcx], al
	        test        al, al
	        jnz         .loop
.done:
			mov			rax, rdi
			ret
.error:
			xor			rax, rax
			ret
