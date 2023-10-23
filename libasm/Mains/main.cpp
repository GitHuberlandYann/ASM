#include <iostream>
#include <string>
#include <cstring>
#include <cstdlib>
// #include <sys/types.h>
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

void ft_list_add_front( t_list **lst, t_list *new0 );
void ft_list_push_front( t_list **begin_list, void *data );
int ft_list_size( t_list *begin_list );
void ft_list_sort( t_list *begin_list, int (*cmp)(const char*, const char*) );

int main( void )
{
	std::cout << "strlen('debug') is " << ft_strlen("debug") << std::endl;

	std::string origin = SECRET;
	char *src = &origin[0];
	char *dst = new char[1000];

	char *cpy = ft_strcpy(dst, src);
	std::cout << "src " << src << ", dst " << dst << ", cpy " << cpy << std::endl;
	cpy = strcpy(dst, TOP);
	std::cout << "src " << src << ", dst " << dst << ", cpy " << cpy << std::endl;

	printf("asm cmp = %d\n", ft_strcmp(src, cpy));
	printf("org cmp = %d\n", strcmp(src, cpy));

	ssize_t len = ft_write(1, WRITEN, ft_strlen(WRITEN));
	ssize_t olen = write(1, WRITEN, strlen(WRITEN));
	std::cout << "ft len is " << len << " vs " << olen << std::endl;

	len = ft_read(0, dst, 5);
	if (len >= 0) {
		dst[len] = '\0';
		std::cout << "size " << len << ", buf is " << dst << std::endl;
	} else {
		std::cout << "error on read" << len << std::endl;
	}
	olen = read(0, dst, 10);
	if (olen >= 0) {
		dst[olen] = '\0';
		std::cout << "size " << olen << ", buf is " << dst << std::endl;
	} else {
		std::cout << "error on read" << olen << std::endl;
	}

	char *dupped = ft_strdup(dst);
	std::cout << "ft_strdup gave us " <<  dupped << std::endl;
	char *odupped = strdup(dst);
	std::cout << "strdup gave us " <<  odupped << std::endl;

	delete [] dst;
	delete [] dupped;
	delete [] odupped;

	t_list *head, rhead, body0, body1, tail;
	rhead.data = (void*)"bonjour";
	body0.data = (void*)"au revoir";
	body1.data = (void*)"Bonjour";
	tail.data = (void*)"au bonjour";
	head = &rhead;
	head->next = &body0;
	body0.next = &body1;
	body1.next = &tail;
	tail.next = NULL;

	std::cout << "ft_list_size is " << ft_list_size(head) << std::endl;
	t_list new0;
	new0.data = (void*)"this was new";
	new0.next = NULL;
	void *data = (void*)"data";
	ft_list_add_front(&head, &new0);
	printf("ft_list_size after add_front is %d\n", ft_list_size(head));
	ft_list_push_front(&head, data);
	printf("ft_list_size after push_front is %d\n", ft_list_size(head));
	t_list *tmp = head;
	int index = 0;
	while (tmp) {
		printf("at index %d: %s\n", index, (char *)(tmp->data));
		++index;
		tmp = tmp->next;
	}
	printf("sorting ... please wait\n");
	ft_list_sort(head, strcmp);//strcmp);
	tmp = head;
	index = 0;
	while (tmp) {
		printf("at index %d: %s\n", index, (char *)(tmp->data));
		++index;
		tmp = tmp->next;
	}
	delete head;
	return (0);
}
