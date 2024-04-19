syntax match       myGoFormatSpecifier   /\
    \%([^%]\%(%%\)*\)\
    \@<=%[-#0 +]*\
    \%(\%(\%(\[\d\+\]\)\=\*\)\|\d\+\)\=\
    \%(\.\%(\%(\%(\[\d\+\]\)\=\*\)\|\d\+\)\=\)\=\
    \%(\[\d\+\]\)\=[vTtbcdoqxXUeEfFgGspw]/ contained containedin=goString,goRawString

