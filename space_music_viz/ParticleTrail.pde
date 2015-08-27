public class ParticleTrail {
  private Particle particles[];
  private int count;
  
  public ParticleTrail( int count ) {
    this.count = count;
    particles = new Particle[count];
    for ( int i =0; i < count; i++) {
      particles[i] = new Particle(random(width),height*5, random(2,10));
    }
  }
  
  public void draw() {
    strokeWeight( 1 );
    for ( int i =0; i < count; i++) {
      //stroke( abs(particles[i].z) * 25 );
      strokeWeight(abs(particles[i].z)/2);
      stroke(255,255-abs(particles[i].z)*20,abs(particles[i].z)*20);
      point( particles[i].x, particles[i].y );
    
      particles[i].y -= random(abs(particles[i].z));
      particles[i].x -= particles[i].z*2;
      if (particles[i].x < 0 || particles[i].y < 0) { 
        particles[i] = new Particle( bball.location.x+bball.size/2, bball.location.y+bball.size/2, random(2,10));
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
