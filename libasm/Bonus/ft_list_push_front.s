; -----------------------------------------------------------------------------
; A 64-bit function that creates new t_list* and sets it as head of lst.
; The function has signature:
;
;   void ft_list_push_front( t_list **begin_list, void *data );
;
; t_list is defined as follow:
;
;  typdef struct s_list {
;		void *data;
;		struct s_list *next;
;  }				t_list;
;
; Begin_list is in rdi, data in rsi.
; There is no return value.
; -----------------------------------------------------------------------------

            global      ft_list_push_front
            global      _Z18ft_list_push_frontPP6s_listPv
			extern		malloc

            section     .text
_Z18ft_list_push_frontPP6s_listPv:
ft_list_push_front:
			push 		rsi					; seems like malloc modifies rsi
			cmp 		rdi, 0
	        je          done
			push		rdi
			mov			rdi, 16
			call		malloc WRT ..plt
			pop			rdi
			cmp 		rax, 0
			je			done
			mov			rdx, QWORD [rdi]
			pop			rsi
			mov			QWORD [rax], rsi
			mov			QWORD [rax + 8], rdx
			mov			QWORD [rdi], rax
done:
			ret
