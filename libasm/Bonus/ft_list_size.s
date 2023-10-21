; -----------------------------------------------------------------------------
; A 64-bit function that returns the length of the linked list given as arg.
; The function has signature:
;
;   size_t ft_list_size( t_list *lst );
;
; t_list is defined as follow:
;
;  typdef struct s_list {
;		void *data;
;		struct s_list *next;
;  }				t_list;
;
; S is in rdi.
; Return value is in rax.
; -----------------------------------------------------------------------------

            global      ft_list_size
            global      _Z12ft_list_sizeP6s_list

            section     .text
_Z12ft_list_sizeP6s_list:
ft_list_size:
            xor         rax, rax
loop:
	        cmp         rdi, 0
	        je          done
			mov			rdi, [rdi + 8]
	        inc         rax
			jmp 		loop
done:
			ret
