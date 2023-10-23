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
            global      _ft_strdup
			global      _Z9ft_strdupPKc
			global      __Z9ft_strdupPKc

			extern		ft_strlen
			extern 		_malloc
			extern		ft_strcpy

            section     .text
__Z9ft_strdupPKc:
_Z9ft_strdupPKc:
_ft_strdup:
ft_strdup:
			push 		rdi
			test		rdi, rdi        ; test = 'and' but we don't change value, only set z register
			jz			null
			call		ft_strlen
			inc			rax
			mov			rdi, rax
			;REPLACE call		malloc WRT ..plt
			call		_malloc
			test		rax, rax
			jz			null
			mov			rdi, rax
			pop			rsi
			call		ft_strcpy
			ret
null:
			pop			rax
			xor			rax, rax
			ret
