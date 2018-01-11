// Polar coordinate Vector
class Vector2 {
  double r; // radius
  double o; // theta

  Vector2() { r=0L; o=0.0D; }

  Vector2( double a, double b ) {
    r = a; o = b;
  }

  void rotate( double angle ) {
    double cs = Math.cos( angle );
    double sn = Math.sin( angle );

    double a = r * cs - o * sn;
    double b = r * sn + o * cs;

    r = a; 
    o = b;
  }

  // Magnitude
  double mag( double d ) {
    return Math.sqrt( r*r + (o*d)*(o*d) );
  }

  // Direction
  double dir( double d ) {
    return Math.atan( (o*d) / r );
  }
}

// Orbit Ellipse
void Ellipse( Vector2 Pe, Vector2 Ap, double e, double v ) {
  noFill(); stroke( 200 );
  pushMatrix();
  rotate( (float) -v );
  double a = (Pe.r + Ap.r) / 2.0;
  double c = e * a;
  double b = a * Math.sqrt( 1 - (e*e) );

  //ellipse( (float)f1.r, (float)f1.o, (float)(2.0*Ap.r/scale), (float)(2.0*Ap/scale) );
  //ellipse( 0, 0, (float)(2.0*Pe.r/scale), (float)(2.0*Pe.r/scale) );
  //ellipse( 0, 0, (float)(2.0*Ap.r/scale), (float)(2.0*Ap.r/scale) );
  int r = round( (float)(-c/scale) );
  int major = round( (float)(2.0*a/scale) );
  int minor = round( (float)(2.0*b/scale) );
  ellipse( r, 0, major, minor );
  popMatrix();
}