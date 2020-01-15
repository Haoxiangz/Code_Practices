import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
Box2DProcessing box2d;

BodyDef bd = new BodyDef();
ArrayList<Box> boxes;
 
void setup() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  size(2000,1500);
  boxes = new ArrayList<Box>();
}
 
void draw() {
  background(255);
  box2d.step();
 
  if (mousePressed) {
    Box p = new Box();
    boxes.add(p);
  }
 
  for (Box b: boxes) {
    b.display();
  }
}
