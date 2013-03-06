#!/usr/bin/perl

use Modern::Perl;
use List::Util qw( min );

sub rgb2cmyk {
    my ($red, $green, $blue) = @_;
    my ($cyan, $magenta, $yellow);

    my $black = min ( 1-$red, 1-$green, 1-$blue );
    my $nb = 1 - $black;  # negative black

    if($black == 1){
        $cyan    = 0; 
        $magenta = 0; 
        $yellow  = 0;
    } elsif ($nb > 0){
        $cyan    = ( $nb - $red   ) / $nb;
        $magenta = ( $nb - $green ) / $nb;
        $yellow  = ( $nb - $blue  ) / $nb;
    } else {
        $cyan    = 1 - $red;
        $magenta = 1 - $green;
        $yellow  = 1 - $blue;
    }

    return sprintf("%.1f  %.1f  %.1f  %.1f", $cyan, $magenta, $yellow, $black );
}

say "Preto:\t\t\t",       rgb2cmyk( 0.0, 0.0, 0.0 );
say "Cinza escuro:\t\t",  rgb2cmyk( 0.3, 0.3, 0.3 );
say "Cinza médio:\t\t",   rgb2cmyk( 0.5, 0.5, 0.5 );
say "Cinza claro:\t\t",   rgb2cmyk( 0.7, 0.7, 0.7 );
say "Branco:\t\t\t",      rgb2cmyk( 1.0, 1.0, 1.0 );
say "Vermelho vivo:\t\t", rgb2cmyk( 1.0, 0.0, 0.0 );
say "Vermelho sangue:\t", rgb2cmyk( 0.7, 0.0, 0.0 );
say "Laranja:\t\t",       rgb2cmyk( 1.0, 0.5, 0.0 );
say "Verde Musgo:\t\t",   rgb2cmyk( 0.6, 0.7, 0.6 );

__END__

=pod

=encoding utf8

=head1 RGB to CMYK

=head2 Descrição

Converte uma cor definida em RGB para CMYK.

RGB é um sistema aditivo de definição de cores, representa a mistura de luz. Suas componentes são (em ordem) vermelho, verde e azul.
CMYK é um sistema subtrativo de definição de cores, representa a mistura de pigmentos. Suas componentes são (em ordem) ciano, magenta, amarelo e preto. O preto no CMYK deriva uma necessidade do uso prático, já que a mistura dos 3 pigmentos é custoso, não é realmente preto e a sobreposição de impressões tornaria o desalinhamento mais perceptível nos detalhes escuros.
O algorítimo deste exemplo considera as componentes como valores flutuantes entre 0 e 1, onde 0 significa sem representação e 1 máxima representação. Sendo assim o branco seria (1,1,1) em RGB e (0,0,0,0) em CMYK, o vermelho intenso seria (1,0,0) em RGB e (0,1,1,0) em CMYK e o laranja seria (1,0.5,0) em RGB e (0,0.5,1,0) em CMYK. A representação das componentes em valores flutuantes entre 0 e 1 pode parecer estranho pelo nosso costume em ver cores definidas com 1 byte por unidade, mas essa representação é bastante útil em vários algorítimos para manipulação de cores e ainda viabiliza representações com maior profundidades de cores (mais de 1 byte por componente).

=head2 Tipo

color

=head2 Complexidade

O(1)

=head2 Dificuldade

facil

=head2 Referências

L<http://en.wikipedia.org/wiki/RGB>
L<http://en.wikipedia.org/wiki/CMYK>

=cut
