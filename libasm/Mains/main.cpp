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

size_t ft_list_size( t_list *lst );

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

	len = ft_read(0, dst, 300);
	if (len >= 0) {
		dst[len] = '\0';
		std::cout << "size " << len << ", buf is " << dst << std::endl;
	} else {
		std::cout << "error on read" << std::endl;
	}
	olen = read(0, dst, 300);
	if (olen >= 0) {
		dst[olen] = '\0';
		std::cout << "size " << olen << ", buf is " << dst << std::endl;
	} else {
		std::cout << "error on read" << std::endl;
	}

	char *dupped = ft_strdup(dst);
	std::cout << "ft_strdup gave us " <<  dupped << std::endl;
	char *odupped = strdup(dst);
	std::cout << "strdup gave us " <<  odupped << std::endl;

	delete [] dst;
	delete [] dupped;
	delete [] odupped;

	t_list head, body0, body1, tail;
	head.next = &body0;
	body0.next = &body1;
	body1.next = &tail;
	tail.next = NULL;

	std::cout << "ft_list_size is " << ft_list_size(&head) << std::endl;
	return (0);
}
