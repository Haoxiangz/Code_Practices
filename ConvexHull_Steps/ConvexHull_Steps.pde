
ArrayList<Dot> m;
Lines lines;
Dot id;

void setup(){
  size(1600,1600);
  background(255);
  m = new ArrayList<Dot>();
  lines = new Lines();
}

void mousePressed(){
  boolean move = false;
  //check if we are trying to move any
  for(Dot n : m)
    if(dist(mouseX,mouseY,n.position.x,n.position.y)<=16){
      n.movin = true;
      move = true;
      id = n;
      lines.movin = true;
      break;
    }
  // if we are not trying to move, add a new one
  if(!move)
    m.add(new Dot(mouseX, mouseY));
  lines.step = 0;
  lines.layer = 0;
}

void mouseReleased(){
  //end of moving session, release the moving dot
  if(m.indexOf(id) != -1){
    id.movin = false;
    lines.movin = false;
  }
}


void draw(){
  background(253);
  /**
  fill(50);
  textSize(32);
  text(Integer.toString(m.indexOf(id)), 10, 10, 170, 180);
  */
  lines.show(m);
  for(Dot n : m){
    n.update();
    n.show();
  }
}
