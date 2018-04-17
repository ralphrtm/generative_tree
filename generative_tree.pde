tree t1, t2, t3;

void setup() {
  //size(1000, 1000, P3D);
  fullScreen();
  background(0);

  //t1 = new tree(new PVector(500, height), 60);
  t2 = new tree(new PVector(width/2, height), 60);
  //t3 = new tree(new PVector(width-500, height), 60);
}

void draw() {
  background(0);

  text(frameRate, 10, 10);
 // if (frameCount > 100) t1.display();
  t2.display(); 
  //if (frameCount > 300) t3.display();
}

void mousePressed() {
  background(0);
 // t1 = new tree(new PVector(150, height), 60);
  t2 = new tree(new PVector(width/2, height), 60);
 // t3 = new tree(new PVector(width-150, height), 60);
}
