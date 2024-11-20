// Variant 1
// Rudenco Ivan
// FAF-232
// task 3

Creature[] creatures = new Creature[7]; // array to hold 7 creatures

void setup() {
  size(1000, 1000);
  background(30, 30, 50);
  
  // 7 creatures with random positions
  for (int i = 0; i < creatures.length; i++) {
    float x = random(150, width - 150);
    float y = random(150, height - 150);
    creatures[i] = new Creature(x, y);
  }
}

void draw() {
  background(30, 30, 50);
  
  for (Creature creature : creatures) {
    creature.display();
  }
}

// creature class
class Creature {
  float x, y;
  float bodyWidth = 120;
  float bodyHeight = 160;
  float headRadius = 80;
  float eyeOffset = 20;
  float eyeSize = 15;
  float mWidth = 40;
  float mHeight = 20;
  float antennaHeight = 30;

  Creature(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void display() {
    // body
    noStroke();
    fill(150, 10, 201);
    rect(x - bodyWidth / 2, y - bodyHeight / 2, bodyWidth, bodyHeight, 20, 20, 50, 50);
    
    // head
    ellipse(x, y - bodyHeight / 2 - headRadius / 2, headRadius, headRadius);

    // eyes
    fill(0);
    ellipse(x - eyeOffset, y - bodyHeight / 2 - headRadius / 2, eyeSize, eyeSize + 10);
    ellipse(x + eyeOffset, y - bodyHeight / 2 - headRadius / 2, eyeSize, eyeSize + 10);

    // antenna
    fill(150, 10, 201);
    triangle(x, y - bodyHeight / 2 - headRadius - antennaHeight,
             x - 10, y - bodyHeight / 2 - headRadius - 10,
             x + 10, y - bodyHeight / 2 - headRadius - 10);
             
    fill(150, 10, 201);
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
}
