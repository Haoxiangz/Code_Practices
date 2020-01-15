class boids{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector desireForce; 
  
  int perception = (int)random(60,120);
  float maxSpeed = (int) random(5,7);
  float maxAcc = 0.2;
  
  boids(){
     position = new PVector(random(width), random(height));
     velocity = PVector.random2D();
     velocity.setMag(random(2,4));
     acceleration = new PVector(0,0);
     desireForce = new PVector(0,0);
  }
  boids(float x, float y){
     position = new PVector(x, y);
     velocity = PVector.random2D();
     velocity.setMag(random(2,4));
     acceleration = new PVector(0,0);
     desireForce = new PVector(0,0);
  }
  
  void calculate(ArrayList<boids> school){
    PVector alignment = new PVector(0,0), //local flock average velocity 
        cohesion= new PVector(0,0),      //local flcok average position in relation to this
        separation= new PVector(0,0);    //
    int count =0;
    for(boids i: school){
      if(i != this){
        float xdis = i.position.x - this.position.x;
        float ydis = i.position.y - this.position.y;
        PVector dis = new PVector(xdis, ydis);
        if(dis.mag()<perception){
          count++;
          alignment.add(i.velocity);
          cohesion.add(i.position); 
          PVector tempSep = new PVector(this.position.x, this.position.y);
          tempSep.sub(i.position);
          tempSep.div(dis.mag());
          separation.add(tempSep);
        }
      }
    }
    if(count >0){
      alignment.div(count);
      cohesion.div(count);
    }
    desireForce.mult(0);
    desireForce.add(alignment.mult(2));
    desireForce.add(cohesion.sub(this.position).mult(.4));
    desireForce.add(separation.mult(4));
    PVector temp = new PVector(this.velocity.x, this.velocity.y);
    desireForce.sub(temp.mult(0.5));
    
    
    acceleration.add(desireForce); 
    acceleration.limit(maxAcc);
  }
  
  void update(){
    
    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    //acceleration.mult(0);
    
    //Edge Check
    if(this.position.x > width)
      this.position.x = 0;
    else if(this.position.x < 0)
      this.position.x = width;
    if(this.position.y > height)
      this.position.y = 0;
    else if(this.position.y < 0)
      this.position.y = height;
    
  }
  
  void show(){
    noStroke();
    fill(0);
    ellipse(position.x, position.y,8,8);
  }
  void render() {
    float r = 5;
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    // heading2D() above is now heading() but leaving old syntax until Processing.js catches up
    
    fill(200, 100);
    stroke(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
}
