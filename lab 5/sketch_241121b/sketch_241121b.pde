class Insect {
  PVector position;
  PVector velocity;
  float r = 30;
  
  Insect() {
    position = new PVector(random(width), random(height));
    velocity = new PVector(random(-5, 5), random(-5, 5));
  }
  
  void update() {
    velocity.limit(8);
    position.add(velocity);
    
    // wrap around screen edges
    if (position.x < 0) position.x = width;
    if (position.x > width) position.x = 0;
    if (position.y < 0) position.y = height;
    if (position.y > height) position.y = 0;
  }
  
  void collideWithParticles(ArrayList<Particle> particles) {
    for (Particle p : particles) {
      float d = PVector.dist(p.position, position);
      if (d < r + p.r) {
        
        PVector collisionVector = PVector.sub(position, p.position);
        collisionVector.normalize();
        collisionVector.mult(5);
        
        velocity.add(collisionVector);
      }
    }
  }
  
  void display() {
    noStroke();
    fill(#7F859D);
    ellipse(position.x, position.y, r*2, r*2);
  }
}

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  float r = 20;
  boolean highlight;

  Particle(float x, float y) {
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    position = new PVector(x, y);
    lifespan = 255.0;
  }

  void run() {
    update();
    display();
  }

  void intersects(ArrayList<Particle> particles) {
    highlight = false;
    for (Particle other : particles) {
      if (other != this) {
        float d = PVector.dist(other.position, position);
        if (d < r + other.r) {
          highlight = true;
        }
      }
    }
  }
  
  void applyForce(PVector f) {
    acceleration.add(f); 
  }

  // update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    lifespan -= 2.0;
  }

  // display
  void display() {
    noStroke();
    strokeWeight(2);
    fill(lifespan, lifespan/1.5, 150, lifespan);
    if (highlight) {
      fill(lifespan, lifespan/1.5, 150, lifespan);
    }
    ellipse(position.x, position.y, r*2, r*2);
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}

class ParticleSystem {
  ArrayList<Particle> particles;

  ParticleSystem(PVector position) {
    particles = new ArrayList<Particle>();
  }

  void addParticle(float x, float y) {
    particles.add(new Particle(x, y));
  }

  void display() {
    for (Particle p : particles) {
      p.display();
    }
  }

  void intersection() {
    for (Particle p : particles) {
      p.intersects(particles);
    }
  }

  void update() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.update();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

// global vars
ParticleSystem ps;
ArrayList<Insect> insects;
int numInsects = 18;

void setup() {
  size(1500, 1000);
  ps = new ParticleSystem(new PVector(width/2,50));
  
  // Initialize insects
  insects = new ArrayList<Insect>();
  for (int i = 0; i < numInsects; i++) {
    insects.add(new Insect());
  }
}

void draw() {
  background(#C7DFFC);
  
  // particles at mouse
  ps.addParticle(mouseX, mouseY);
  int off = 5;
  ps.addParticle(mouseX+off, mouseY+off);
  ps.addParticle(mouseX-off, mouseY-off);
  ps.addParticle(mouseX+off, mouseY-off);
  ps.addParticle(mouseX-off, mouseY+off);
  
  // update particles
  ps.update();
  ps.intersection();
  ps.display();
  
  // update insects
  for (Insect insect : insects) {
    insect.update();
    insect.collideWithParticles(ps.particles);
    insect.display();
  }
}
