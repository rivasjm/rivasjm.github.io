

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

    return PVector.fromAngle(angle).setMag(mag);
  }

  void show(int columns, int rows) {
    for (int i=0; i<columns; i++) {
      for (int j=0; j<rows; j++) {
        int x = int(map(i, 0, 39, 20, width-20));
        int y = int(map(j, 0, 39, 20, height-20));

        PVector pos = new PVector(x, y);
        PVector dir = this.getWind(x, y).mult(20);

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