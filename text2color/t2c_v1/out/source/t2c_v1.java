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

public class t2c_v1 extends PApplet {

int framesize = 1080;
String text = "../harry_potter1_chapter1.txt";
  public void setup(){
    // size(f);
    surface.setSize(framesize, framesize);
    // saveIncremental(block_img, "out", "jpg");
    // generate("../harry_potter1.txt");
   noLoop();
}

// int i =0;
// float x = 0;
// float y = 0;
public void draw(){
  //  generateChars();
  //  generateLines();
  generateWords();
   saveIncremental("thing", "jpg");
}

public void generateChars(){
   byte bytes[] = loadBytes(text);

   println(bytes.length);
   float coef = (float)framesize/sqrt(bytes.length);
   println(coef);
  float x = 0;
  float y = 0;

   for (int i = 0; i < bytes.length; i++) { 
      int c = (bytes[i] & 0xffff); 
      fill(c);
      rect(x, y, coef, coef);
      x+=coef;
      if(x > framesize){
        x = 0;
        y += coef;
      }
    } 
}

public void generateWords(){
  String lines[] = loadStrings(text);
  println(lines[0].split(" ")[0]);

  //find number of words
  int numWords = 0;
  int avgWordLength = 0;
  int maxHexVal = 16777215;

  for(String line : lines){
    String words[] = line.split(" ");
    for(String word : words){
      if(word.length()>0){
        numWords++;
        avgWordLength += word.length();
      }
    }
  }

  avgWordLength /= numWords;

  int multiplier = (maxHexVal/127)/avgWordLength;
  float coef = (float)framesize/sqrt(numWords);
  float x = 0;
  float y = 0;

  for(String line : lines){
    String words[] = line.split(" ");
    for(String word : words){
      char chars[] = word.toCharArray();
      int num = 0;
      for(char ch : chars){
        num += PApplet.parseInt(ch);
      }
      //mod max color value ffffff
      int c = (num*multiplier)%maxHexVal;
      if(c == 0) continue;
      // println(hex(c));
      fill(red(c), green(c), blue(c));
      rect(x, y, coef, coef);
      x+=coef;
      if(x > framesize){
        x = 0;
        y += coef;
      }
      
    }
  }
}

public void generateLines(){
  String lines[] = loadStrings(text);
  // println(lines[0].split(" ")[0]);

  int numLines = 0;
  int avgLineLength = 0;
  int maxHexVal = 16777215;


  for(String line: lines){
    if(line.length() > 0 ){
      numLines++;
      avgLineLength += line.length();
    }
  }

  avgLineLength /= numLines;

  int multiplier = (maxHexVal/127)/avgLineLength;
  float coef = (float)framesize/sqrt(numLines);
  float x = 0;
  float y = 0;

  for(String line : lines){
      char chars[] = line.toCharArray();
      int num = 0;
      for(char ch : chars){
        num += PApplet.parseInt(ch);
      }

      //mod max color value ffffff
      int c = (num*multiplier)%16777215;
      if(c == 0) continue;

      // println(hex(c));
      fill(red(c), green(c), blue(c));
      rect(x, y, coef, coef);
      x+=coef;
      if(x > framesize){
        x = 0;
        y += coef;
      }
      
  }
}
// Saves a file with automatically incrementing filename,
// so that existing files are not overwritten. Will 
// function correctly for less than 1000 files.

public void saveIncremental(String prefix,String extension) {
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
  save(filename);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "t2c_v1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
