#include <iostream>
#include <string>
#include <cstring>
#include <cstdlib>

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
	std::cout << "strlen('debug') is " << ft_strlen("debug") << std::endl;

	std::string origin = SECRET;
	char *src = &origin[0];
	char *dst = static_cast<char *>(malloc(1000));

	char *cpy = ft_strcpy(dst, src);
	std::cout << "src " << src << ", dst " << dst << ", cpy " << cpy << std::endl;
	cpy = strcpy(dst, TOP);
	std::cout << "src " << src << ", dst " << dst << ", cpy " << cpy << std::endl;
	return (0);
}
