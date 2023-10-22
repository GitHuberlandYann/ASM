typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

int ft_list_size( t_list *begin_list )
{
	int res = 0;

	while (begin_list) {
		++res;
		begin_list = begin_list->next;
	}
	return (res);
}

int main( void )
{
	return (0);
}