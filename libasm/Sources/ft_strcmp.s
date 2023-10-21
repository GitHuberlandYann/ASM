; -----------------------------------------------------------------------------
; A 64-bit function that compares content of s1 and s2
; The function has signature:
;
;   int strcmp( const char *s1, const char *s2 );
;
; S1 is in rdi, s2 is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_strcmp
            global      _Z9ft_strcmpPKcS0_

            section     .text
_Z9ft_strcmpPKcS0_:
ft_strcmp:
			cmp 		rdi, 0       ;strcmp from man segfaults .. tbd
			je			error
			cmp 		rsi, 0
			je			error
            mov         rcx, -1
loop:
	        inc         rcx
			movzx 		rax, byte [rdi + rcx]
			cmp			al, 0
			je			done
			cmp			al, byte [rsi + rcx] 
	        je         loop
done:
			movzx		rdx, byte [rsi + rcx]  ; zero padding
			sub			rax, rdx
			ret
error:
			xor			rax, rax
