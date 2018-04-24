class PointTree {
  PVector position;
  float radius, angleOff;
  PointTree(PVector _position, float _radius, float _angleOff) {
    position = _position;
    radius = _radius;
    angleOff = random(-500, 500);
  }
  
  void move() {

    if (position.x > -10 && position.x < width + 10 && position.y > -10 && position.y < height + 10) {
      if (radius > 0.2) {   

        angleOff += random(0.01, 0.03);
        float angle = PI/2;
        angle *= map(noise(angleOff), 0, 1, -PI/2, PI/2);

        float x = cos(angle);
        float y = sin(angle);

        PVector velocity = new PVector(x, y);
        position.add(velocity);

        radius *= 0.995;
      }
    }
  }
}