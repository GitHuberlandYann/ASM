; -----------------------------------------------------------------------------
; A 64-bit program to test some things out.
;
; Argc is in rdi, argv is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------
			global 	main
			extern 	puts

            section .text
main:
			cmp		rdi, 1
			jne		.arg_error
			call	.greet
			; code goes here
			call	.leave
			xor		rax, rax
			ret
.arg_error:										; print error message
			mov		rdi, badArgumentCount
			call	puts wrt ..plt
			mov 	rax, 1
			ret
.greet:
			mov 	rdi, hello
			call 	puts wrt ..plt
			ret
.leave:
			mov 	rdi, bye
			call 	puts wrt ..plt
			ret

			section	.data
hello:		db 		10, " ---- Hello ----", 10, 0
bye:		db 		10, " ---- Goodbye ----", 10, 0
badArgumentCount:	db		"Expected format: ./graph", 0
