; -----------------------------------------------------------------------------
; A 64-bit function that writes arg nbr on terminal in hex format (with '-' if neg).
; The function has signature:
;
;   void ft_puthexnbr( long nbr );
;
; Nbr is in rdi.
; No return.
; -----------------------------------------------------------------------------

            global      ft_puthexnbr
			extern		ft_debug

            section     .text
ft_puthexnbr:
			push	rbp
			mov		rbp, rsp
			sub		rsp, 8
			mov		rsi, rbp
			sub		rsi, 8					; set rsi as value on top of stack
			push	rdi
			push	rsi
			push	rdx
			push	rax
			push	r10
			push	r11
			cmp		rdi, 0
			jge		prefix
			mov		rax, 45					; '-'
			call	ft_putchar
			neg		rdi
prefix:
			mov		rax, 48					;'0'
			call	ft_putchar
			mov		rax, 120				;'x'
			call	ft_putchar
			call	loop
			mov 	rax, 10					; '\n'
			call	ft_putchar
			jmp 	done
loop:
			cmp 	rdi, 0x10
			jl		ft_puthex
			push    rdi
			shr		rdi, 4
			call	loop
			pop		rdi
			and		rdi, 0xF
ft_puthex:
			mov		rax, rdi
			add		rax, 48					; rax += '0'
			cmp		rax, 57					; '9'
			jg		offset
			call	ft_putchar
			ret
offset:
			add		rax, 7
			call	ft_putchar
			ret
ft_putchar:
			; call	ft_debug
			mov		QWORD [rsi], rax
			; call	ft_debug
			mov		rax, 1					; write
			push 	rdi
			mov		rdi, 1					; fd = 1
			mov		rdx, 1					; size = 1 byte
			syscall
			pop		rdi
			ret
done:
			pop		r11
			pop		r10
			pop		rax
			pop		rdx
			pop		rsi
			pop		rdi
			mov		rsp, rbp				; restore stack frame
			pop		rbp
			ret
