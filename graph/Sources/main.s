; -----------------------------------------------------------------------------
; A 64-bit program to test some things out.
;
; Argc is in rdi, argv is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------
			global 	main

			extern 	puts
			extern  openWindow
			extern  mainLoop

            section .text
main:
			push	rbp
			mov		rbp, rsp
			; sub		rsp, 8						; GLFWwindow*
			cmp		rdi, 1
			jne		.arg_error
			call	.greet
			; code goes here
			call	openWindow
			test	rax, rax
			jz		.failure
			push	rax
			mov		rdi, windowSuccess
			call	puts wrt ..plt
			pop		rdi
			call	mainLoop
			call	.leave
			xor		rax, rax
			jmp		.restore_stack
.arg_error:										; print error message
			mov		rdi, badArgumentCount
			call	puts wrt ..plt
.failure:
			mov 	rax, 1
.restore_stack:
			mov		rsp, rbp
			pop		rbp
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
windowSuccess		db		"Successfully created window", 10, 0
