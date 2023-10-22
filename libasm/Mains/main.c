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

void ft_list_add_front( t_list **lst, t_list *new );
int ft_list_size( t_list *begin_list );
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
	printf("strlen('test') is %ld\n", ft_strlen("test"));

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
	printf("strdup gave us %s\n", odupped);

	free(dst);
	free(dupped);
	free(odupped);

	t_list *head, rhead, body0, body1, tail;
	head = &rhead;
	head->next = &body0;
	body0.next = &body1;
	body1.next = &tail;
	tail.next = NULL;

	printf("ft_list_size is %d\n", ft_list_size(head));
	t_list new, new1;
	new.next = NULL;
	new1.next = NULL;
	ft_list_add_front(&head, &new);
	printf("ft_list_size after add_front is %d\n", ft_list_size(head));
	ft_list_push_front(&head, &new1);
	printf("ft_list_size after push_front is %d\n", ft_list_size(head));
	return (0);
}
