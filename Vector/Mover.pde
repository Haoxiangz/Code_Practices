class Mover{
  PVector position;
  PVector velocity;
  PVector acceleration; 
  color c;

  Mover(float x, float y){
    position = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    c = color(random(100,255),random(200),random(100,255));
  }
  
  void update(){
    acceleration.set(mouseX - position.x,mouseY - position.y);
    acceleration.limit(1);
    acceleration.div(15);
    velocity.add(acceleration);
    velocity.limit(10);
    position.add(velocity);
    if(position.x > width || position.x < 0) velocity.x = 0;
    if(position.y > height || position.y < 0) velocity.y = 0;
  }
  
  void show(){
    fill(c);
    noStroke();
    ellipse(position.x,position.y,16,16);
  }
}
