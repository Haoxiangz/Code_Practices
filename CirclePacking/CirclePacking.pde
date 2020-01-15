import gab.opencv.*;
import java.util.*;

ArrayList<Circle> circles;
PImage img, canny;
OpenCV opencv;
ArrayList<PVector> spots;

int batchSize = 40, threshold = 20;

void setup(){
  size(2464,1632);
  img = loadImage("qi.jpg");
  img.loadPixels();
  //frameRate(5);
  //surface.setSize(img.width, img.height);
  img.resize(width,height);
  //spots = new ArrayList<PVector>();
  //for(int i=0;i<width;++i){
  //  for(int j=0;j<height;++j){
  //    int index = i + j * width;
  //    color c = img.pixels[index];
  //    float b = brightness(c);
  //    if(b<10)
  //      spots.add(new PVector(i,j));
  //  }
  //}
  circles = new ArrayList<Circle>();
  spots = new ArrayList<PVector>();
  
  opencv = new OpenCV(this, img);
  opencv.findCannyEdges(100,170);
  canny = opencv.getSnapshot();
  //canny.loadPixels();
  for(int j=0;j<height;j++)
    for(int i=0;i<width;i++){
      if(brightness(canny.pixels[i + j * width]) > threshold){
        spots.add(new PVector(i,j));
      }
    }
}

/**
void mousePressed(){
  circles.add(new Circle(mouseX,mouseY));
}
*/

ArrayList<Circle> generate(){
  ArrayList<Circle> inter = new ArrayList<Circle>();
  ArrayList<Circle> ret = new ArrayList<Circle>();
  int count = 0, tries = 0;
  while(count < batchSize*2 && ++tries < batchSize*1000){
    float x = random(width);
    float y = random(height);
    boolean valid = true;
    for(Circle c: circles)
      if(dist(c.x,c.y,x,y) < c.r + 4){
        valid = false;
        break;
      }
    for(Circle c: inter)
      if(dist(c.x,c.y,x,y) < c.r + 3){
        valid = false;
        break;
      }
    if(valid){
      int ind = (int)x + (int)y * width;
      color col = img.pixels[ind];
      inter.add(new Circle(x,y,col));
      count++;
    }
  }
  if(inter.size()<batchSize * 2){
    noLoop();
    print("Done!");
  }
  Collections.sort(inter, new Sortbydist());
  for(int i=0;i<batchSize;i++)ret.add(inter.get(i));
  return ret;
}

class Sortbydist implements Comparator<Circle>{
  public int compare(Circle a, Circle b){
    float mina = width*2, minb = width*2;
    for(PVector v: spots){
      mina = min(mina, dist(a.x,a.y,v.x,v.y));
      minb = min(minb, dist(b.x,b.y,v.x,v.y));
    }
    //println(spots.size());
    //println(mina + " " + minb);
    return (int)(mina - minb);
  }
}

void draaw(){
  image(canny,0,0);
}


void draw(){
  background(0);
  ArrayList<Circle> newBatch = generate();
  
  for(Circle c: newBatch)
    circles.add(c);
  for(Circle c: circles){
    if(c.growing){
      if(c.edge()){
        c.growing = false;
        continue;
      }
      for(Circle i: circles)
        if(i!=c)
          if(dist(c.x,c.y,i.x,i.y) < c.r + i.r + 2){
            c.growing = false;
            continue;
          }
      c.grow();
    }
    c.show();
  }
}
