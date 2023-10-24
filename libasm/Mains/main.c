#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// #include <sys/types.h> was used for ssize_t
#include <unistd.h>

#define SECRET "top secret information"
#define TOP "Secret top information"
#define WRITEN "just because we look the same does not make us similar\n"

size_t ft_strlen( const char *s );
char *ft_strcpy( char *dst, const char *src );
int ft_strcmp( const char *s1, const char *s2 );
ssize_t ft_write( int fd, const void *buf, size_t nbyte );
ssize_t ft_read( int fd, void *buf, size_t nbyte );
char *ft_strdup( const char *s1 );

typedef struct s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

int ft_atoi_base( char *str, char *base );
// void ft_list_add_front( t_list **lst, t_list *new );
int ft_list_size( t_list *begin_list );
void ft_list_push_front( t_list **begin_list, void *data );
void ft_list_sort( t_list *begin_list, int (*cmp)() );

void ft_list_print( t_list *begin_list )
{
	int index = 0;
	t_list *tmp = begin_list;
	while (tmp) {
		printf("at index %d: %s\n", index, (char*)tmp->data);
		++index;
		tmp = tmp->next;
	}
}

void ft_printstr( void *data )
{
	printf("removing data \"%s\"\n", (char*)data);
}

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


int main( void )
{
	printf("\nstrlen('test') is %ld\n", ft_strlen("test"));

	char *src = SECRET;
	char *dst = malloc(1000);
	if (!dst) {
		return (1);
	}
	char *cpy = ft_strcpy(dst, src);
	printf("src %s, dst %s, cpy %s\n", src, dst, cpy);
	cpy = strcpy(dst, TOP);
	printf("src %s, dst %s, cpy %s\n", TOP, dst, cpy);

	printf("asm cmp = %d\n", ft_strcmp(src, cpy));
	printf("org cmp = %d\n", strcmp(src, cpy));

	ssize_t len = ft_write(1, WRITEN, ft_strlen(WRITEN));
	ssize_t olen = write(1, WRITEN, strlen(WRITEN));
	printf("ft len is %ld vs %ld\n", len, olen);

	len = ft_read(0, dst, 5);
	if (len >= 0) {
		dst[len] = '\0';
		printf("size %ld, buf is %s\n", len, dst);
	} else {
		printf("error on read %ld\n", len);
	}
	olen = read(0, dst, 10);
	if (olen >= 0) {
		dst[olen] = '\0';
		printf("size %ld, buf is %s\n", olen, dst);;
	} else {
		printf("error on read %ld\n", olen);
	}

	char *dupped = ft_strdup(dst);
	printf("ft_strdup gave us %s\n", dupped);
	char *odupped = strdup(dst);
	printf("strdup gave us %s\n\n", odupped);

	free(dst);
	free(dupped);
	free(odupped);

	t_list **begin_list = malloc(sizeof(*begin_list));
	if (!begin_list) {
		return (1);
	}
	*begin_list = NULL;
	char *n0 = "bonjour";
	char *n1 = "au revoir";
	char *n2 = "Bonjour";
	char *n3 = "au revoir";
	char *n4 = "this was new";
	char *n5 = "data";

	printf("ft_list_size is %d\n", ft_list_size(*begin_list));

	ft_list_push_front(begin_list, n0);
	ft_list_push_front(begin_list, n1);
	ft_list_push_front(begin_list, n2);
	ft_list_push_front(begin_list, n3);
	ft_list_push_front(begin_list, n4);
	ft_list_push_front(begin_list, n5);

	printf("ft_list_size after push_front is %d\n", ft_list_size(*begin_list));
	ft_list_print(*begin_list);
	printf("sorting ... please wait\n");
	ft_list_sort(*begin_list, strcmp);//strcmp);
	ft_list_print(*begin_list);
	printf("removing ... please wait\n");
	char *data_ref = "au revoir";
	ft_list_remove_if(begin_list, data_ref, strcmp, ft_printstr);
	ft_list_print(*begin_list);
	printf("ft_list_size after remove_if is %d\n", ft_list_size(*begin_list));
	//TODO FREE LIST CONTENT
	free(begin_list);

	printf("atoi_base return: %d\n", ft_atoi_base("   \t\t--++++544q45600", "45"));
	return (0);
}
