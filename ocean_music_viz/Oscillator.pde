class Oscillator  {

  // Using a PVector to track two angles!
  PVector angle;
  PVector velocity;
  PVector amplitude;

  Oscillator()  {
    angle = new PVector();
    //velocity = new PVector(random(-0.05,0.05),random(-0.05,0.05));
    velocity = new PVector(-0.1,0.01);
    //[offset-down] Random velocities and amplitudes
    //amplitude = new PVector(random(width/2),random(height/2));
    amplitude = new PVector(-100,-100);
  }

  void oscillate()  {
    angle.add(velocity);
  }

  void display()  {
    // Oscillating on the x-axis
    float x = sin(angle.x)*amplitude.x;
    // Oscillating on the y-axis
    float y = sin(angle.y)*amplitude.y;

    pushMatrix();
    translate(width/2,height/2);
    stroke(0);
    fill(175);
    // Drawing the Oscillator as a line connecting a circle
    line(0,0,x,y);
    ellipse(x,y,16,16);
    popMatrix();
  }
}