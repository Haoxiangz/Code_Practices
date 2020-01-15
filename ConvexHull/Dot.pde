class Dot{
  PVector position;
  boolean movin;

  Dot(float x, float y){
    position = new PVector(x,y);
    movin = false;
  }
  
  void update(){
    if(movin){
      position.x = mouseX;
      position.y = mouseY;
    }
  }
  
  void show(){
    fill(0);
    noStroke();
    if(dist(mouseX,mouseY,position.x,position.y)<=16)
      ellipse(position.x,position.y,20,20);
    else
      ellipse(position.x,position.y,16,16);
  }
}
