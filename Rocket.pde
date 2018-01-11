class Rocket {
  Earth earth;        // reference to Earth
  boolean active;     // rocket active
  boolean engine_on;  // engine firing
  boolean orbit_good; // orbit plot is correct
  
  Vector2 location;   // location in Polar coords
  double orientation; // Zenith Angle
  Vector2 velocity;   // velocity in Polar coords
  
  Vector2 Pe;         // Periapsis in Polar coords
  Vector2 Ap;         // Apoapsis in Polar coords
  double e;           // Eccentricity
  double v;           // True anomaly

  // Construct Rocket
  Rocket( Earth e ) {
    // TODO: Variable mass thrust?
    earth = e;
    active = true;
    engine_on = false;
    orbit_good = false;
    Pe = new Vector2();
    Ap = new Vector2();
    
    orientation = Math.PI/2.0; // zenith angle
    location = new Vector2( earth.radius + 400000, 0 );
    double velmag = 7668.55704;
    double vr = velmag * Math.cos( orientation );
    double vo = ( velmag * Math.sin( orientation ) ) / location.r;
    velocity = new Vector2( vr, vo );
  }
  
  // Draw Rocket
  void draw() {
    if ( location.r > earth.radius) { 
      fill( 255, 255, 255 ); noStroke();
      rectMode( CENTER );
      double x = location.r * cos( -(float)location.o );
      double y = location.r * sin( -(float)location.o );
      rect( (float)(x/scale), (float)(y/scale), 4, 4);
      orbit( this );
      compass( orientation );
    } else {
      // TODO: Account for Escape Velocity
      println( "Boom" );
      active = false;
    }
  }
  
  // Calculate next values
  void tick() {
    if ( !active ) { return; }
    // Create Vectors
    Vector2 vel = new Vector2();
    Vector2 pos = new Vector2();
    Vector2 acc = new Vector2();
    Vector2 a_r = thrust();
  
    // Acceleration
    acc.r = r_acc() + a_r.r;
    acc.o = o_acc() + a_r.o;

    // Velocity
    vel.r = velocity.r + deltaT * acc.r;
    vel.o = velocity.o + deltaT * acc.o;
    
    // Position
    pos.r = location.r + deltaT * vel.r;
    pos.o = location.o + deltaT * vel.o;
    
    // Modulo Angles
    if ( pos.o > 2*Math.PI ) { pos.o -= 2*Math.PI; }
    if ( pos.o < -2*Math.PI ) { pos.o += 2*Math.PI; }
    if ( orientation > 2*Math.PI ) { orientation -= 2*Math.PI; }
    if ( orientation < -2*Math.PI ) { orientation += 2*Math.PI; }
    
    // Update
    location = pos;
    velocity = vel;
  }
  
  // Calculate thrust vector
  Vector2 thrust() {
     Vector2 t = new Vector2( 0, 0 );
     if ( engine_on ) {
       double amag = 10; // m/s^s
       t.r = amag * Math.cos( orientation );
       t.o = ( amag * Math.sin( orientation ) ) / location.r;
       orbit_good = false;
     }
     return t;
  }
  
  // Rotate rocket
  void rotate( int dir ) {
    // Processing angles go in opposite direction
    double amount = Math.PI/24;
    if ( dir < 0 ) {
      orientation += amount;
    } else {
      orientation -= amount;
    }
  }

  // Calculate radial acceleration
  double r_acc() {
    double g = -earth.GM() / (location.r * location.r);
    return g + (location.r * velocity.o * velocity.o);
  }
  
  // Calculate angular acceleration
  double o_acc() {
    return (-2.0D * velocity.r * velocity.o) / location.r;
  }
}