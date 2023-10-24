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
            global      _Z18ft_list_push_frontPP6s_listPKv
			extern		malloc

            section     .text
_Z18ft_list_push_frontPP6s_listPKv:
ft_list_push_front:
			test 		rdi, rdi
	        jz          .done
			push 		rsi					; malloc modifies rsi
			push		rdi
			mov			rdi, 0x10
			call		malloc wrt ..plt
			pop			rdi
			pop			rsi
			test 		rax, rax
			jz			.done
			mov			rdx, QWORD [rdi]
			mov			QWORD [rax], rsi
			mov			QWORD [rax + 8], rdx
			mov			QWORD [rdi], rax
.done:
			ret
