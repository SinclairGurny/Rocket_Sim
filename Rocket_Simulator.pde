// Rocket Simulator
// by Sinclair Gurny
// Jan 2018

double scale = 20000;    // Resolution scaling     
double deltaT = 0.005;   // time step per tick
int tick_per_frame = 10; // ticks per frame

Earth earth = new Earth();
Rocket rocket = new Rocket( earth );
PImage img;

void setup() {
  size( 1080, 720 );
  frameRate( 20 );
  background( 0 );
  PFont font = createFont( "Times New Roman", 16, true );
  textFont( font );
  img = loadImage( "Earth.png" );
}

void draw() {
  long time = millis();
  translate( 540, 360 ); // center on center of screen
  background(0);         // space is the eternal void

  for ( int i = 0; i < tick_per_frame; ++i ) {
    rocket.tick();
  }

  earth.draw();
  rocket.draw();
  
  output( rocket );
  stats();
  //println( " ===> " + ( millis() - time ) );
}

void keyPressed() {
  // Toggle Engine
  if ( key == ' ' ) {
    rocket.engine_on = !rocket.engine_on;
  }
  // Reset screen
  if ( key == 'r' ) {
    scale = 20000;
    deltaT = 0.005;
    tick_per_frame = 10;
  }
  // Simulation Speed
  if ( key == 'q' ) { //-
    if ( deltaT > 0 ) {
      deltaT -= 0.0025;
    }
  } else if ( key == 'e' ) { //+
    deltaT += 0.0025;
  }
  // Scale
  if ( key == 'z' ) {//in
    if ( scale > 10000 ) {
      scale -= 2500;
    }
  } else if ( key == 'x' ) {//out
    scale += 2500;
  }
  // Rocket Rotation
  if ( key == 'a' ) {//cw
    rocket.rotate( -1 );
  } else if ( key == 'd' ) {//ccw
    rocket.rotate( 1 );
  }
  
  if ( key == 'p' ) {
    save( "screenshot"+millis()+".png" );
  }
}