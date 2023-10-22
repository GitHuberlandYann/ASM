; -----------------------------------------------------------------------------
; A 64-bit function that returns the length of the linked list given as arg.
; The function has signature:
;
;   int ft_list_size( t_list *begin_list );
;
; t_list is defined as follow:
;
;  typdef struct s_list {
;		void *data;
;		struct s_list *next;
;  }				t_list;
;
; Begin_list is in rdi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_list_size
            global      _Z12ft_list_sizeP6s_list

            section     .text
_Z12ft_list_sizeP6s_list:
ft_list_size:
            xor         rax, rax
loop:
	        test        rdi, rdi
	        jz          done
			mov			rdi, QWORD [rdi + 8]
	        inc         rax
			jmp 		loop
done:
			ret
