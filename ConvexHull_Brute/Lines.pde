import java.util.*;
import javafx.util.Pair;

class Lines{
  boolean movin;
  int step;
  
  Lines(){
    movin = false;
    step = 0;
  }
  
  //return an array of all steps taken and whether they are taken or not
  private ArrayList<Pair<Dot,Integer>> StepBrute(ArrayList<Dot> a){
    ArrayList<Pair<Dot,Integer>> ret = new ArrayList<Pair<Dot,Integer>>();
    for (int i=0; i < a.size() - 1; i++){
      for (int j=i+1; j < a.size(); j++){
            float x1 = a.get(i).position.x, x2 = a.get(j).position.x; 
            float y1 = a.get(i).position.y, y2 = a.get(j).position.y; 
            
            ret.add(new Pair<Dot,Integer>(a.get(i),0)); 
            ret.add(new Pair<Dot,Integer>(a.get(j),0)); 
            
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
                ret.add(new Pair<Dot,Integer>(a.get(i),1)); 
                ret.add(new Pair<Dot,Integer>(a.get(j),1)); 
            } 
      }
    }
    return ret;
  }
  
  void show(ArrayList<Dot> d){
    //this is showing the bruteforce steps
    if(!movin){
      ArrayList<Pair<Dot,Integer>> a = StepBrute(d);
      if(step < a.size())step+=2;
      for(int i=0; i < step; i+=2){
        if(a.get(i).getValue() == 0)//it was an attempt
          stroke(220);
        else
          stroke(102,204,255);
        strokeWeight(5);
        line((int)a.get(i).getKey().position.x,(int)a.get(i).getKey().position.y,
        (int)a.get(i+1).getKey().position.x,(int)a.get(i+1).getKey().position.y);
        
        textSize(32);
        text(d.size(),10,30);        //number of nodes 
        text(a.size()/2,10,70);      //number of orientation calls (roughly)
        text(step/2,10,110);         //current step of drawing process
      }
    }
  }
  
  //end of class
}

/**
class Sortbypos implements Comparator<Dot>{
  public int compare(Dot a, Dot b){
    // need to rewrite this
    return (int)(a.position.x * b.position.y - b.position.x * a.position.y); 
  }
}
*/
