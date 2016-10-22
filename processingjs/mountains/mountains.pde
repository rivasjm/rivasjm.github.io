
Mountain[] m;

void setup() {
  size(1024, 400);

  m = new Mountain[20];

  for (int i=0; i<m.length; i++) {
    m[i] = new Mountain(int(lerp(-2*height, 2*height, (i+1.0)/m.length)), 1/(i+1.0));
  }
}

void draw() {

  fill(135, 206, 250, 200);
  rect(0, 0, width, height);

  for (int i=m.length-1; i>=0; i--) {
    m[i].update();
    m[i].show();
  }
}