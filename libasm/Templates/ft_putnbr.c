#include "unistd.h"

static void ft_putnbr_loop( long nbr )
{
	if (nbr > 9) {
		ft_putnbr_loop(nbr / 10);
	}
	char c = nbr % 10 + '0';
	write(1, &c, 1);
}

void ft_putnbr( long nbr )
{
	if (nbr < 0) {
		write(1, "-", 1);
		nbr = -nbr; // I don't care about overflow
	}
	ft_putnbr_loop(nbr);
	write(1, "\n", 1);
}

int main( void )
{
	ft_putnbr(-123456);
	ft_putnbr(951357);
	ft_putnbr(0);
	ft_putnbr(10);
	return (0);
}