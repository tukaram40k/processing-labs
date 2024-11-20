// from video 3.4

class Pendulum  {

  PVector position;    
  PVector origin;
  float r;
  float angle;
  float aVelocity;
  float aAcceleration;
  float damping;

  Pendulum(PVector origin_, float r_) {
    origin = origin_.get();
    position = new PVector();
    r = r_;
    angle = PI/4;

    aVelocity = 0.0;
    aAcceleration = 0.0;
    damping = 0.995;
  }

  void go() {
    update();
    display();
  }

  void update() {
    float gravity = 0.4;
    aAcceleration = (-1 * gravity / r) * sin(angle);
    aVelocity += aAcceleration;
    aVelocity *= damping;
    angle += aVelocity;
  }

  void display() {
    position.set(r*sin(angle), r*cos(angle), 0);
    position.add(origin);

    stroke(0);
    strokeWeight(2);
    line(origin.x, origin.y, position.x, position.y);
    ellipseMode(CENTER);
    fill(#BA18DB);
    ellipse(position.x, position.y, 48, 48);
  }

}

Pendulum p;

void setup() {
  size(640,360);
  p = new Pendulum(new PVector(width/2,0),175);

}

void draw() {
  background(255);
  p.go();
}
