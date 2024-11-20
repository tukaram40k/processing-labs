// Variant 1
// Rudenco Ivan
// FAF-232
// task 1 and 2

// global variables for alien position
float bodyX, bodyY;
float bodyWidth = 120;
float bodyHeight = 160;
float speed = 2;
int direction = 0;

void setup() { 
  size(1000, 1000);
  background(30, 30, 50);
  noStroke();
  
  // initialize position
  bodyX = width - bodyWidth / 2;
  bodyY = bodyHeight / 2;
}

void draw() {
  background(30, 30, 50);
  
  // move the alien based on direction
  if (direction == 0) {
    bodyY += speed;
    if (bodyY >= height - bodyHeight / 2) direction = 1;
  } else if (direction == 1) {
    bodyX -= speed;
    if (bodyX <= bodyWidth / 2) direction = 2;
  } else if (direction == 2) {
    bodyX = width - bodyWidth / 2;
    bodyY = bodyHeight / 2;
    if (bodyY <= bodyHeight / 2) direction = 0; // go back to start
  }
  
  drawAlien(bodyX, bodyY);
}

void drawAlien(float x, float y) {
  // body
  fill(150, 10, 201);
  rect(x - bodyWidth / 2, y - bodyHeight / 2, bodyWidth, bodyHeight, 20, 20, 50, 50);
  
  // head
  float headRadius = 80;
  ellipse(x, y - bodyHeight / 2 - headRadius / 2, headRadius, headRadius);

  // eyes
  fill(0);
  float eyeOffset = 20;
  float eyeSize = 15;
  ellipse(x - eyeOffset, y - bodyHeight / 2 - headRadius / 2, eyeSize, eyeSize + 10);
  ellipse(x + eyeOffset, y - bodyHeight / 2 - headRadius / 2, eyeSize, eyeSize + 10);

  // antenna
  fill(150, 10, 201);
  float antennaHeight = 30;
  triangle(x, y - bodyHeight / 2 - headRadius - antennaHeight,
           x - 10, y - bodyHeight / 2 - headRadius - 10,
           x + 10, y - bodyHeight / 2 - headRadius - 10);
           
  fill(150, 10, 201);
  float mWidth = 40;
  float mHeight = 20;
  arc(x, y - bodyHeight / 2 - headRadius * 1.25, mWidth, mHeight, 0, PI);
  
  // cool things around the head
  fill(100, 200, 255, 150);
  float angle = 0;
  float radius = headRadius + 20;
  while (angle < TWO_PI) {
    float hx = x + cos(angle) * radius;
    float hy = (y - bodyHeight / 2 - headRadius / 2) + sin(angle) * radius;
    ellipse(hx, hy, 10, 10);
    angle += PI / 6;
  }
}
