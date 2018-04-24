class tree {

  color c1 = color(100, 75, 46);
  color c2 = color(200, 148, 20);
  color c3 = color(random(255), random(255), random(255));
  color c4 = color(random(255), random(255), random(255));
  color col;

  PGraphics pg;

  ArrayList<PVector> pointPath;

  ArrayList<PointTree> pointTrees = new ArrayList<PointTree>();
  ArrayList<leaf> leafSys;

  int index;



  tree(PVector _location, float _radius) {
    noiseSeed((long)random(1000));
    pointPath = new ArrayList<PVector>();
    pointPath.add(_location);
    pointTrees.add(new PointTree(_location, _radius, random(-500, 500)));

    leafSys = new ArrayList<leaf>();
    pg = createGraphics(width, height);
  }


  void update() {
    for (int i = 0; i < pointTrees.size(); i++) {
      PointTree pointTree = pointTrees.get(i);
      PVector location = pointTree.position;
      if (pointTree.radius < 2) {
        pointTrees.remove(i);
        break;
      }

      pointTree.move();
      display(pointTree);
      createNewPointTree(pointTree);
      if (location.y < height*0.8) {
        createLeaves (location);
      }
    }
    
    image(pg, 0, 0);
    updateLeaves();
  }

  void display(PointTree pointTree) {   
    PVector location = pointTree.position;
    float radius = pointTree.radius;

    pg.beginDraw();
    col = lerpColor(c1, c2, map(radius, 0, 60, 1, 0));
    pg.noStroke(); 
    pg.fill(col, map(radius, 0, 62, 150, 50));
    pg.ellipse(location.x, location.y, radius, radius);
    pg.endDraw();
    
    println("radius : " + radius);
    println("size of pointTrees : " + pointTrees.size());

  }

  void createNewPointTree(PointTree pointTree) {
    PVector location = pointTree.position;
    float radius = pointTree.radius;

    if ((int)random(0, 100) < 1 && location.y < height*0.9 && pointTrees.size() < 5 ) {
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

  void createLeaves (PVector location) {

    if (random(0, 10) < map(location.y,height,0,0,1) && pointTrees.size() > 1) {
      leafSys.add(new leaf(new PVector(location.x, location.y), c3, c4));
    }
  }
  
  void updateLeaves() {

    if (frameCount < 1000) {
      for (int i = 0; i < leafSys.size(); i++) {
        leaf f = leafSys.get(i);
        f.drawLeaf();
      }
    }


    if (frameCount > 1000) {
      for (int i = 0; i < leafSys.size(); i++) {
        leaf f = leafSys.get(i);
        f.fallLeaf();
      }
    }
  }
}