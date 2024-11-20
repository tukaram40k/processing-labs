void setup() {
  size(1000, 1000);
  background(200, 220, 255);
  noStroke();
  
  int h1 = height/2;
  int w1 = width/2;
  
  // background pattern
  fill(170, 170, 255);
  for (int i = 0; i < 25; i++) {
    //size range
    int l = -18;
    int r = 18;
    
    if (random(0, 3) < 1) {
      // triangles
      int x1 = int(random(0, width));
      int y1 = int(random(0, height));
      int x2 = x1 + int(random(l, r));
      int y2 = y1 + int(random(l, r));
      int x3 = x1 + int(random(l, r));
      int y3 = y1 + int(random(l, r));
      triangle(x1, y1, x2, y2, x3, y3);
    }
    
    if (random(0, 3) > 1 && random(0, 3) < 2) {
      // quads
      int qx1 = int(random(0, width));
      int qy1 = int(random(0, height));
      int qx2 = qx1 + int(random(l, r));
      int qy2 = qy1 + int(random(l, r));
      int qx3 = qx1 + int(random(l, r));
      int qy3 = qy1 + int(random(l, r));
      int qx4 = qx1 + int(random(l, r));
      int qy4 = qy1 + int(random(l, r));
      quad(qx1, qy1, qx2, qy2, qx3, qy3, qx4, qy4);
    }
    
    if (random(0, 3) > 2) {
      // rects
      int rx = int(random(0, width));
      int ry = int(random(0, height));
      int rw = int(random(1, r));
      int rh = int(random(1, r));
      rect(rx, ry, rw, rh);
    }
  }
  
  // waves
  stroke(255);
  strokeWeight(5);
  noFill();
  
  // wave arks
  for (int i = 0; i < height; i += 110) {
    for (int j = 0; j < width; j += 100) {
      if ((j / 100) % 2 == 0) {
        arc(j + 75, i, 100, 50, PI, TWO_PI);
      }
      else {
        arc(j + 50, i, 100, 50, 0, PI);
      }
    }
  }
  
  // eyes position
  int eye_height = h1 - 45;
  
  // eyebrows
  fill(255, 100, 100);
  circle(w1 - 60, eye_height - 25, 50);
  circle(w1 + 60, eye_height - 25, 50);
  
  // body
  fill(255, 100, 100);
  ellipse(w1, h1, 250, 170);
  
  // eyes
  fill(255);
  circle(w1 - 60, eye_height, 30);
  circle(w1 + 60, eye_height, 30);
  
  // pupils
  fill(0);
  circle(w1 - 60, eye_height, 25);
  circle(w1 + 60, eye_height, 25);
  
  // legs
  stroke(255, 100, 100);
  strokeWeight(7);
  
  // left
  line(w1 - 90, h1 + 50, w1 - 150, h1 + 100);
  line(w1 - 100, h1 + 40, w1 - 180, h1 + 90);
  line(w1 - 110, h1 + 30, w1 - 200, h1 + 80);
  
  // right
  line(w1 + 90, h1 + 50, w1 + 150, h1 + 100);
  line(w1 + 100, h1 + 40, w1 + 180, h1 + 90);
  line(w1 + 110, h1 + 30, w1 + 200, h1 + 80);
  
  // claws
  fill(255, 100, 100);
  stroke(255, 100, 100);
  strokeWeight(10);
  
  int claw_height = h1 - 80;
  int claw_widthl = w1 - 110;
  int claw_widthr = w1 + 110;
  
  line(claw_widthl, claw_height + 50, claw_widthl - 70, claw_height);
  line(claw_widthr, claw_height + 50, claw_widthr + 70, claw_height);
  
  // claw parts
  stroke(255);
  strokeWeight(5);
  circle(claw_widthl - 80, claw_height, 60);
  circle(claw_widthr + 80, claw_height, 60);
  
  // claw gaps
  fill(200, 220, 255);
  stroke(200, 220, 255);
  circle(claw_widthl - 100, claw_height - 10, 35);
  circle(claw_widthr + 100, claw_height - 10, 35);
  
  // mouth
  fill(255);
  stroke(255);
  ellipse(w1, h1 - 15, 10, 5);
  
  save("crab.png");
}

void draw(){}
