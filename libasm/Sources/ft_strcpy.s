; -----------------------------------------------------------------------------
; A 64-bit function that copies content of src into dest, and returns a pointer to dest.
; The function has signature:
;
;   char *strcpy( char *dest, const char *src );
;
; Dest is in rdi, src is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_strcpy
            global      _Z9ft_strcpyPcPKc
            ;type       ft_strlen, @function

            section     .text
_Z9ft_strcpyPcPKc:
ft_strcpy:
			cmp 		rdi, 0       ;strcpy from man segfaults .. tbd
			je			error
			cmp 		rsi, 0
			je			error
            mov         rcx, -1
loop:
	        inc         rcx			; using rax here doesn't work.. no understando
			mov 		al, byte [rsi + rcx]
			mov 		byte [rdi + rcx], al
	        cmp         byte [rsi + rcx], 0
	        jne         loop
done:
			mov			rax, rdi
			ret
error:
			mov			rax, 0