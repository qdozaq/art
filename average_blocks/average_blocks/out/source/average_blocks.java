import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class average_blocks extends PApplet {

PImage og_img;
PImage block_img;
int block_size = 4;
int block_width = 5;
int block_height = 200;
  public void setup(){
    
    og_img = loadImage("./forest.jpg");
    og_img.loadPixels();
    block_img = og_img.get();
    block_img.updatePixels();
    surface.setSize(og_img.width, og_img.height);
    blockIt(block_width, block_height);
    saveIncremental(block_img, "out", "jpg");
}

public void draw(){
  background(0);
  // image(img,0,0);
  image(block_img,0,0);
}

public void blockIt(int bwidth, int bheight){
 for(int y = 0; y < block_img.height; ){
   for(int x = 0; x < block_img.width;){
     averageColor(x, y, bwidth, bheight);
     x += bwidth;
   }
    y += bheight;
 } 
}

public void averageColor(int x, int y, int bwidth, int bheight){
  float r,g,b;
  r=g=b=0;
  int temp = 0;
  int ybound = y + bheight;
  int xbound = x + bwidth;
  for(int i=y; i < ybound && i < block_img.height; i++){
    for(int j = x; j < xbound && j < block_img.width; j++){
      temp = block_img.get(j, i);
      r += temp >> 16 & 0xFF;
      g += temp >> 8 & 0xFF;
      b += temp & 0xFF;
    }
  }

  r = r/(bwidth*bheight);
  g = g/(bwidth*bheight);
  b = b/(bwidth*bheight);

  for(int i=y; i < ybound && i < block_img.height; i++){
    for(int j = x; j < xbound && j < block_img.width; j++){
      block_img.set(j, i, color(r,g,b));
    }
  }
}
// Saves a file with automatically incrementing filename,
// so that existing files are not overwritten. Will 
// function correctly for less than 1000 files.

public void saveIncremental(PImage imgToSave, String prefix,String extension) {
  int savecnt=0;
  boolean ok=false;
  String filename="";
  File f;
  
  while(!ok) {
    // Get a correctly configured filename
    filename=prefix;  
    if(savecnt<10) filename+="00";
    else if(savecnt<100) filename+="0";
    filename+=""+savecnt+"."+extension;

    // Check to see if file exists, using the undocumented
    // savePath() to find sketch folder
    f=new File(savePath(filename));
    if(!f.exists()) ok=true; // File doesn't exist
    savecnt++;
  }

  println("Saving "+filename);
  imgToSave.save(filename);
}
  public void settings() {  size(800, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "average_blocks" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
