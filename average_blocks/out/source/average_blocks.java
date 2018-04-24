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

PImage img;
  public void setup(){
    
    img = loadImage("./citymosh.jpg");
    img.loadPixels();
    surface.setSize(img.width, img.height);
    // saveIncremental(sorted, "citymosh-sort", "jpg");
}

public void draw(){
  background(0);
  // image(img,0,0);
  image(img,0,0);
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
