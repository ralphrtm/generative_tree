class tree {
  ArrayList<leaf> leafSys;

  color c3 = color(random(255), random(255), random(255));
  color c4 = color(random(255), random(255), random(255));

  color col;

  PGraphics pg;

  ArrayList<PVector> pointPath;

  ArrayList<PointTree> pointTrees = new ArrayList<PointTree>();

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
    pointTrees.add(new PointTree(_location, _radius, random(-500, 500)));

    angleOff = new float[50];
    angleOff[0] = random(-500, 500);

    radius = new float[50];
    radius[0] = _radius;

    location = new PVector(0, 0);
    velocity = new PVector(0, -1);

    leafSys = new ArrayList<leaf>();
    pg = createGraphics(width, height);
  }

  void display() {   

    pg.beginDraw();
    for (int i = 0; i < pointTrees.size(); i++) {
      index = i;
      PointTree pointTree = pointTrees.get(i);
      location = pointTree.position;
      float radius = pointTree.radius;


      update(radius, pointTree.angleOff);

      if (radius < 2) {
        pointTrees.remove(i);
        break;
      }

      col = lerpColor(c1, c2, map(radius, 0, 60, 1, 0));

      pg.noStroke(); 
      pg.fill(col, map(radius, 0, 62, 150, 50));
      pg.ellipse(location.x, location.y, radius, radius);


      radius *= 0.997;
      pointTree.radius = radius;
      pointTree.position = location;
      pointTrees.set(i, pointTree);
      println("radius : " + radius);
      println("size of pointTrees : " + pointTrees.size());
      
      if (random(0, 1) < 0.02 && radius > 2 && location.y < height*0.9) {
        PVector position = new PVector(random(1)+location.x, random(1)+location.y);
        float newRadius = radius*random(0.8, 0.9);
        float newAngleOff = random(-500, 500);
        PointTree newPointTree = new PointTree(position, newRadius, newAngleOff);
        pointTrees.add(newPointTree);

        /*
        pointPath.add(new PVector(random(1)+location.x, random(1)+location.y));
         radius[index+1] = radius[index]*random(0.8, 0.9);     
         angleOff[pointPath.size()] = random(-500, 500);
         */
      }
    }
    pg.endDraw(); 

    image(pg, 0, 0);

    if (location.y < height*0.8) leaves(location);
  }

  void update(float radius, float angleOff) {    
    if (location.x > -10 && location.x < width + 10 && location.y > -10 && location.y < height + 10) {
      if (radius > 0.2) {    
        angleOff+= 0.005;
        float angle = 195*noise(angleOff); 

        x = cos(radians(angle));
        y = sin(radians(angle));

        velocity = new PVector(x, -y);

        location.add(velocity);
      }
    }
  }

  void leaves(PVector _loc) {
    location = _loc;

    if (frameCount < 1000) {
      for (int i = 0; i < leafSys.size(); i++) {
        leaf f = leafSys.get(i);
        f.drawLeaf();
      }
    }

    if (random(0, 10) < 1.2 && pointPath.size() > 1) {
      leafSys.add(new leaf(new PVector(location.x, location.y), c3, c4));
    }

    if (frameCount > 1000) {
      for (int i = 0; i < leafSys.size(); i++) {
        leaf f = leafSys.get(i);
        f.fallLeaf();
      }
    }
  }
}