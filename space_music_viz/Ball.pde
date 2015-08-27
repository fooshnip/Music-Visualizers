class Ball {
  int size;
  float mass;
  PVector acceleration;
  PVector location;
  PVector velocity;
  PImage bball;
  /* @pjs preload="bball.png"; */
 
  Ball(){
    size = 80;
    mass = size;
    velocity = new PVector(random(10,10),0);
    location = new PVector(900,height/2);
    acceleration = new PVector(0,0.1);
    bball = loadImage("bball.png","png");
    bball.resize(size,size);
    //setViewBox(0,0,width,height);
  }
  
  void applyForce(PVector vec){
    PVector f = vec.get();
    f.div(mass);
    acceleration.add(vec);
  }
  
  void display(){
    fill(255,165,0);
    smooth();
    noStroke();
    image(bball,location.x,location.y);
    //ellipse(location.x,location.y,size,size);
    stroke(1);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void checkWalls(){
    if(location.x > (width-size)){
      location.x = width-size;
      velocity.x *= -1.3;
    } else if(location.x < 0){
      location.x = 1;
      velocity.x *= -.6;
    } else if(location.y > (height-size-11)){
      location.y = height-size-11;
      velocity.y *= -.8;
    }
  }
  

}

