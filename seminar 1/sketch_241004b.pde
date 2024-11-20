void setup() {
  fullScreen();
  background(200, 220, 240); 
}

void draw() {
  background(200, 220, 240); 

  float centerX = width / 2;
  float centerY = height / 2;
  
  float rx = 210;
  float ry = 116;

  // draw rectangle
  rectMode(CENTER);
  stroke(100, 100, 255);
  strokeWeight(3);
  fill(150, 200, 250); 
  rect(centerX, centerY, rx * 2, ry * 2);

  // draw diagonals 
  strokeWeight(12);
  stroke(220, 0, 220);
  line(centerX - rx, centerY - ry, centerX + rx, centerY + ry);
  line(centerX - rx, centerY + ry, centerX + rx, centerY - ry);
  
  // draw cross
  strokeWeight(5);
  stroke(170, 0, 170);
  line(centerX - rx, centerY, centerX + rx, centerY);
  line(centerX, centerY - ry, centerX, centerY + ry);
  
  // draw arc
  noFill();
  stroke(190, 255, 190);
  arc(centerX, centerY, rx * 2, ry * 2, 3*HALF_PI, 2*PI);
  
  // draw chord
  stroke(80, 255, 180);
  strokeWeight(8);
  arc(centerX, centerY, rx * 3/2, ry * 3/2, PI + PI/4, 2*PI + PI/2 + PI/4, CHORD);
  
  // draw pie
  stroke(255, 205, 180);
  arc(centerX, centerY, rx, ry, PI/2 , PI+PI/2+PI/2, PIE);
  
  
  float circleRadius = 100;
  float circleX = centerX + rx + circleRadius + 20; 
  float circleY = centerY; 

  // circle
  stroke(0, 150, 255);
  strokeWeight(3);
  fill(255, 220, 180); 
  ellipse(circleX, circleY, circleRadius * 2, circleRadius * 2); 
  
  // polygon
  fill(255, 100, 100); 
  stroke(255, 0, 0); 
  strokeWeight(2); 
  
  beginShape();
  vertex(circleX - 40, circleY - 40); 
  vertex(circleX + 40, circleY - 20); 
  vertex(circleX + 20, circleY + 40); 
  vertex(circleX - 40, circleY + 20); 
  endShape(CLOSE);
}
