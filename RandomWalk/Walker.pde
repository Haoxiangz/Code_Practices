class Walker{
  float x;
  float y;
  
  Walker(){
    x = width/2;
    y = height/2;
  }
  
  void display(){
    stroke(0);
    point(x,y);
  }
  
  void walk(){
    int direction = int (random(4));
    float stepSize = (float)generator.nextGaussian() + 1;
    if(direction == 0)
      x+=stepSize;
    else if(direction == 1)
      x-=stepSize;
    else if(direction == 2)
      y+=stepSize;
    else y-=stepSize;
    x = constrain(x,0,width-1);
    y = constrain(y,0,height-1);
  }
  
}
