#include <iostream>
#include <stdlib.h>

extern size_t ft_strlen( const char *s );
// int ft_strcmp(const char *s1, const char *s2);
// char *ft_strcpy(char *dst, const char *src);
// ssize_t ft_write(int fd, const void *buf, size_t nbyte);
// ssize_t ft_read(int fd, void *buf, size_t nbyte);
// char *ft_strdup(const char *s1);

int main( void )
{
	std::cout << "strlen('debug') is " << ft_strlen("debug") << std::endl;
	return (0);
}
