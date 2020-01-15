class Circle{
  float x, y, r;
  boolean growing;
  color c;
  
  Circle(float x_, float y_, color c_){
    x = x_;
    y = y_;
    r = 2;
    c = c_;
    growing = true;
  }
  
  boolean edge(){
    return (x+r>width || x<r || y+r>height || y<r);
  }
  
  void grow(){
      r+=1;
  }
  
  void show(){
    fill(c);
    //strokeWeight(2);
    //noFill();
    circle(x,y,r*2);
  }
}
