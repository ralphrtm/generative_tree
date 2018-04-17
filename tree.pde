class tree {
  ArrayList<leaf> leafSys;

  color c3 = color(random(255), random(148), random(148));
  color c4 = color(random(148), random(148), random(255));
  
  color col;

  PGraphics pg;

  ArrayList<PVector> pointPath;
  float[] angleOff;
  float[] radius;

  PVector location, velocity;
  float x, y;

  int index;

  color c1 = color(100, 75, 46);
  color c2 = color(200, 148, 20);

  tree(PVector _location, float _radius) {
    pointPath = new ArrayList<PVector>();
    pointPath.add(_location);

    angleOff = new float[50];
    angleOff[0] = random(-500, 500);

    radius = new float[50];
    radius[0] = _radius;

    location = new PVector(0, 0);
    velocity = new PVector(0, -1);

    leafSys = new ArrayList<leaf>();
    pg = createGraphics(width, height);
  }

  void leaves(PVector _loc) {
    location = _loc;

    for (int i = 0; i < leafSys.size(); i++) {
      leaf f = leafSys.get(i);
      f.drawLeaf();
    }

    if (random(0, 10) < 1.2 && pointPath.size() > 1) {
      leafSys.add(new leaf(new PVector(location.x, location.y), c3, c4));
    }
  }

  void display() {    
    pg.beginDraw();
    for (int i = 0; i < pointPath.size(); i++) {
      index = i;
      location = pointPath.get(i);
      update();

      col = lerpColor(c1, c2, map(radius[i], 0, 60, 1, 0));

      pg.noStroke(); 
      pg.fill(col, map(radius[i], 0, 62, 150, 50));
      pg.ellipse(location.x, location.y, radius[i], radius[i]);

      if (radius[i] < 2) {
        pointPath.remove(i);
      }

      radius[index] *= 0.997;

      if (random(0, 1) < 0.5 && radius[i] > 2 && location.y < height*0.9) {
        pointPath.add(new PVector(random(1)+location.x, random(1)+location.y));
        radius[index+1] = radius[index]*random(0.8, 0.9);     
        angleOff[pointPath.size()] = random(-500, 500);
      }
    }
    pg.endDraw(); 

    image(pg, 0, 0);

    if (location.y < height*0.8) leaves(location);
  }

  void update() {    
    if (location.x > -10 & location.x < width + 10 & location.y > -10 & location.y < height + 10) {
      if (radius[index] > 0.2) {    
        angleOff[index] += 0.005;
        float angle = 195*noise(angleOff[index]); 

        x = cos(radians(angle));
        y = sin(radians(angle));
        
        velocity = new PVector(x, -y);

        location.add(velocity);
      }
    }
  }
}
