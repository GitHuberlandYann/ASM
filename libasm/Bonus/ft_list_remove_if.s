; -----------------------------------------------------------------------------
; A 64-bit function that frees all nodes of list whose data compares to data_ref.
; The function has signature:
;
;   void ft_list_remove_if( t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *) );
;
; t_list is defined as follow:
;
;  typdef struct s_list {
;		void *data;
;		struct s_list *next;
;  }				t_list;
;
; Begin_list is in rdi, data_ref in rsi, cmp in rdx, free_fct in rcx.
; There is no return value.
; -----------------------------------------------------------------------------

            global      ft_list_remove_if
            global      _Z17ft_list_remove_ifPP6s_listPKvPFiPKcS5_EPFvPvE

			extern		free

            section     .text
_Z17ft_list_remove_ifPP6s_listPKvPFiPKcS5_EPFvPvE:
ft_list_remove_if:
			push		rbp
			mov			rbp, rsp
			sub			rsp, 32
			test		rdi, rdi
			jz			.done
			test		rdx, rdx
			jz			.done
			mov			qword [rsp], rdi
			mov			qword [rsp + 8], rsi
			mov			qword [rsp + 16], rdx
			mov			qword [rsp + 24], rcx
			mov			r10, qword [rdi]		; r10 = tmp = *begin_list
.loop_front:
			test		r10, r10
			jz			.restore_stack
			mov			rdi, qword [r10]		; rdi = tmp->data
			mov			rsi, qword [rsp + 8]
			mov			rdx, qword [rsp + 16]
			push		r10
			call		rdx
			pop			r10
			test		eax, eax
			jnz			.main_loop
			mov			rdi, qword [r10 + 8]
			mov			r11, qword [rsp]
			mov			qword [r11], rdi		; *begin_list = tmp->next
			mov			rdi, r10
			mov			rsi, qword [rsp + 24]
			call		ft_free_node
			mov			rdi, qword [rsp]
			mov			r10, qword [rdi]
			jmp			.loop_front
.main_loop:
			test		r10, r10
			jz			.restore_stack
			mov			r11, qword [r10 + 8]	; r11 = tmp->next
			test		r11, r11
			jz			.restore_stack
			mov			rdi, qword	[r11]		; rdi = tmp->next->data
			mov			rsi, qword [rsp + 8]
			mov			rdx, qword [rsp + 16]
			push		r10
			push		r11
			call		rdx
			pop			r11
			pop			r10
			test		eax, eax
			jnz			.inc_node
			mov			rdi, r11				; rdi = tmp->next
			mov			r11, qword [r11 + 8]	; r11 = tmp->next->next
			mov			qword [r10 + 8], r11	; tmp->next = tmp->next->next
			mov			rsi, qword [rsp + 24]
			push		r10
			call		ft_free_node
			pop			r10
			jmp			.main_loop
.inc_node:
			mov			r10, r11				; tmp = tmp->next
			jmp			.main_loop
.restore_stack:
			mov		rsp, rbp
			pop		rbp
.done:
			ret

ft_free_node:
			test	rsi, rsi
			je		.free_node
			push	rdi
			mov		rdi, qword [rdi]			; rdi = node->data
			call	rsi
			pop		rdi
.free_node:
			call	free wrt ..plt
			ret
