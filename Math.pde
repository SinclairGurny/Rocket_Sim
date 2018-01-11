// Scientific Notation
double sci( double num, int exp ) {
  if ( exp > 0 ) {
    double x = 1.0D;
    for ( int i = 0; i < exp; ++i ) { x *= 10.0D; }
    return num * x;
  } else if ( exp < 0 ) {
    double x = 1.0D;
    for ( int i = 0; i < -exp; ++i ) { x /= 10.0D; }
    return num * x;
  } else {
    return num;
  }
}

// Truncate
double trunc( double num, int digits ) {
  double f = sci( 1, digits );
  return (double)Math.round( num * f ) / f;
}

// Calculate Orbit Values
void orbit( Rocket r ) {
    if ( !r.orbit_good ) {
      // Temporary variables
      double v1 = r.velocity.mag( r.location.r );
      double gamma = r.velocity.dir( r.location.r );
      double sing = Math.sin( gamma );
      double cosg = Math.sin( gamma );
      // Apoasis and Periapsis
      double C = ( 2.0 * earth.GM() ) / ( r.location.r * v1 * v1 );
      double sq = ( C * C ) + ( 4 * (1-C) * ( sing * sing ));
      double a = ( -C + Math.sqrt( sq ) ) / ( 2 * (1-C) );
      double b = ( -C - Math.sqrt( sq ) ) / ( 2 * (1-C) );
      a = (a*r.location.r);
      b = (b*r.location.r);
      r.Pe.r = Math.min( a, b );
      r.Ap.r = Math.max( a, b );
      //r.Pe.o = r.Ap.o = 0;
      // Eccentricity
      double tmp1 = ( r.location.r * v1 * v1 ) / earth.GM();
      double tmp2 = tmp1 - 1.0;
      //r.e = Math.sqrt( ( (tmp2 * tmp2) * ((cosg * cosg) ) ) + (sing * sing) );
      double vp = ( r.location.r * v1 * sing ) / r.Pe.r;
      r.e = ( r.Pe.r * vp * vp ) / r.earth.GM() - 1.0;
      // True Anomaly
      double tanv = (( tmp1 * sing * cosg ) / ( (tmp1 * sing * sing) - 1 ));
      r.v = -Math.atan( tanv ) + r.location.o + Math.PI/2.0;
      //r.v = -Math.atan( tanv ) + Math.PI/2.0;
      //r.v = -Math.atan( tanv ) + r.location.o;
      r.orbit_good = true;
    }
    Ellipse( r.Pe, r.Ap, r.e, r.v );
  }