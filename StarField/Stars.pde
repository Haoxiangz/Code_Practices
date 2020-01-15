class star{
  float x;
  float y;
  float z;

  float dx;
  float dy;
  float radius;

  star(){
    x = random(-width/2,width/2);
    y = random(-height/2,height/2);
    z = random(0,width);
    radius = random(15,25);
  }

  void update(){
    dx = map(x/z, 0,1, 0, width);
    dy = map(y/z, 0,1, 0, height);
    z -= map(mouseX, 0, width, 0, 60);
    if(z<1){
      z = width;
      x = random(-width/2,width/2);
      y = random(-height/2,height/2);
    }
  }

  void show(){

    float r = map(z/width,0,1,radius,0);
    fill(255);
    noStroke();
    ellipse(dx,dy,r,r);
  }
}
