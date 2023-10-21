#include <stddef.h>

typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

size_t ft_list_size( t_list *lst )
{
	size_t res = 0;

	while (lst) {
		++res;
		lst = lst->next;
	}
	return (res);
}

int main( void )
{
	return (0);
}