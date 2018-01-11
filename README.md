# Rocket_Sim

![logo](https://github.com/SinclairGurny/Rocket_Sim/blob/master/screenshot5758.png)

## Purpose:

This simulation was made in ~1 week to help me better understand orbital mechanics. It is a stepping stone to more advanced programs I want to work on for other things (Kerbal Space Program). This simulation models the motion of one rocket/satellite in orbit around the Earth. The math is using real values and calculating orbits in realtime. The kinematics is done in polar coordinates. Two sources that helped me: http://www.braeunig.us/space/orbmech.htm, http://evgenii.com/blog/earth-orbit-simulation/. The former was used for all the equations, the latter was only used for the polar coordinate kinematic equations.

## Using the Simulator:

### Controls:

Q - Slow Down Simulation

E - Speed Up Simulation

A - Rotate Rocket CW

D - Rotate Rocket CCW

Z - Zoom In

X - Zoom Out

R - Reset Speed and Scale

P - save screenshot

SPACE - Toggle Engine

### View:

Upper Left - Speed compared to realtime, and Scale of display

Lower Left - 
    Altitude in km above Earth's surface
    Angle in radians clockwise from 3 o'clock position
    Velocity magnitude in meters per second
    Periapsis (low pt in orbit) altitude in km above Earth's surface
    Apoapsis (high pt in orbit) altitude in km above Earth's surface
    True Anomaly Angle of Periapsis point from 3 o'clock position
    Eccentricity of orbit ellipse

Lower Right - 
    Compass showing orientation of rocket
    (Down is toward Earth's center)

Center -
    Earth with satellite orbiting
    
## Future Improvements:

Adding more satellites. Leveraging threading to improve framerate and accuracy. Add orbit perturbations. Ability to launch rockets from ground. Add a rotating Earth or go to 3D. If you have any other ideas, feel free to tell me.
