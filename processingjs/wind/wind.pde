
WindField wind;
ArrayList balls;

// Noise animation 

void setup() {
  size(1000, 800);
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
    vel.mult(map(r, 10, 50, 0.8, 0.2));

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

class WindField {

  // Noise granularity
  float expansor = 0.001;

  // Animations current position and speed(step)
  float curr = 0;
  float speed = 0.005;

  // Noise offsets
  float angleOffset = 0;
  float magOffset = width*2;

  WindField() {
  }

  void update() {
    curr+=speed;
  }

  PVector getWind(int x, int y) {
    // x and y are screen coordinates
    // Wind vector is created as angle+magnitude



    float angle = map(noise((x+angleOffset)*expansor+curr, (y+angleOffset)*expansor+curr), 0.4, 0.6, 0, TWO_PI);



    float mag = map(noise((x+magOffset)*expansor+curr, (y+magOffset)*expansor+curr), 0.3, 0.7, 0, 1);

    PVector v = new PVector(cos(angle), sin(angle)); 
    v.mult(mag);
    
    return v;

  }

  void show(int columns, int rows) {
    for (int i=0; i<columns; i++) {
      for (int j=0; j<rows; j++) {
        int x = int(map(i, 0, 39, 20, width-20));
        int y = int(map(j, 0, 39, 20, height-20));



        PVector pos = new PVector(x, y);

        PVector dir = this.getWind(x, y);
        dir.mult(20);



        float mag = dir.mag();
        int red = int(map(mag, 5, 20, 0, 255));
        int green = int(map(mag, 5, 20, 255, 0));
        color c = color(red, green, 100);
        stroke(c);
        line(pos.x, pos.y, pos.x+dir.x, pos.y+dir.y);
      }
    }
  }

  void show() {
    this.show(40, 40);
  }
}
