float clawAngle = 0;
float clawDir = 1;
float eyeOffset = 0;
float clawOffset = 0;
float waveOffset = 0;
float legAngle = 0;
float legDir = 1;
float cheek = 1;

void setup() {
  size(1000, 1000);
  background(200, 220, 255);
  noStroke();
}

void draw() {
  background(200, 220, 255);
  noStroke();

  int h1 = height/2;
  int w1 = width/2;
  
  // waves with offset animation
  stroke(255);
  strokeWeight(5);
  noFill();
  
  waveOffset += 0.05;
  cheek += 0.1;
  
  for (int i = 0; i < height; i += 110) {
    for (int j = 0; j < width; j += 100) {
      float adjustedWaveOffset = waveOffset + j * 0.02;
      if ((j / 100) % 2 == 0) {
        arc(j + 75 + sin(adjustedWaveOffset) * 10, i + sin(adjustedWaveOffset) * 10, 100 + sin(adjustedWaveOffset) * 10, 50 - sin(2*adjustedWaveOffset) * 10, PI, TWO_PI);
      }
      else {
        arc(j + 50 - sin(adjustedWaveOffset) * 10, i - sin(adjustedWaveOffset) * 10, 100 - sin(adjustedWaveOffset) * 10, 50 - sin(2*adjustedWaveOffset) * 10, 0, PI);
      }
    }
  }
  
  // eyebrows
  float eye_height = h1 - 45 + sin(eyeOffset) * 5;
  eyeOffset += 0.1;
  
  fill(255, 100, 100);
  ellipse(w1 - 60, eye_height - 25, 50 + sin(eyeOffset)*6, 45);
  ellipse(w1 + 60, eye_height - 25, 50 + sin(eyeOffset)*6, 45);
  
  // body
  fill(255, 100, 100);
  ellipse(w1, h1, 250 + sin(eyeOffset)*7, 170 - sin(eyeOffset)*6);
  
  // cheecks
  float greenValue = map(sin(cheek), -1, 1, 100, 192 - 15);
  float blueValue = map(sin(cheek), -1, 1, 100, 255 - 15);
  
  fill(255, greenValue, blueValue);
  noStroke();
  ellipse(w1 - 70, eye_height + 40, 30, 29 - sin(eyeOffset)*3);
  ellipse(w1 + 70, eye_height + 40, 30, 29 - sin(eyeOffset)*3);
  
  // eyes
  stroke(255);
  fill(255);
  ellipse(w1 - 50, eye_height + 5, 30, 29 - sin(eyeOffset)*3);
  ellipse(w1 + 50, eye_height + 5, 30, 29 - sin(eyeOffset)*3);
 
  fill(0);
  ellipse(w1 - 50, eye_height + 5, 25, 25 - sin(eyeOffset)*4);
  ellipse(w1 + 50, eye_height + 5, 25, 25 - sin(eyeOffset)*4);
  
  // legs
  legAngle += legDir * 0.0075;
  if (legAngle > 0.3 || legAngle < -0.3) {
    legDir *= -1;
  }
  
  // left legs
  fill(255, 100, 100);
  stroke(255, 100, 100);
  strokeWeight(7);
  
  pushMatrix();
  translate(w1 - 90, h1 + 50);
  rotate(legAngle);
  line(0, 0, -60, 50);
  popMatrix();
  
  pushMatrix();
  translate(w1 - 100, h1 + 40);
  rotate(legAngle * 0.8);
  line(0, 0, -80, 50);
  popMatrix();
  
  pushMatrix();
  translate(w1 - 110, h1 + 30);
  rotate(legAngle * 0.6);
  line(0, 0, -100, 50);
  popMatrix();
  
  // right legs
  pushMatrix();
  translate(w1 + 90, h1 + 50);
  rotate(-legAngle);
  line(0, 0, 60, 50);
  popMatrix();
  
  pushMatrix();
  translate(w1 + 100, h1 + 40);
  rotate(-legAngle * 0.8);
  line(0, 0, 80, 50);
  popMatrix();
  
  pushMatrix();
  translate(w1 + 110, h1 + 30);
  rotate(-legAngle * 0.6);
  line(0, 0, 100, 50);
  popMatrix();
  
  // claws
  clawAngle += clawDir * 0.015;
  if (clawAngle > 0.25 || clawAngle < -0.25) {
    clawDir *= -1;
  }
  
  fill(255, 100, 100);
  stroke(255, 100, 100);
  strokeWeight(10);
  
  float claw_height = h1 - 80 + sin(2*clawOffset) * 5;
  clawOffset += 0.1;
  
  int claw_widthl = w1 - 110;
  int claw_widthr = w1 + 110;
  
  // left claw with rotation
  pushMatrix();
  translate(claw_widthl, claw_height + 50);
  rotate(clawAngle);
  line(0, 0, -70, -50);

  // claw parts
  stroke(255);
  strokeWeight(5);
  arc(-70, -50, 60 + sin(clawOffset) * 4, 60 - sin(clawOffset) * 4, PI + PI/2 - sin(clawOffset)/4, 3*PI + sin(clawOffset)/3.5, PIE);
  fill(200, 220, 255);
  stroke(200, 220, 255);
  popMatrix();
  
  // right claw with rotation
  stroke(255, 100, 100);
  strokeWeight(10);
  pushMatrix();
  translate(claw_widthr, claw_height + 50);
  rotate(-clawAngle);
  line(0, 0, 70, -50);
  
  // claw parts
  fill(255, 100, 100);
  stroke(255);
  strokeWeight(5);
  arc(70, -50, 60 + sin(clawOffset) * 4, 60 - sin(clawOffset) * 4, 0 - sin(clawOffset)/4, 3*PI/2 + sin(clawOffset)/3.5, PIE);
  fill(200, 220, 255);
  stroke(200, 220, 255);
  popMatrix();
  
  // mouth
  fill(255, 100, 100);
  stroke(255);
  ellipse(w1, h1 - 15 - sin(eyeOffset)*5, 15, 7 + sin(eyeOffset)*3);

}
