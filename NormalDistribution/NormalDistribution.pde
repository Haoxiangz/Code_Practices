import java.util.*;

Random generator;
void setup(){
  size(1600,1200);
  background(255);
  generator = new Random();
}

void draw(){
  float xaxis = (float)generator.nextGaussian();
  float yaxis = (float)generator.nextGaussian();
  colorMode(RGB);
  fill(200);
  xaxis = xaxis*100 + 800;
  yaxis = yaxis*100 + 600;
  noStroke();
  fill(255-xaxis-yaxis,10);
  ellipse(xaxis,yaxis,24,24);
}
