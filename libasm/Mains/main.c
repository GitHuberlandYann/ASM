#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SECRET "top secret information"
#define TOP "secret top information"

size_t ft_strlen( const char *s );
char *ft_strcpy( char *dst, const char *src );
// int ft_strcmp(const char *s1, const char *s2);
// ssize_t ft_write(int fd, const void *buf, size_t nbyte);
// ssize_t ft_read(int fd, void *buf, size_t nbyte);
// char *ft_strdup(const char *s1);

int main( void )
{
	printf("strlen('test') is %ld\n", ft_strlen("test"));

	char *src = SECRET;
	char *dst = malloc(1000);

	char *cpy = ft_strcpy(dst, src);
	printf("src %s, dst %s, cpy %s\n", src, dst, cpy);
	cpy = strcpy(dst, TOP);
	printf("src %s, dst %s, cpy %s\n", TOP, dst, cpy);
	return (0);
}
