// Earth
class Earth {
  double radius;
  
  Earth() {
    radius = 6378140; //m
  }
  
  void draw() {
    fill( 0, 100, 0 );   
    stroke( 0, 100, 0 );
    float img_scale = 1.08;  // fix image size
    float size = img_scale*(float)((2*radius)/scale);
    //ellipse( 0, 0, size/img_scale, size/img_scale );
    image( img, -size/2, -size/2, size, size );
  }
  
  // Gravitational Constant * Mass of Earth
  double GM( ) {
    return sci( 3.986005, 14 ); // m^3 / s^2
  }
  
  // Altitude in km
  double alt( double r ) {
    return (r - radius) / 1000.0;
  }
}

// Display orientation of Rocket
void compass( double angle ) {
  pushMatrix();
  translate( 540, 360 ); // center on lower corner
  translate( -60, -60 ); // move back a bit
  
  fill( 255 );
  ellipse( 0, 0, 60, 60 );
  
  rotate( -(float)angle );
  fill( 0 );
  triangle( 0, 25, 10, -15, -10, -15 );
  popMatrix();
}

// Display Rocket statistics
void output( Rocket a ) {
  int s = 200, o = 18;
  pushMatrix();
  translate( -540, 0 ); fill( 255 );
  double alt = trunc( (a.location.r - a.earth.radius)/1000.0, 4 );
  text( "Alt: " + alt + " km", 10, s+o );
  text( "Angle: " + trunc( a.location.o, 4 ), 10, s+o*2 );
  double vel = trunc( a.velocity.mag( a.location.r ), 2 );
  text( "Vel: " + vel + " m/s", 10, s+o*3 );
  double pe = trunc( (a.Pe.r - a.earth.radius)/1000.0, 4 );
  double ap = trunc( (a.Ap.r - a.earth.radius)/1000.0, 4 );
  text( "Periapsis: " + pe + " km", 10, s+o*4 );
  text( "Apoapsis: " + ap + " km", 10, s+o*5 );
  text( "True Anomaly: " + trunc( a.v, 4 ), 10, s+o*6 );
  text( "Eccentricity: " + trunc( a.e, 6 ), 10, s+o*7 );
  popMatrix();
}

// Display Simulation Statistics
void stats() {
  int s = -350, o = 18;
  pushMatrix();
  translate( -540, 0 ); fill( 255 );
  double speed = (frameRate * tick_per_frame * deltaT);
  text( "Speed: " + trunc( speed, 2 ) + "x", 10, s+o );
  text( "Scale: 1:" + (int)scale, 10, s+o*2 );
  popMatrix();
}