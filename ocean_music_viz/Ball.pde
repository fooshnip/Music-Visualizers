class Ball {
  int size;
  float mass;
  PVector acceleration;
  PVector location;
  PVector velocity;
  PVector hitbox;
  PImage bball;
  /* @pjs preload="bball.png"; */
 
  Ball(){
    size = 80;
    mass = size;
    velocity = new PVector(random(10,10),0);
    location = new PVector(900,height/2);
    hitbox = location;
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
    //rect(hitbox.x,hitbox.y,size,size);

    image(bball,location.x,location.y);
    //ellipse(location.x,location.y,size,size);
    stroke(1);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    hitbox = location;
  }
  
  void checkWalls(){
    if(location.x > (width-size)){
      location.x = width-size;
      velocity.x *= -.6;
    } else if(location.x < 0){
      location.x = 1;
      velocity.x *= -.6;
    } else if(location.y > (435-size)){
      //location.y = 433-size;
      velocity.y = 0;
      velocity.x *= 0.5;
      if(counter > topScore){
        topScore = counter;
      }
      counter = 0;
    } else if(location.y < 0){
        noStroke();
        fill(-location.y/10+100);
        rect(location.x,10,size,5);
    }
  }
  

}