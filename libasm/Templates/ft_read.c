#include <unistd.h>

ssize_t ft_read( int fd, const void *buf, size_t nbyte )
{
	read(fd, buf, nbyte);
}

int main( void )
{
	return (0);
}
