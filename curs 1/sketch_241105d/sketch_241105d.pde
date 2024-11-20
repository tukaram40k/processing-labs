// from video 3.2

float r = 250;
float a = 0.0;
float aVel = 0.0;
float aAcc = 0.001;

void setup() {
  size(1000, 800);
  smooth();
}

void draw() {
  background(255);
  
  translate(width/2,height/2);
  float x = r * cos(a);
  float y = r * sin(a);
  fill(#BA18DB);
  stroke(0);
  line(0,0,x,y);
  ellipse(x,y,50,50);
  
  a+=aVel;
  aVel+=aAcc;
  aVel = constrain(aVel,0,0.1);
}
