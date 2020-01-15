import java.util.*;
import javafx.util.Pair;

class Lines{
  boolean movin;
  int step, layer;
  
  Lines(){
    movin = false;
    step = 0;
    layer = 0;
  }
  
  // Checks whether the line is crossing the polygon 
  // return negative if c is on the left side of ab, 
  //and positive if it's on the right side of ab
  float orientation(PVector a, PVector b, PVector c) 
  { 
    return (b.y-a.y)*(c.x-b.x) - (c.y-b.y)*(b.x-a.x); 
  } 
  
  //merge the two hulls together, return dots for the new hull
  private ArrayList<Dot> merge(ArrayList<Dot> a, ArrayList<Dot> b){
    ArrayList<Dot> ret = new ArrayList<Dot>();
    //find start points (index)
    int maxa=0, minb=0;
    float keeper = 0;
    for(int i = 0; i < a.size(); ++i)
      if(a.get(i).position.x > keeper){
        keeper = a.get(i).position.x;
        maxa = i;
      }
    keeper = width;
    for(int i = 0; i < b.size(); ++i)
      if(b.get(i).position.x < keeper){
        keeper = b.get(i).position.x;
        minb = i;
      }
    
    //find upper bound
    int t1 = maxa, t2 = minb; //<>//
    int na = a.size(), nb = b.size();
    boolean done = false;
    while(!done){
      done = true;
      while(orientation(b.get(t2).position,a.get(t1).position,a.get((t1+1)%na).position) <= 0)
          t1 = (t1 + 1) % na;
      while(orientation(a.get(t1).position,b.get(t2).position,b.get((t2-1+nb)%nb).position) >= 0){
          t2 = (t2 - 1 + nb) % nb;
          done = false;
      }
    }
    
    //find lower bound
    int k1 = maxa, k2 = minb;
    done = false;
    while(!done){
      done = true;
      while(orientation(b.get(k2).position,a.get(k1).position,a.get((k1-1+na)%na).position) >= 0)
          k1 = (k1 - 1 + na) % na;
      while(orientation(a.get(k1).position,b.get(k2).position,b.get((k2+1)%nb).position) <= 0){
          k2 = (k2 + 1) % nb;
          done = false;
      }
    }
    //return the composed hull
    ret.add(a.get(t1));
    int i = t1;
    while(i != k1){
      i = (i+1)%na;
      ret.add(a.get(i));
    }
    ret.add(b.get(k2));
    i = k2;
    while(i != t2){
      i = (i+1)%nb;
      ret.add(b.get(i));
    }
    return ret;
  }
  
  //main body of divide and conquer, return the list of dots for convex hull
  private ArrayList<Dot> DnC(ArrayList<Dot> a){
    int n = a.size();
    //base case
    if(n <= 5)
      return Brute(a);
    
    ArrayList<Dot> left = new ArrayList<Dot>();
    ArrayList<Dot> right = new ArrayList<Dot>();
    for(int i=0 ; i<n/2 ; ++i)left.add(a.get(i));
    for(int i=n/2 ; i<n ; ++i)right.add(a.get(i));
    stroke(200);
    ArrayList<Dot> left_hull = DnC(left);
    stroke(0);
    ArrayList<Dot> right_hull = DnC(right);
    
    return merge(left_hull,right_hull);
  }
  
  //return the set of lines to draw, read every two positions to form a line
  private ArrayList<Dot> Brute(ArrayList<Dot> a){
    HashSet<Dot> s = new HashSet<Dot>();
    ArrayList<Dot> ret = new ArrayList<Dot>();
    for (int i=0; i < a.size() - 1; i++){
      for (int j=i+1; j < a.size(); j++){
            float x1 = a.get(i).position.x, x2 = a.get(j).position.x; 
            float y1 = a.get(i).position.y, y2 = a.get(j).position.y; 
            
            float a1 = y1-y2; 
            float b1 = x2-x1; 
            float c1 = x1*y2-y1*x2; 
            int pos = 0, neg = 0; 
            for (int k=0; k<a.size(); k++) 
            { 
                if (a1*a.get(k).position.x+b1*a.get(k).position.y+c1 <= 0) 
                    neg++; 
                if (a1*a.get(k).position.x+b1*a.get(k).position.y+c1 >= 0) 
                    pos++; 
            } 
            if (pos == a.size() || neg == a.size()) 
            { 
                s.add(a.get(i)); 
                s.add(a.get(j)); 
            } 
      }
    }
      
    for(Dot i: s)ret.add(i);
    int n = ret.size();
    PVector mid = new PVector(0,0);
    for(Dot i: ret){
      mid.x += i.position.x;
      mid.y += i.position.y;
      i.position.x *= n;
      i.position.y *= n;
    }
    Collections.sort(ret, new Sortbypos(mid));
    //ellipse(mid.x/n,mid.y/n,24,24);
    
    for(Dot i: ret){
      i.position.x /= n;
      i.position.y /= n;
      //textSize(50);
      //text(ret.indexOf(i),i.position.x,i.position.y);
    }
    return ret;
  }
  
  
  void show(ArrayList<Dot> d){
    //this is showing the bruteforce steps
    if(!movin){
      Collections.sort(d, new Sortbyraw());
      ArrayList<Dot> a = DnC(d);
      int n = a.size();
      for(int i=0;i<n;i++){
        stroke(102,204,255);
        strokeWeight(5);
        line((int)a.get(i).position.x,(int)a.get(i).position.y,
        (int)a.get((i+1)%n).position.x,(int)a.get((i+1)%n).position.y);
        
      }
    }
  }
  
  //end of class
}

class Sortbyraw implements Comparator<Dot>{
  public int compare(Dot l, Dot r){
    return (int)(l.position.x - r.position.x);
  }
}

class Sortbypos implements Comparator<Dot>{
  
  PVector mid;
  
  public Sortbypos(PVector a){
    mid = a; 
  }
  
  private int quad (PVector p){
    if (p.x >= 0 && p.y <= 0)
      return 1;
    if (p.x <= 0 && p.y <= 0)
      return 2;
    if (p.x <= 0 && p.y >= 0)
      return 3;
    return 4;
  }
  
  public int compare(Dot l, Dot r){
    PVector a = new PVector(l.position.x - mid.x, l.position.y - mid.y);
    PVector b = new PVector(r.position.x - mid.x, r.position.y - mid.y);
    int one = quad(a);
    int two = quad(b);
    
    if (one != two)
      return one - two;
    return (int)(a.x * b.y - b.x * a.y); 
  }
}
