#include <unistd.h>

ssize_t ft_write( int fd, const void *buf, size_t nbyte )
{
	write(fd, buf, nbyte);
}

int main( void )
{
	return (0);
}
