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
// ssize_t ft_read(int fd, void *buf, size_t nbyte);
// char *ft_strdup(const char *s1);

int main( void )
{
	std::cout << "strlen('debug') is " << ft_strlen("debug") << std::endl;

	std::string origin = SECRET;
	char *src = &origin[0];
	char *dst = static_cast<char *>(malloc(1000));

	char *cpy = ft_strcpy(dst, src);
	std::cout << "src " << src << ", dst " << dst << ", cpy " << cpy << std::endl;
	cpy = strcpy(dst, TOP);
	std::cout << "src " << src << ", dst " << dst << ", cpy " << cpy << std::endl;

	printf("asm cmp = %d\n", ft_strcmp(src, cpy));
	printf("org cmp = %d\n", strcmp(src, cpy));

	ft_write(1, WRITEN, ft_strlen(WRITEN));
	write(1, WRITEN, strlen(WRITEN));
	return (0);
}
