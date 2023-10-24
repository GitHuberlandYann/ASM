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

int ft_atoi_base( const char *str, const char *base );
void ft_list_add_front( t_list **lst, t_list *new0 );
void ft_list_push_front( t_list **begin_list, const void *data );
int ft_list_size( t_list *begin_list );
void ft_list_sort( t_list *begin_list, int (*cmp)(const char*, const char*) );
void ft_list_remove_if( t_list **begin_list, const void *data_ref, int (*cmp)(const char*, const char*), void (*free_fct)(void *) );

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

	t_list **begin_list = new t_list*;
	if (!begin_list) {
		return (1);
	}
	*begin_list = NULL;
	std::string n0 = "Bonjour";
	std::string n1 = "au revoir";
	std::string n2 = "Bonjour";
	std::string n3 = "au revoir";
	std::string n4 = "this was new";
	std::string n5 = "data";

	printf("ft_list_size is %d\n", ft_list_size(*begin_list));

	ft_list_push_front(begin_list, n0.c_str());
	ft_list_push_front(begin_list, n1.c_str());
	ft_list_push_front(begin_list, n2.c_str());
	ft_list_push_front(begin_list, n3.c_str());
	ft_list_push_front(begin_list, n4.c_str());
	ft_list_push_front(begin_list, n5.c_str());

	printf("ft_list_size after push_front is %d\n", ft_list_size(*begin_list));
	ft_list_print(*begin_list);
	printf("sorting ... please wait\n");
	ft_list_sort(*begin_list, strcmp);//strcmp);
	ft_list_print(*begin_list);
	printf("removing ... please wait\n");
	std::string data_ref = "au revoir";
	ft_list_remove_if(begin_list, data_ref.c_str(), strcmp, ft_printstr);
	data_ref = "nonsense";
	ft_list_remove_if(begin_list, data_ref.c_str(), strcmp, ft_printstr);
	data_ref = "Bonjour";
	ft_list_remove_if(begin_list, data_ref.c_str(), strcmp, ft_printstr);
	data_ref = "data";
	ft_list_remove_if(begin_list, data_ref.c_str(), strcmp, ft_printstr);
	data_ref = "this was new";
	ft_list_remove_if(begin_list, data_ref.c_str(), strcmp, ft_printstr);
	ft_list_print(*begin_list);
	printf("ft_list_size after remove_if is %d\n", ft_list_size(*begin_list));
	delete begin_list;

	std::string str = "   \t\t--++++544q45600";
	std::string base = "45";
	printf("atoi_base return: %d\n", ft_atoi_base(str.c_str(), base.c_str()));
	return (0);
}
