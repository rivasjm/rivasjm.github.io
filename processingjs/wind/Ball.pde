
class Ball {

  PVector pos;
  PVector vel;
  float r;

  Ball(int x, int y, float rad) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    r = rad;
  }

  void applyForce(PVector f) {
    // Add force to the velocity
    vel.add(f);

    // Add resistance to the velocity (air for example). More resistance if ball is biger
    vel.mult(map(r, 10, 80, 0.8, 0.2));

    // New position = old position + velocity
    pos.add(vel);

    if (pos.x-r < 0 || pos.x+r > width) {
      vel.x = vel.x*-1;
      pos.x = constrain(pos.x, r, width-r);
    } 
    if (pos.y-r < 0 || pos.y+r > height) {
      vel.y = vel.y * -1;
      pos.y = constrain(pos.y, r, height-r);
    }
  }

  void show() {
    fill(200);
    noStroke();
    ellipse(pos.x, pos.y, 2*r, 2*r);
  }
}