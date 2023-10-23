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
            global      _ft_list_sort
            ; global      _Z18ft_list_sortPP6s_listPv
            ; global      __Z18ft_list_sortPP6s_listPv

			extern 		ft_debug
			extern		ft_puthexnbr

            section     .text
; __Z18ft_list_sortPP6s_listPv:
; _Z18ft_list_sortPP6s_listPv:
_ft_list_sort:
ft_list_sort:
			push		rdi
			cmp			rdi, 0
			je			done
			cmp			rsi, 0
			je			done
			mov			rdx, rsi				; rdx = cmp
			mov			r10, QWORD [rdi]        ; r10 = tmp = *begin_list
loop:
			; call		ft_debug
			mov			r11, QWORD [r10 + 8]  	; r11 = tmp.next
			; call		ft_debug
			cmp			r11, 0
			je			done
			mov			rdi, QWORD [r10]		; rdi = tmp.data
	
			push		rdi
			mov			rdi, r11
			call		ft_puthexnbr
			mov			rdi, r10
			call		ft_puthexnbr
			add			rdi, 8
			call		ft_puthexnbr
			mov			rdi, QWORD [rdi]
			call		ft_puthexnbr
			pop			rdi
	
			call		ft_debug
			mov			rsi, QWORD [r11]		; rsi = tmp.next.data
			call		ft_debug
			push 		r10
			push 		r11
			call		rdx
			pop			r11
			pop			r10
			call		ft_debug
			cmp			rax, 0
			jg			ft_swap
			mov			r10, r11				; r10 = tmp.next
			jmp 		loop
ft_swap:
			mov			rax, QWORD [r10]
			mov			rdx, QWORD [r11]
			call		ft_debug
			mov			QWORD [r11], rdx
			call		ft_debug
			mov			QWORD [rax], rdi
			call		ft_debug
			pop			rdi						; rdi = begin_list
			mov			rsi, rdx
			call		ft_list_sort
			ret
done:
			pop			rdi
			ret
