
Planet sun, earth, moon;
float fps = 60.0;
PVector plane = new PVector(0, 1);

void setup() {
  //fullScreen();
  size(1000, 1000);
  frameRate(fps);

  sun = new Planet(new PVector(width/2, height/2), 50, 2, null, null);
  earth = new Planet(new PVector(150, 150), 20, 1, sun, null);
  moon = new Planet(new PVector(0, 30), 10, 1, earth, null);

  earth.addPlanet(moon);
  sun.addPlanet(earth);
}

void draw() {
  background(0);
  sun.update();
  sun.show();

  //stroke(255);
  //if (mousePressed) {
    
  //  PVector dir = new PVector(mouseX-pressPos.x, mouseY-pressPos.y);
  //  float angle = atan2(plane.x, plane.y) - atan2(dir.x, dir.y);
  //  //println(degrees(angle));
    
  //  fill(255);
  //  textSize(16);
  //  text(int(dir.mag()), mouseX, mouseY);
    
  //  translate(pressPos.x, pressPos.y);
  //  rotate(angle);
  //  line(0, 0, 0, dir.mag());
    
  //  for (int i=0; i<40; i++) {
  //     float inc = lerp(-dir.mag(), -10*dir.mag(), i/20.0);
  //     point(0, inc);
  //  }
    
  //  pushMatrix();
  //  rotate(PI/6.0);
  //  line(0, 0, 0, constrain(dir.mag()*0.4, 5, 20));
  //  popMatrix();
    
  //  pushMatrix();
  //  rotate(-PI/6.0);
  //  line(0, 0, 0, constrain(dir.mag()*0.4, 5, 20));
  //  popMatrix();

    
  //}
}

PVector pressPos;
void mousePressed() {
  pressPos = new PVector(mouseX, mouseY);
}

PVector releasePos;
void mouseReleased() {
  releasePos = new PVector(mouseX, mouseY);
  pressPos.sub(releasePos);
  pressPos.mult(0.1); 
  Planet newearth = new Planet(new PVector(mouseX-sun.pos.x, mouseY-sun.pos.y), 20, 10, sun, pressPos);
  Planet newmoon = new Planet(new PVector(0, 30), 10, 0.1, earth, null);
  newearth.addPlanet(newmoon);
  sun.addPlanet(newearth);
}