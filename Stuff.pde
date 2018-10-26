class Stuff{
  PVector loc;
  boolean placed;
  PImage img;
  int s;
  Gif gi;
  AudioPlayer player;
  boolean m;
  
  Stuff(AudioPlayer p,float x,float y,PImage i,Gif g){
    placed = false;
    loc = new PVector(x,y);
    s = height/10;
    img = i;
    img.resize(s,0);
    gi = g;
    player = p;
    m = false;
  }
  
  void display(){
    if(placed){
      float h = 1*gi.height*s/gi.width;
      image(gi,loc.x,loc.y,1*s,int(h));
    }else{
      image(img,loc.x,loc.y);
    }
  }
  
  void update(boolean _m){
    m = true;
    if(!placed){
      loc = new PVector(mouseX,mouseY);
    }else if(mousePressed && loc.dist(new PVector(mouseX,mouseY)) < s/2 && _m){
      loc = new PVector(mouseX,mouseY);
    }else{
      m = false;
    }
  }
  
  void stopAudio(){
    player.pause();
  }
}
