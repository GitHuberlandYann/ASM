; -----------------------------------------------------------------------------
; A 64-bit function that sets new as head of lst.
; The function has signature:
;
;   void ft_list_add_front( t_list **lst, t_list *new );
;
; t_list is defined as follow:
;
;  typdef struct s_list {
;		void *data;
;		struct s_list *next;
;  }				t_list;
;
; Lst is in rdi, new in rsi.
; There is no return value.
; -----------------------------------------------------------------------------

            global      ft_list_add_front
            global      _ft_list_add_front
            global      _Z17ft_list_add_frontPP6s_listS0_
            global      __Z17ft_list_add_frontPP6s_listS0_

            section     .text
__Z17ft_list_add_frontPP6s_listS0_:
_Z17ft_list_add_frontPP6s_listS0_:
_ft_list_add_front:
ft_list_add_front:
			cmp			rdi, 0
	        je          done
			cmp			rsi, 0
			je			done
			mov			rax, QWORD [rdi]
			mov			QWORD [rsi + 8], rax
			mov			QWORD [rdi], rsi
done:
			ret
