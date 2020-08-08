  gamma(z)

  Compute the gamma function for complex z, defined by

  \Gamma(z)
:=
\begin{cases}
    n!
    & \text{for} \quad z = n+1 \;, n = 0,1,2,\dots
    \\
    \int_0^\infty t^{z-1} {\mathrm e}^{-t} \, {\mathrm d}t
    & \text{for} \quad \Re(z) > 0
\end{cases}

  and by analytic continuation in the whole complex plane.

  External links: DLMF (https://dlmf.nist.gov/5.2.1), Wikipedia
  (https://en.wikipedia.org/wiki/Gamma_function).

  See also: loggamma(z).

  Implementation by
  ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡

    •    Float: C standard math library libm
        (https://en.wikipedia.org/wiki/C_mathematical_functions#libm).

    •    Complex: by exp(loggamma(z)).

    •    BigFloat: C library for multiple-precision floating-point MPFR
        (https://www.mpfr.org/)