
class Planet {

  PVector pos;
  PVector vel;

  float r;
  float m;

  Planet parent;
  ArrayList childs;

  //float G = 6.674e-11;
  float G = 10;
  float dt = 1.0/frameRate;

  PVector[] trail;
  int trailSize;
  int c;


  Planet(PVector position, float radius, float mass, Planet parent, PVector iniVel) {
    this.pos = position;
    this.r = radius;
    this.m = mass;
    this.parent = parent;

    childs = new ArrayList();
    trail = new PVector[1];

    if (parent != null) {
      // Initial velocity perpendicular to parent
      if (iniVel != null) {
        this.vel = new PVector(iniVel.x, iniVel.y);
      } else {
        this.vel = new PVector(pos.x, pos.y);
        //vel.setMag(log(pos.mag())).rotate(HALF_PI);
        vel = PVector.random2D();
        vel.setMag(2);
      }
    }

    trailSize = (int) pos.mag();
    c = color(random(255), random(255), random(255));
  }


  void addPlanet(Planet p) {
    childs.add(p);
  }


  void update() {
    if (parent != null) {
      float f = G * m * parent.m/pow(pos.mag(), 2);
      float a = f/m;
      PVector acc = PVector.mult(pos, -1*a);
      vel.add(acc);
      pos.add(vel);
    }

    trail = (PVector[]) splice(trail, new PVector(pos.x, pos.y), 0); 
    if (trail.length > trailSize) {
      trail = (PVector[]) subset(trail, 0, trailSize);
    }
    
        fill(200);
    ellipse(100, 100, 20, 20);

    for (int i=0; i<childs.size(); i++) {//Planet p : childs) {
      Planet p = (Planet) childs.get(i);
      p.update();
    }
  }


  void update(PVector newpos) {
    this.pos = new PVector(newpos.x, newpos.y);

    for (int i=0; i<childs.size(); i++) {
      Planet p = (Planet) childs.get(i);
      p.update();
    }
  }


  void show() {
    if (parent == null) {
      c = #FFCC00;
    }
    pushMatrix();
    stroke(c);
    for (int i=0; i<trail.length-2; i++) {
      line(trail[i].x, trail[i].y, trail[i+1].x, trail[i+1].y);
    }
    noStroke();
    fill(c);
    ellipse(pos.x, pos.y, r, r);

    if (parent != null) {
      textSize(this.r*0.8);
      text(int(this.vel.mag()), pos.x+r/2.0, pos.y);
    }
    translate(pos.x, pos.y);
    for (int i=0; i<childs.size(); i++) {
      Planet p = (Planet) childs.get(i);
      p.show();
    }
    popMatrix();
  }
}