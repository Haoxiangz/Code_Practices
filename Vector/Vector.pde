
ArrayList<Mover> m;

void setup(){
  size(1600,1600);
  background(255);
  m = new ArrayList<Mover>();
}

void mousePressed(){
  m.add(new Mover(mouseX, mouseY));
}

void draw(){
  //background(255);
  for(Mover n : m){
    n.update();
    n.show();
  }
}
