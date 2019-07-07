  import java.util.*;
  Walker w;
  
 Random generator; 
 
 void setup() {
  size(640,360);
  // Create a walker object
  w = new Walker();
  background(255);
  generator = new Random();
}
  
  void draw(){
    w.walk();
    w.display();
  }
