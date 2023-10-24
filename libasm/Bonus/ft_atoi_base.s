; -----------------------------------------------------------------------------
; A 64-bit function that returns the decimal number represented in str which is in base 'base'.
; The function has signature:
;
;   int ft_atoi_base( char *str, char *base );
;
; Str is in rdi, base is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_atoi_base
            global      _Z12ft_atoi_basePKcS0_

			extern		ft_strlen

            section     .text
_Z12ft_atoi_basePKcS0_:
ft_atoi_base:
            test        rdi, rdi
            jz          zero
			test 		rsi, rsi
			jz			zero
			push		rdi
			call		ft_valid_base 			; after call, strlen(base) is in r10
			pop			rdi
			test		eax, eax
			jz			zero
            mov         rcx, -1
			push		rsi
			mov			rsi, rdi
.skip_space:
			inc			rcx
			mov			dil, byte [rsi + rcx]
			call		ft_isspace
			cmp			eax, 1
			je			.skip_space
			mov			r11, 1					; sign = 1
.skip_signs:
			mov			dil, byte [rsi + rcx]
			call		ft_issign
			cmp			eax, 1
			je			.handle_sign
			mov			r12, 0					; res = 0
			mov			r8, rsi					; str
			pop			rsi						; base
.actual_loop:
			call		ft_strchr_zero
			cmp			eax, -1
			jne			.add_value
			mov			eax, r12d
			imul		eax, r11d
			ret
.add_value:
			; res = len * res + index
			imul		r12, r10
			add			r12d, eax
			inc			rcx
			mov			dil, byte [r8 + rcx]
			jmp			.actual_loop
.handle_sign:
			inc			rcx
			cmp			dil, 45	; '-'
			jne			.skip_signs
			neg			r11
			jmp			.skip_signs

; ----------
ft_valid_base:
			mov			rdi, rsi
			call		ft_strlen
			cmp			rax, 2
			jl			zero
			mov			r10, rax				; = size base
			mov			rcx, -1
.valid_base_loop:
			inc			rcx
			mov			dil, byte [rsi + rcx]
			test		dil, dil
			jz			one
			call		ft_isspace
			cmp			eax, 1
			je			zero
			call		ft_issign
			cmp			eax, 1
			je			zero
			call		ft_strchr
			cmp 		eax, -1
			jne			zero
			jmp			.valid_base_loop

; ---------------------------------
ft_isspace:
			cmp			dil, 32	; ' '
			je			one
			cmp			dil, 9		; '\t'
			jl			zero
			cmp			dil, 13	; '\r'
			jg			zero
			jmp			one
ft_issign:
			cmp			dil, 43	; '+'
			je			one
			cmp			dil, 45	; '-'
			je			one
			jmp			zero
ft_strchr_zero: ; same as strchr, but starts from 0
			push		rcx
			mov			rcx, -1
			call		ft_strchr
			pop			rcx
			ret
ft_strchr: ; int ft_strchr_zero(char c, char *s). return 0 if not found, index if found
			push		rcx
			call		.strchr_loop
			pop			rcx
			ret
.strchr_loop:
			inc			rcx
			cmp			byte [rsi + rcx], 0
			je			minus
			cmp			byte [rsi + rcx], dil
			jne			.strchr_loop
			mov			rax, rcx
			ret
; -------------
one:
			mov			eax, 1
			ret

; -------------
zero:
            xor         eax, eax				; eax because return int
            ret

; -------------
minus:
			mov			eax, -1
			ret