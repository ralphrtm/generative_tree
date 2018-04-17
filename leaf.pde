class leaf {
  PVector location, locSrc;
  float radius, alph;

  float locxOf, locyOf;

  color col;
  color c1;
  color c2;

  leaf(PVector _location, color _c1, color _c2) {
    location = new PVector(random(-100, 100),random(-100, 100));
    locSrc = _location;
    radius = random(60, 70);
    c1 = _c1;
    c2 = _c2;
    alph = random(50, 200);
    locxOf = random(100);
    locyOf = random(100);
  }

  void drawLeaf() {
    locxOf += .02;
    locyOf += .03;

    pushMatrix();
    translate(locSrc.x, locSrc.y);
    location.x = noise(locxOf)*30;
    location.y = noise(locyOf)*20;
    col = lerpColor(c1, c2, map(locSrc.y, 0, height, 1, 0));
    noStroke();
    fill(col, alph);
    ellipse(location.x, location.y, radius, radius);
    popMatrix();
  }
  
  void timetodie() {
    location.x = noise(locxOf) * 30;
    location.y += 1;
    
    //if (location.y == 0) newTree = location.x;
  }
}
