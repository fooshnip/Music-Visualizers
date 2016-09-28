import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput lineIn;
FFT         fft;

Cube cubes[] = new Cube[400];
int gridX = 20;
int gridY = 1;
int time;

void settings() {
 size(1200,600,P3D); 
}
void setup() {
  frameRate(20);
  minim = new Minim(this);
  
  lineIn = minim.getLineIn(Minim.STEREO, 2048);
  fft = new FFT(lineIn.bufferSize(), lineIn.sampleRate());
  //fft.logAverages(30, 5);
  
  translate(20,150, 0);
  for(int i = 0;i<cubes.length;i++){
      cubes[i] = new Cube(40,0,20);
  }
  

   time = millis();
}

void draw() {
  background(255);
  lights();
  camera(0, -10, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  
  fft.forward(lineIn.mix);
  translate(20,100, 0);
  for(int i = 0; i<gridX; i++){
    cubes[i].h = fft.getBand(i+1)*2;
    translate(cubes[i].w,0,0);
    translate(0,-cubes[i].h/2,0);
    box(cubes[i].w,cubes[i].h,cubes[i].d);
    translate(0,cubes[i].h/2,0);
  }
  
  translate(-(gridX*40), 0, 21);
  for(int j = 1; j< 20; j++){
    for(int i = 0; i<20; i++){
      translate(cubes[(j*gridX)+i].w,0,0);
      translate(0,-cubes[(j*gridX)+i].h/2,0);
      box(cubes[(j*gridX)+i].w,cubes[(j*gridX)+i].h,cubes[(j*gridX)+i].d);
      translate(0,cubes[(j*gridX)+i].h/2,0);
    }
    translate(-20*40,0,21);
  }
  //delay(50);
    for(int j = 1; j< 4; j++){
        for(int i = 0; i<20; i++){
        cubes[(j*gridX)+i].h = cubes[(j*gridX)+i-20].h;
        }
  }
      for(int j = 4; j< 20; j++){
        for(int i = 0; i<20; i++){
        cubes[(j*gridX)+i].h = cubes[(j*gridX)+i-20].h;
        }
  }

  
}

void delay(int delay)
{
  int time = millis();
  while(millis() - time <= delay);
}