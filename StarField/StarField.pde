ArrayList<star> s = new ArrayList();

int num = 300;

void setup(){
   size(1600,1600);
   background(0);
   for(int i=0;i<num;i++){
     s.add(new star());
   }
}

void draw(){
  background(0);
  translate(width/2,height/2);
  for(int i=0;i<num;i++){
    s.get(i).update();
    s.get(i).show();
  }
}
