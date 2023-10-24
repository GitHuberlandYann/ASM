; -----------------------------------------------------------------------------
; A 64-bit function that allocs space on memory and fill it with content of string s.
; The function has signature:
;
;   char *ft_strdup( const char *s );
;
; S is in rdi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_strdup
			global      _Z9ft_strdupPKc

			extern		ft_strlen
			extern 		malloc
			extern		ft_strcpy

            section     .text
_Z9ft_strdupPKc:
ft_strdup:
			push 		rdi
			test		rdi, rdi
			jz			.null
			call		ft_strlen
			inc			rax
			mov			rdi, rax
			call		malloc WRT ..plt
			test		rax, rax
			jz			.null
			mov			rdi, rax
			pop			rsi
			call		ft_strcpy
			ret
.null:
			pop			rax
			xor			rax, rax
			ret
