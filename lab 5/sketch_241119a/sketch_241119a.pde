Insect[] insects;
int numInsects = 10;
int maxDepth = 3;

void setup() {
  size(1600, 1000);
  insects = new Insect[numInsects];
  
  // init each insect
  for (int i = 0; i < numInsects; i++) {
    float startX = random(width);
    float startY = random(height);
    float initialSpeed = random(1, 5);
    
    insects[i] = new Insect(startX, startY, initialSpeed);
  }
}

void draw() {
  background(200, 230, 255);
  
  // update and display each insect
  for (int i = 0; i < insects.length; i++) {
    insects[i].update();
    insects[i].display();
  }
}

class Insect {
  float x, y; //pos 
  float angle; //movement angle
  float speed;
  float baseSpeed; // speed for oscillation
  float offset; // curved movement
  float targetAngle;
  float oscillationOffset; // orbiting circles
  int numCircles;

  // constructor
  Insect(float startX, float startY, float initialSpeed) {
    x = startX;
    y = startY;
    baseSpeed = initialSpeed;
    speed = initialSpeed;
    offset = random(TWO_PI);
    targetAngle = random(TWO_PI);
    angle = targetAngle;
    oscillationOffset = 0;
    numCircles = int(random(1, 6));
  }

  void update() {
    // smooth rotation
    offset += 0.02;
    float curve = sin(offset) * 0.5;

    targetAngle += curve * 0.05; 
    angle = lerp(angle, targetAngle, 0.05);

    x += cos(angle) * speed;
    y += sin(angle) * speed;

    speed = baseSpeed + sin(frameCount * 0.02 + offset) * 1.5;

    // oscillation grows with speed
    oscillationOffset += speed * 0.02;

    // keep on screen
    if (x < 0 || x > width || y < 0 || y > height) {
      targetAngle = atan2(height / 2 - y, width / 2 - x);
    }
  }

  void display() {
    // circles
    for (int i = 0; i < numCircles; i++) {
      float angleAround = oscillationOffset + TWO_PI / numCircles * i;
      float circleX = x + cos(angleAround) * 200;
      float circleY = y + sin(angleAround) * 50;

      fill(255, 150, 150, 200);
      noStroke();
      ellipse(circleX, circleY, 20, 20);
    }

    // fractal body
    pushMatrix();
    translate(x, y);
    rotate(angle);

    drawFractal(100, 0, maxDepth, frameCount * 0.01);

    popMatrix();
  }

  // recursive fractal
  void drawFractal(float len, int depth, int maxDepth, float angleOffset) {
    if (depth > maxDepth) return;

    
    strokeWeight(1);
    noFill();
    ellipse(0, 0, len, len);

    for (int i = 0; i < 4; i++) { // number of branches
      stroke(50, 150, 50);
      pushMatrix();
      float branchAngle = angleOffset + i * TWO_PI / 4;
      float x = cos(branchAngle) * len / 2;
      float y = sin(branchAngle) * len / 2;
      translate(x, y);
      rotate(branchAngle );
      drawFractal(len * 0.5, depth + 1, maxDepth, angleOffset);
      popMatrix();
    }
  }
}
