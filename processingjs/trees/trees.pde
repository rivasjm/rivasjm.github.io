
float angle;
void setup() {
  size(1000, 600);
}

float i = 0.1;
void draw() {
  background(0);
  translate(width/2, height);
  branch(map(mouseY, height, 1, 10, 200));
  angle = map(mouseX, 1, width, -PI/4.0, PI/4.0);
  
}

void branch(float length) {
  stroke(160, map(length, 100, 10, 82, 255), 45);
  strokeWeight(length*0.2);
  line(0, 0, 0, -length);
  
  translate(0, -length);
  if (length > 10) {
    pushMatrix();
    rotate(angle);
    branch(length*0.7);
    popMatrix();
    
    pushMatrix();
    rotate(-angle);
    branch(length*0.7);
    popMatrix();
  }
}