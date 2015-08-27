public class Starfield {
  private Star stars[];
  private int count;
  
  public Starfield( int count ) {
    this.count = count;
    stars = new Star[count];
    for ( int i =0; i < count; i++) {
      stars[i] = new Star( random(width), random(height), random(0.1,3));
    }
  }
  
  public void draw() {
    for ( int i =0; i < count; i++) {
      stroke( abs(stars[i].z) * 35 );
      strokeWeight(abs(stars[i].z));
      //stroke(255,255-(i/5),i/5);
      point( stars[i].x, stars[i].y );
    
      //stars[i].y -= random(abs(stars[i].z));
      stars[i].x -= stars[i].z;
      if (stars[i].x < 0 || stars[i].x > width) { 
        stars[i] = new Star( width, random(height), random(0.1,3));
      }
    }
    strokeWeight( 1 );
  }
}

class Star {
  float x, y, z;
  Star( float x, float y, float z ) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}
