; -----------------------------------------------------------------------------
; A 64-bit function that compares content of s1 and s2
; The function has signature:
;
;   int ft_strcmp( const char *s1, const char *s2 );
;
; S1 is in rdi, s2 is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_strcmp
            global      _Z9ft_strcmpPKcS0_

            section     .text
_Z9ft_strcmpPKcS0_:
ft_strcmp:
			xor			rax, rax
			test 		rdi, rdi       ;strcmp from man segfaults .. tbd
			jz			.end
			test		rsi, rsi
			jz			.end
            mov         rcx, -1
.loop:
	        inc         rcx
			mov 		al, byte [rdi + rcx]
			test		al, al
			jz			.done
			cmp 		al, byte [rsi + rcx] 
	        je          .loop
.done:
			movzx		rdx, byte [rsi + rcx]  ; zero padding
			sub			rax, rdx
.end:
			ret
