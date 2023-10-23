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
            ; global      _Z9ft_atoi_basePKc

			extern		ft_strlen

            section     .text
; _Z9ft_atoi_basePKc:
ft_atoi_base:
            cmp         rdi, 0
            je          .null
			cmp 		rsi, 0
			je			.null
			push		rdi
			push		rsi
			call		.valid_base
			pop			rsi
			pop			rdi
			cmp			rax, 0					; 0 if problem, ft_strlen(base) otherwise
			je			.null
            mov         rcx, -1
			push		rdi
			push		rsi
			mov			rsi, rdi
.skip_space:
			inc			rcx
			mov			dil, byte [rsi + rcx]
			call		ft_isspace
			cmp			rax, 1
			je			.skip_space
			mov			r11, 1
			mov			dil, byte [rsi + rcx]
			mov			r12, 0
.add_value:
			pop			rsi
			pop			rdi

.skip_signs:
			mov			dil, byte [rsi + rcx]
			call		ft_issign
			cmp			rax, 0
			je			.handle_sign
.handle_sign:
			cmp			dil, 45	; '-'
			cmove		r11, -r11
			inc			rcx
			jmp			.skip_signs
.valid_base:
			mov			rdi, rsi
			call		ft_strlen
			cmp			rax, 2
			jl			.null
			
			mov			rcx, -1
			mov			r10, rax				; might want to return rax intact from here. (= size)
			call		.valid_base_loop
			cmp			rax, 0
			je			.null
			mov			rax, r10
			ret
.valid_base_loop:
			inc			rcx
			mov			dil, byte [rsi + rcx]
			cmp			dil, 0					; dil is rdi on 1 byte
			je			.one
			call		ft_isspace
			cmp			rax, 0
			je			.null
			call		ft_issign
			cmp			rax, 0
			je			.null
			call		ft_strchr
			cmp 		rax, 0
			je			.null
			jmp			.valid_base_loop
ft_isspace:
			cmp			dil, 32	; ' '
			je			.one
			cmp			dil, 9		; '\t'
			jl			.null
			cmp			dil, 13	; '\r'
			jg			.null
			jmp			.one
ft_issign:
			cmp			dil, 43	; '+'
			je			.null
			cmp			dil, 45	; '-'
			je			.null
			jmp			.one
ft_strchr: ; int ft_strchr(char c, char *s) with index in rcx. return 0 if not found, index if found
			push		rcx
			call		.strchr_loop
			pop			rcx
			ret
.strchr_loop:
			inc			rcx
			cmp			byte [rsi + rcx], 0
			je			.null
			cmp			byte [rsi + rcx], dil
			je			.strchr_found
			jmp			.strchr_loop
.strchr_found:
			mov			rax, rcx
			ret
.one:
			mov			rax, 1
			ret
.null:
            xor         eax, eax				; eax because return int
            ret
