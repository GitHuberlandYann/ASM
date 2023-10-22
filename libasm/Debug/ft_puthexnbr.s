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
			push	rdi
			push	rsi
			push	rdx
			push	rax
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
			cmp		rax, 57
			jg		offset
			call	ft_putchar
			ret
offset:
			add		rax, 7
			call	ft_putchar
			ret
ft_putchar:
			mov		QWORD [rsi], rax
			mov		rax, 1					; write
			push 	rdi
			mov		rdi, 1					; fd = 1
			mov		rdx, 1					; size = 1 byte
			syscall
			pop		rdi
			ret
done:
			pop		rax
			pop		rdx
			pop		rsi
			pop		rdi
			ret
