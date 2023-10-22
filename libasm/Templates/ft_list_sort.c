typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

void ft_list_sort( t_list *begin_list, int (*cmp)() )
{
	if (!begin_list || !cmp) {
		return ;
	}
	t_list *tmp = begin_list;

	while (tmp->next) {
		if (cmp(tmp->data, tmp->next->data) > 0) {
			void *swap = tmp->data;
			tmp->data = tmp->next->data;
			tmp->next->data = swap;
			return (ft_list_sort(begin_list, cmp));
		}
		tmp = tmp->next;
	}
}

int main( void )
{
	return (0);
}
