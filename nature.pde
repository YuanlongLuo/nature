import ddf.minim.*;
import gifAnimation.*;

Minim minim;

PImage imgs[] = new PImage[5];
boolean s;
int bkCount;
int iconW;
PImage bkImage[] = new PImage[2];
ArrayList<Stuff> stuffs; 
String words[] = {"animals","insects","plants","birds","reset"};

void setup() {
  size(1600, 1000);
  imageMode(CENTER);
  for (int i = 0; i < imgs.length; i ++) {
    imgs[i] = loadImage(i+".png");
    imgs[i].resize(height/15, 0);
  }
  bkImage[0] = loadImage("植物/tree/tree.png");
  bkImage[0].resize(int(width/1.5), 0);
  bkImage[1] = loadImage("植物/grass/grass.png");
  bkImage[1].resize(width, 0);
  bkCount = 0;
  iconW = height/10;
  if (random(1) < 0.5)
    s = false;
  else
    s = true;
  minim = new Minim(this);
  stuffs = new ArrayList<Stuff>();
  textAlign(CENTER,CENTER);
}

void draw() {
  background(255);
  for (int i = 0; i < imgs.length; i ++) {
    noFill();
    ellipse(width/20, (1+i*1.5)*iconW, iconW, iconW);
    image(imgs[i], width/20, (1+i*1.5)*iconW);
    fill(0);
    textSize(iconW/3);
    text(words[i], 2.5*width/20, (1+i*1.5)*iconW);
  }
  if (bkCount == 1) {
    if (s)
      image(bkImage[1], width/2, height-bkImage[1].height/2);
    else
      image(bkImage[0], width*0.7, height*0.58);
  } else if (bkCount > 1) {
    image(bkImage[0], width*0.7, height*0.58);
    image(bkImage[1], width/2, height-bkImage[1].height/2);
  }
  
  boolean m = true;
  for (int i = 0; i < stuffs.size(); i++) {
    Stuff s = stuffs.get(i);
    s.display();
    s.update(m);
    if(s.m){
      m = false;
    }
  }
}

void mousePressed() {
  int i = 0;
  if (dist(mouseX, mouseY, width/20, (1+i*1.5)*height/10) < iconW/2) {
    int t = int(random(100))%1;
    PImage img = loadImage("动物/"+t+"/"+t+".png");
    Gif gi = new Gif(this, "动物/"+t+"/"+t+".gif");
    AudioPlayer player = minim.loadFile("动物/"+t+"/"+t+".mp3");
    player.loop();
    stuffs.add(new Stuff(player,width/20, (1+i*1.5)*height/10, img, gi));
  }
  i = 1;
  if (dist(mouseX, mouseY, width/20, (1+i*1.5)*height/10) < iconW/2) {
    int t = int(random(100))%2;
    PImage img = loadImage("昆虫/"+t+"/"+t+".png");
    Gif gi = new Gif(this, "昆虫/"+t+"/"+t+".gif");
    AudioPlayer player = minim.loadFile("昆虫/"+t+"/"+t+".mp3");
    player.loop();
    stuffs.add(new Stuff(player,width/20, (1+i*1.5)*height/10, img, gi));
  }
  i = 2;
  if (dist(mouseX, mouseY, width/20, (1+i*1.5)*height/10) < iconW/2) {
    bkCount ++;
    if (bkCount == 1) {
      if (s) {
        AudioPlayer player = minim.loadFile("./data/植物/grass/grass.mp3");
        player.loop();
      } else {
        AudioPlayer player = minim.loadFile("./data/植物/tree/tree.mp3");
        player.loop();
      }
    } else if (bkCount == 2) {
      if (!s) {
        AudioPlayer player = minim.loadFile("./data/植物/grass/grass.mp3");
        player.loop();
      } else {
        AudioPlayer player = minim.loadFile("./data/植物/tree/tree.mp3");
        player.loop();
      }
    }
  }
  i = 3;
  if (dist(mouseX, mouseY, width/20, (1+i*1.5)*height/10) < iconW/2) {
    int t = int(random(100))%2;
    PImage img = loadImage("鸟/"+t+"/"+t+".png");
    Gif gi = new Gif(this, "鸟/"+t+"/"+t+".gif");
    AudioPlayer player = minim.loadFile("鸟/"+t+"/"+t+".mp3");
    player.loop();
    stuffs.add(new Stuff(player,width/20, (1+i*1.5)*height/10, img, gi));
  }
  i = 4;
  if (dist(mouseX, mouseY, width/20, (1+i*1.5)*height/10) < iconW/2) {
    init();
  }
}

void mouseReleased() {
  if (stuffs.size() > 0) {
    stuffs.get(stuffs.size()-1).placed = true;
    stuffs.get(stuffs.size()-1).gi.loop();
  }
}

void keyPressed() {
  init();
}

void init() {
  bkCount = 0;
  iconW = height/10;
  if (random(1) < 0.5)
    s = false;
  else
    s = true;
  for(int i = stuffs.size()-1;i>=0;i--){
    stuffs.get(i).stopAudio();
    stuffs.remove(i);
  }
}
