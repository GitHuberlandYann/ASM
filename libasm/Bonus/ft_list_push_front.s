; -----------------------------------------------------------------------------
; A 64-bit function that sets new as head of lst.
; The function has signature:
;
;   void ft_list_push_front( t_list **lst, t_list *new );
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

            global      ft_list_push_front
            global      _Z12ft_list_push_frontP6s_list

            section     .text
_Z12ft_list_push_frontP6s_list:
ft_list_push_front:
			cmp			QWORD [rdi], 0
	        je          done
			cmp			QWORD [rsi], 0
			je			done
			mov			rax, QWORD [rdi]
			mov			QWORD [rsi + 8], rax
			mov			QWORD [rdi], rsi
done:
			ret
