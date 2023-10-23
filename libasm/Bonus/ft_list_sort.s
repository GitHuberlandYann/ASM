; -----------------------------------------------------------------------------
; A 64-bit function that sorts linked list using cmp fct on each node's data.
; The function has signature:
;
;   void ft_list_sort( t_list *begin_list, int (*cmp)() );
;
; t_list is defined as follow:
;
;  typdef struct s_list {
;		void *data;
;		struct s_list *next;
;  }				t_list;
;
; Begin_list is in rdi, cmp in rsi.
; There is no return value.
; -----------------------------------------------------------------------------

            global      ft_list_sort
            global      _Z12ft_list_sortP6s_listPFiPKcS2_E

            section     .text
_Z12ft_list_sortP6s_listPFiPKcS2_E:
ft_list_sort:
			push		rdi
			cmp			rdi, 0
			je			.done
			cmp			rsi, 0
			je			.done
			mov			rdx, rsi				; rdx = cmp
			mov			r10, rdi        		; r10 = tmp = begin_list
.loop:
			mov			r11, QWORD [r10 + 8]  	; r11 = tmp->next
			cmp			r11, 0
			je			.done
			mov			rdi, QWORD [r10]		; rdi = tmp->data
			mov			rsi, QWORD [r11]		; rsi = tmp->next->data
			push 		r10
			push 		r11
			push 		rdx
			call		rdx
			pop			rdx
			pop			r11
			pop			r10
			cmp			eax, 0
			jg			.ft_swap
			mov			r10, r11				; r10 = tmp->next
			jmp 		.loop
.ft_swap:
			mov			rax, QWORD [r10]
			mov			rcx, QWORD [r11]
			mov			QWORD [r10], rcx
			mov			QWORD [r11], rax
			pop			rdi						; rdi = begin_list
			mov			rsi, rdx
			call		ft_list_sort
			ret
.done:
			pop			rdi
			ret
