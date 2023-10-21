; -----------------------------------------------------------------------------
; A 64-bit program to test some things out.
;
; Arc is in rdi, argv is in rsi.
; Return value is in rax.
; -----------------------------------------------------------------------------
			global 	main
			extern 	puts

            section .text
main:
	        push    r12                     ; save callee-save registers
        	push    r13
    	    push    r14
	        ; By pushing 3 registers our stack is already aligned for calls

			cmp		rdi, 1
			jne		error

			mov 	rdi, message
			call 	puts WRT ..plt
			xor		rax, rax
			jmp		done
error:										; print error message
			mov		rdi, badArgumentCount
			call	puts WRT ..plt
			mov 	rax, 1
done:										; restore saved registers
			pop		r14
			pop		r13
			pop		r12
			ret

			section	.data
message:
			db 		"Hello World!", 10, 0
badArgumentCount:
			db		"Bad number of arguments", 0