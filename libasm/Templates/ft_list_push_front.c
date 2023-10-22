#include <stddef.h>

typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

void ft_list_push_front( t_list **begin_list, void *data )
{
	if (!begin_list) {
		return ;
	}
	t_list *new = malloc(sizeof(*new));
	if (!new) {
		return ;
	}
	new->data = data;
	new->next = *begin_list;
	*begin_list = new;
}

int main( void )
{
	return (0);
}