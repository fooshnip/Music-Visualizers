public class ParticleTrail {
  private Particle particles[];
  private int count;
  private float locX;
  private float locY;
  
  public ParticleTrail( int count, float wid ) {
    this.count = count;
    particles = new Particle[count];
    locX = wid;
    locY = height;
    for ( int i =0; i < count; i++) {
      particles[i] = new Particle(locX, locY, random(2,10));
    }
    
  }
  
  public void draw() {
    strokeWeight( 1 );
    for ( int i =0; i < count; i++) {
      stroke(abs(particles[i].z)*20,particles[i].y-500);
      noFill();
      ellipse( particles[i].x, particles[i].y, particles[i].z, particles[i].z);
    
      particles[i].y -= random(abs(particles[i].z)*0.1);
      particles[i].x -= 0;
      particles[i].z += particles[i].y/10000;
      
      if (particles[i].y < 500) { 
        for ( int j =0; j < count; j++) {
          particles[j] = new Particle(locX, locY, random(2,10));
        }
      //  particles[i].x = locX;
      //  particles[i].y = locY;
      //  particles[i].z = 0;
      }
    }
  }
}

class Particle {
  float x, y, z;
  Particle( float x, float y, float z ) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}