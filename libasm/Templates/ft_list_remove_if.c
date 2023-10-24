typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

static void ft_free_lst( t_list *lst, void (*free_fct)(void *) )
{
	if (free_fct) {
		free_fct(lst->data);
	}
	free(lst);
}

void ft_list_remove_if( t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *) )
{
	if (!begin_list || !cmp) {
		return ;
	}
	t_list *lst = *begin_list;

	while (lst && !cmp(lst->data, data_ref)) {
		*begin_list = lst->next;
		ft_free_lst(lst, free_fct);
		lst = *begin_list;
	}
	while (lst && lst->next) {
		if (!cmp(lst->next->data, data_ref)) {
			t_list *tmp = lst->next;
			lst->next = lst->next->next;
			ft_free_lst(tmp, free_fct);
		} else {
			lst = lst->next;
		}
	}
}
