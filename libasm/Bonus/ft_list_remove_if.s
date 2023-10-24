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
            ; global      _Z12ft_list_remove_ifP6s_listPFiPKcS2_E

            section     .text
; _Z12ft_list_remove_ifP6s_listPFiPKcS2_E:
ft_list_remove_if:
