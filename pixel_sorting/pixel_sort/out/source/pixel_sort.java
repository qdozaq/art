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

public class pixel_sort extends PApplet {

PImage img;
PImage sorted;
  public void setup(){
    
    img = loadImage("./beach-crop.jpg");
    sorted = createImage(img.width,img.height,RGB);
    sorted.loadPixels();
    img.loadPixels();
    sorted = img.get();
    sorted.updatePixels();
    randSort();
    // quicksort(sorted.pixels, 0, sorted.pixels.length-1);
    surface.setSize(sorted.width, sorted.height);
    // sorted.save("citymosh-sorted-dark3.jpg");
    saveIncremental(sorted, "citymosh-sort", "jpg");
}

public void draw(){
  background(0);
  // image(img,0,0);
  image(sorted,0,0);
}

//for every random amount of pixels in a row
//if their average brightness is above a certain amount sort
public void randSort(){
  int max_sorted = 200;
  int avg_thresh = 180;
  for(int i=0; i< sorted.pixels.length; i++){
    int r = round(random(max_sorted));
    if(i + r < sorted.pixels.length && findAvg(sorted.pixels, i, i+r) < avg_thresh){
      quicksort(sorted.pixels, i, i+r);
      i += r;
    }
  }
}

public int findAvg(int pixs[], int low, int high){
  float avg = 0;
  for(int i = low; i< high; i++){
    avg+= brightness(pixs[i]);
    // avg+= pixs[i] & 0xFF;
  }
  // println(avg/pixs.length);
  return (int)avg/(high-low+1);
}
public void quicksort(int pixs[], int low, int high){
  if(low<high){
    int pi = partition(pixs, low, high);
    quicksort(pixs, low, pi -1);
    quicksort(pixs, pi+1, high);
  }
}

public int partition(int pixs[], int low, int high){
  int pivot = pixs[high];
  int i = low -1;

  for(int j=low; j < high; j++){
    if(sortby(pixs[j], pivot)){
        i++;
        int temp = pixs[i];
        pixs[i] = pixs[j];
        pixs[j] = temp;
    }
  }
  int temp = pixs[i+1];
  pixs[i+1] = pixs[high];
  pixs[high] = temp;
  return i + 1;
}

public boolean sortby(int a, int b){
  //brightness
  return brightness(a) <= brightness(b);
  //hue
  // return hue(a) <= hue(b);
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
    String[] appletArgs = new String[] { "pixel_sort" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
