
WindField wind;
ArrayList balls;

void setup() {
  size(1200, 800);
  frameRate(60);
  wind = new WindField();
  balls = new ArrayList();
}

void draw() {
  background(0);

  wind.show();
  wind.update();

  for (int i = 0; i < balls.size(); i++) {
    Ball b = (Ball) balls.get(i);
    PVector f = wind.getWind(int(b.pos.x), int(b.pos.y));
    f.mult(5);
    b.applyForce(f);
    b.show();
  }
}

void mousePressed() {
  Ball b = new Ball(mouseX, mouseY, random(10, 50));
  balls.add(b);
}