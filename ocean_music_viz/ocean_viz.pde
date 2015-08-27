import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
BeatDetect beat;
BeatListener bl;
AudioInput lineIn;
FFT         fft;

int counter;
int topScore;

PImage sky;
/* @pjs preload="water2.jpg"; */
PImage water;
/* @pjs preload="fishies.jpg"; */

Ball bball;
boolean isDragged;
PVector shotStart = new PVector(0,0);
PVector shotEnd = new PVector(0,0);

int numBands = 100;
Wave waves[] = new Wave[20];
//ParticleTrail pt[] = new ParticleTrail[numBands];

void setup() {
  size(1200,600);
  counter = 0;
  topScore = 0;
  for(int i=0;i<waves.length;i++){
    waves[i] = new Wave(i);
  }
  
  minim = new Minim(this);
 
  bball = new Ball();
 
 lineIn = minim.getLineIn(Minim.STEREO, 2048);
 beat = new BeatDetect(lineIn.bufferSize(), lineIn.sampleRate());
 fft = new FFT(lineIn.bufferSize(), lineIn.sampleRate());
 fft.logAverages(30, 5);
 
 beat.setSensitivity(1);  
 bl = new BeatListener(beat, lineIn); 
 
 sky = loadImage("water2.jpg");
 sky.resize(1600,800);

 
  //for(int i=0;i<pt.length;i++){
  // float x = i*width/numBands+(width/numBands/2);
  // pt[i] = new ParticleTrail( 10, x);
  //}
 
}

void draw() {
  background(100,200,235);
  //image(sky,-200,-100);
  fft.forward(lineIn.mix);
  
  image(sky,-200,0);
  //image(water,0,450);
  
  
  for(int i=0;i<waves.length;i++){
    smooth();
    waves[i].display();
  }
  
      //grav
  PVector gravity = new PVector(0,0.2);
  PVector wind = new PVector(random(-1,1),random(-1,1));
  //friction
  float c = 0.01;
  PVector friction = bball.velocity.get();  
  friction.mult(-1);
  friction.normalize();
  friction.mult(c);
  bball.applyForce(friction);
  bball.applyForce(gravity);
  bball.applyForce(wind);
  bball.display();
  bball.update();
  bball.checkWalls();
  
  
  for (int i = 0; i<numBands;i++) {
   fill(255-i*2,i*3,255-i*3,90);
   stroke(255);
   strokeWeight(1);
   float x = i*width/numBands;
   float y = height;
   float x2 = x+width/numBands;
   float y2 = y-fft.getBand(i)*6-10;
   float val = fft.calcAvg(i, i-2);
   int size = (int)constrain(fft.getBand(i)*15+10, 10, height/5);
   rect(i*width/numBands,height,width/numBands,-size);
   //pt[i].draw();
   
  }
  
  if (mouseX >= bball.hitbox.x-5 && mouseX <= bball.hitbox.x + bball.size+5){
    if (mouseY >= bball.hitbox.y-5 && mouseY <= bball.hitbox.y + bball.size+5){
      //bball.location.x += mouseX-bball.hitbox.x+bball.size/2;
      bball.location.y = mouseY-bball.size-6;
      if(mouseX<(bball.hitbox.x+bball.size/2)){
        bball.velocity.x = ((bball.hitbox.x+bball.size/2)-mouseX);      
      } else if(mouseX>(bball.hitbox.x+bball.size/2))  {
        bball.velocity.x = ((bball.hitbox.x+bball.size/2)-mouseX);
      } 
      if(mouseY>(bball.hitbox.y+bball.size/10)){
        bball.velocity.y *= -1.3;      
      } 
      bball.velocity.x *= 0.1;
      counter++;
    }
  }
  
  fill(255);
  text("Beach ball hits: " + counter, 50, 50);
  text("Top Score: " + topScore, 50, 30);
  text("Winds variable", 50, 70);
}

void mousePressed(){
  shotStart = new PVector(mouseX,mouseY);
}

void mouseDragged(){
  smooth();
  noStroke();
  fill(255,165,0);
  PImage bball;
  int size = 50;
  bball = loadImage("bball.png","png");
    bball.resize(size,size);
  float mx = mouseX;
  float my = mouseY;
  image(bball,mx-size/2,my-size/2);
  stroke(1);
  smooth();
  fill(0);
  line(shotStart.x,shotStart.y,mouseX,mouseY);
}

void mouseReleased(){
  shotEnd = new PVector(mouseX,mouseY);
  bball.location.x = shotEnd.x-bball.size;
  bball.location.y = shotEnd.y-bball.size;
  bball.velocity.x = shotStart.x - shotEnd.x;
  bball.velocity.y = shotStart.y - shotEnd.y;
  bball.velocity.mult(.1);
  counter = 0;
}