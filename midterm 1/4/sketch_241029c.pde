// Variant 1
// Rudenco Ivan
// FAF-232
// task 4

Creature[] creatures = new Creature[10]; // array to hold 10 creatures

void setup() {
  size(1500, 1500);
  background(30, 30, 50);
  
  // 10 creatures with random positions and velocities
  for (int i = 0; i < creatures.length; i++) {
    float x = random(150, width - 150);
    float y = random(150, height - 150);
    creatures[i] = new Creature(x, y);
  }
}

void draw() {
  background(30, 30, 50);
  
  for (Creature creature : creatures) {
    creature.update();
    creature.display();
  }
}

// creature class
class Creature {
  PVector location;       // position
  PVector velocity;       // speed and direction
  PVector acceleration;   // acceleration
  float rotationAngle;    // rotation angle
  float rotationSpeed;    // rotation speed
  
  float bodyWidth = 120;
  float bodyHeight = 160;
  float headRadius = 80;
  float eyeOffset = 20;
  float eyeSize = 15;
  float mWidth = 40;
  float mHeight = 20;
  float antennaHeight = 30;

  Creature(float x, float y) {
    location = new PVector(x, y);
    velocity = PVector.random2D().mult(2); 
    acceleration = new PVector(0.01, 0.01);
    rotationAngle = random(TWO_PI);
    rotationSpeed = random(-0.05, 0.05);
  }
  
  void update() {
    velocity.add(acceleration); 
    location.add(velocity); 
    rotationAngle += rotationSpeed;

    // check for boundaries
    if (location.x < bodyWidth / 2 || location.x > width - bodyWidth / 2) {
      velocity.x *= -1;
    }
    if (location.y < bodyHeight / 2 || location.y > height - bodyHeight / 2) {
      velocity.y *= -1;
    }
  }
  
  void display() {
    // use pushmatrix for rotation
    pushMatrix();              
    translate(location.x, location.y);  
    rotate(rotationAngle);
    
    // body
    noStroke();
    fill(150, 10, 201);
    rect(-bodyWidth / 2, -bodyHeight / 2, bodyWidth, bodyHeight, 20, 20, 50, 50);
    
    // head
    ellipse(0, -bodyHeight / 2 - headRadius / 2, headRadius, headRadius);

    // eyes
    fill(0);
    ellipse(-eyeOffset, -bodyHeight / 2 - headRadius / 2, eyeSize, eyeSize + 10);
    ellipse(eyeOffset, -bodyHeight / 2 - headRadius / 2, eyeSize, eyeSize + 10);

    fill(255, 0, 0);
    arc(0, -bodyHeight / 2 - headRadius * 1.25, mWidth, mHeight, 0, PI);

    // antenna
    fill(150, 10, 201);
    triangle(0, -bodyHeight / 2 - headRadius - antennaHeight,
             -10, -bodyHeight / 2 - headRadius - 10,
             10, -bodyHeight / 2 - headRadius - 10);
             
    fill(150, 10, 201);
    arc(0, -bodyHeight / 2 - headRadius * 1.25, mWidth, mHeight, 0, PI);
    
    // cool things around the head
    fill(100, 200, 255, 150);
    float angle = 0;
    float radius = headRadius + 20;
    while (angle < TWO_PI) {
      float hx = cos(angle) * radius;
      float hy = -bodyHeight / 2 - headRadius / 2 + sin(angle) * radius;
      ellipse(hx, hy, 10, 10);
      angle += PI / 6;
    }
    
    popMatrix();
  }
}
