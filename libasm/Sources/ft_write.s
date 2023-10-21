; -----------------------------------------------------------------------------
; A 64-bit function that makes a syscall to write.
; The function has signature:
;
;   ssize_t write( int fd, const char *buf, size_t nbyte );
;
; Fd is in rdi, buf is in rsi, nbyte is in RDX.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_write
			global      _Z8ft_writeiPKvm
			extern		__errno_location

            section     .text
_Z8ft_writeiPKvm:
ft_write:
			mov 		rax, 1		; system call 1 is ft_write
									; no need to move rdi rsi rdx because they are at the right place
			syscall
			cmp			rax, 0
			jl          error
			ret						; rax is set by syscall
error:
			neg         rax
			mov			rdx, rax
			call		__errno_location WRT ..plt
			mov 		[rax], rdx
			mov 		rax, -1
