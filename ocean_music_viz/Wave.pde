class Wave {
  
  float startAngle;
  float angleVel;
  float angle;
  float ht;
  float ad;
  
  Wave(int x){
    startAngle = 0;
    angleVel = 0.03;
    //angleVel = random(0.01,0.2);
    //ht = random(3,6);
    ad = 0.53;
    ht = x+ad;
  }
  
  void display(){
  strokeWeight(5);
    //[full] In order to move the wave, we start at a different theta value each frame.  
  startAngle += 0.02;
  angle = startAngle;
  //[end]
  
  
  beginShape();
  curveVertex(0,map(sin(angle)+2*cos(angle),-1,1,427,(ht)+427));
  for (int x = 0; x <= width; x+=width/100) {
    float y = map(sin(angle)+2*cos(angle),-1,1,427,(ht)+427);
    curveVertex(x,y);
    //ellipse(x,y,10,10);
    angle += angleVel;
    if(bball.location.y > 430-bball.size){
      if(bball.location.x + bball.size/2 <= x && bball.location.x + bball.size/2 >= x - width/100){
      bball.location.y = y-77;
      }
    }
  }
  curveVertex(width, map(sin(angle)+2*cos(angle),-1,1,427,(ht)+427));
  //strokeWeight(3);
  stroke(ht*20,ht/5*555,240,25);
  noFill();
  endShape();
  
  }
}