ArrayList<boids> flock;

void setup(){
  size(2000,1600);
  flock = new ArrayList();
  for(int i=0;i<300;i++)
    flock.add(new boids());
}

void draw(){
  background(0);
  for(int i=0;i<flock.size();i++){
    flock.get(i).calculate(flock);
    flock.get(i).update();
    //flock.get(i).show();
    flock.get(i).render();
  }
}

void mousePressed(){
  flock.add(new boids(mouseX, mouseY));
}
