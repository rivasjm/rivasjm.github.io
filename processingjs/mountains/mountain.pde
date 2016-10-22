
class Mountain {

  // Position and scale
  int yoff;
  float scl;

  // Landscape data (perlin noise)
  int ndata = 400;
  float step = 0.02;
  float n = 0;
  int detail = 5;
  float falloff = 0.5; 

  // Mountain shape
  PShape s;

  Mountain(int yoff, float scl) {
    this.yoff = yoff;
    this.scl = scl;

    noiseSeed(yoff);

    s = createShape();
    s.beginShape();
    s.fill(34, 139, 34, 20);
    s.noStroke();
    for (int i=0; i<=ndata; i++) {
      n += step;
      float xx = map(i, 0.0, ndata, -2*width, 2*width);
      float yy = map(noise(n), 0, 1, 0, height);
      s.vertex(xx, yy);
    }
    s.vertex(width/2, 4*height);
    s.vertex(-width/2, 4*height);
    s.endShape();
  }

  void update() {
    scl += 0.001;
    yoff += 0;
  }

  void show() {
    s.resetMatrix();
    s.translate(2*width, yoff);
    s.scale(scl);

    shape(s, 0, 0);
  }
}