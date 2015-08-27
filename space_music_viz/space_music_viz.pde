
import ddf.minim.*;
import ddf.minim.analysis.*;
import gifAnimation.*;
//import processing.serial.*;
import controlP5.*;

ControlP5 cp5;

String textValue = "";

Minim minim;
Minim minim2;
BeatDetect beat;
BeatListener bl;
AudioInput lineIn;
FFT         fft;
//Serial myPort;

int toggle = 0;

PImage moon; 
/* @pjs preload="moon.png"; */

Ball bball;

float showTime = 5;
float m = -500;
float m2 = 5;

float snareSize;
int moonSize;
int moonHeight;

boolean isDragged;
PVector shotStart = new PVector(0,0);
PVector shotEnd = new PVector(0,0);

ParticleTrail particleTrail;
Starfield starfield;

float randomX;
float polx;
float poly;
float r;

void setup()
{
 frameRate(25);
 //sketchFullScreen();
 size(1400, 800);
 particleTrail = new ParticleTrail( 2500 );
 starfield = new Starfield( 900 );
 smooth();
 
 bball = new Ball();
 //String portName = Serial.list()[2];
 //myPort = new Serial(this, portName, 9600);
 
 cp5 = new ControlP5(this);
 cp5.addTextfield("What are you listening to?")
     .setPosition(20,20)
     .setSize(200,40)
     .setFont(createFont("Helvetica", 20))
     .setFocus(true)
     .setColor(color(255))
     .setText("")
     ;       
 
 minim = new Minim(this);
 minim2 = new Minim(this);
 
 lineIn = minim.getLineIn(Minim.STEREO, 2048);
 beat = new BeatDetect(lineIn.bufferSize(), lineIn.sampleRate());
 fft = new FFT(lineIn.bufferSize(), lineIn.sampleRate());
 fft.logAverages(30, 5);
 
  
 moonSize = 300;
 moonHeight = (int)(moonSize * .75);
 moon = loadImage("moon.png","png");
  moon.resize(moonSize,moonHeight);

 beat.setSensitivity(1);  
 bl = new BeatListener(beat, lineIn); 
 textFont(createFont("Helvetica", 70)); 
 textAlign(CENTER);
 randomX = 200;
}

void draw()
{
 
 background(0);
 fft.forward(lineIn.mix);                                          //Performs the FFT
 if ( beat.isRange(1,5,3)) {
   snareSize=55;
   background(15);
   m = millis();
   //myPort.write('1');
 } else {
   //myPort.write('0');
 }
   image(moon,moonSize*5,-200 + moonSize/2);
  moonSize = (int)constrain(moonSize - 1, -500, 600);
  if(moonSize < -200){
    moonSize = (int)random(300,400);
    moonHeight = (int)(moonSize * 0.75);
    moon.resize(moonSize,moonHeight);
  }
 starfield.draw();
 stroke(0);
 fill(155);
 int numBands = 100;
 float bandHeight = 0.0;
 noFill();
 beginShape();
 if(millis()%0030==0){
   randomX = random(100,300);
 }
 for (int i = 0; i<numBands;i++) {
   //fill(255,255-i*3,i*3);
   float x = i*width/numBands;
   float y = height;
   float x2 = x+width/numBands;
   float y2 = y-fft.getBand(i)*6-10;
   float val = fft.calcAvg(i, i-2);
   int tail = 0;
   int size = (int)constrain(fft.getBand(i)*6+10, 10, height/3);
   if(i<300){
     r = 100;//+y2/6;
     //float polx = r * cos(i*0.05);
     polx = r * cos(randomX/numBands*(i/2));
     poly = r * sin(randomX/numBands*(i/2));
   }

   strokeWeight(3);
   tail = 20;
   if(bball.location.x <= x+tail && bball.location.x + bball.size >= x2-tail){
     if(bball.location.y + bball.size <= y+10 && bball.location.y + bball.size > y-size) {
       m2 = millis();
       fill(55);
       rect(i*width/numBands,height,width/numBands,-size);
       bball.location.y = height-bball.size-size;
       bball.velocity.y *= -1.025;
       bball.velocity.x += 0.1;
       noFill();
     } else {
       fill(55);
       //fill(255,255-i*3,i*3);
       rect(i*width/numBands,height,width/numBands,-size);
       noFill();
     }
   } else {
   strokeWeight(20);
   curveVertex(polx+(bball.location.x+bball.size/2),poly+(bball.location.y+bball.size/2));
   strokeWeight(1);
   //rect(polx+width/22,poly+height/22,0,-size/12);
   stroke(0);
     fill(255,255-i*3,i*3);
     //fill(35);
     //stroke(65);
     rect(i*width/numBands,height,width/numBands,-size);
     noFill();
   }
   stroke(255,255,20,130);
 }
 //curveVertex(width/2,height/2);
 strokeWeight(2);
 //stroke(55);
 endShape();
 strokeWeight(1);
  
  particleTrail.draw();
  fill(155);
  if(bball.location.y+bball.size<0){
    textSize(16);
    text("Distance: " + -round(bball.location.y) + " light years",width/2,20);
  }
  if(bball.location.y<-30000 || bball.location.y > 1500){
    text("It's gone :(", width/2,300);
    bball.velocity.y = 1;
    bball.location.y = height/2;
  }
  //grav
  PVector gravity = new PVector(0,1);
  //friction
  float c = 0.03;
  PVector friction = bball.velocity.get();  
  friction.mult(-1);
  friction.normalize();
  friction.mult(c);
  bball.applyForce(friction);
  bball.applyForce(gravity);
  bball.display();
  bball.update();
  bball.checkWalls();
  //viewbox.track(parent, bball);
  
 fill(155);
 textSize(snareSize);
 text(cp5.get(Textfield.class,"What are you listening to?").getText(), width/2, 200);
 snareSize = constrain(snareSize * 0.99, 50, 70);
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
  bball.location.x = shotEnd.x-bball.size/2;
  bball.location.y = shotEnd.y-bball.size/2;
  bball.velocity.x = shotStart.x - shotEnd.x;
  bball.velocity.y = shotStart.y - shotEnd.y;
  bball.velocity.mult(.2);
}