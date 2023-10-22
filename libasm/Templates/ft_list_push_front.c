#include <stddef.h>

typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

void ft_list_push_front( t_list **lst, t_list *new )
{
	if (!lst || !new) {
		return ;
	}
	new->next = *lst;
	*lst = new;
}

int main( void )
{
	return (0);
}