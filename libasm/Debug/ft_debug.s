; -----------------------------------------------------------------------------
; A 64-bit function that writes "DEBUG" on terminal.
; The function has signature:
;
;   void ft_debug( void );
;
; No arg.
; No return.
; -----------------------------------------------------------------------------

            global      ft_debug
            global      _ft_debug

            section     .text
_ft_debug:
ft_debug:
			push	rdi
			push	rsi
			push	rdx
			push	rax
			push	r10
			push	r11

			mov		rax, 1
			mov		rdi, 1
            mov 	rsi, message
			mov		rdx, length
			syscall

			pop		r11
			pop		r10
			pop		rax
			pop		rdx
			pop		rsi
			pop		rdi
			ret

			section		.data
message:	db		"DEBUG", 10, 0
length:		equ		$-message
