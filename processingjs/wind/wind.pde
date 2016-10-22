
WindField wind;
ArrayList<Ball> balls;

// Noise animation 

void setup() {
  size(1600, 900);
  frameRate(60);
  wind = new WindField();
  balls = new ArrayList<Ball>();
}

void draw() {
  background(0);
  wind.show();
  wind.update();

  for (Ball b : balls) {
    PVector f = wind.getWind(int(b.pos.x), int(b.pos.y)).mult(0.5);
    b.applyForce(f);
    b.show();
  }

  // Check collisions
}

void mousePressed() {
  Ball b = new Ball(mouseX, mouseY, random(10, 80));
  balls.add(b);
}