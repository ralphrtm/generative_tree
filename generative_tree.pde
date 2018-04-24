tree t1, t2, t3;

void setup() {
  size(800, 600,P2D);
  //fullScreen();
  background(0);
  frameRate(25);
  noiseDetail(1);
  //t1 = new tree(new PVector(500, height), 60);
  t2 = new tree(new PVector(width/2, height), 60);
  //t3 = new tree(new PVector(width-500, height), 60);
}

void draw() {
  background(0);
  fill(255);
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