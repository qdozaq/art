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

public class pixel_sort_vert extends PApplet {

PImage img;
PImage sorted;
  public void setup(){
    
    img = loadImage("../lake_small.jpg");
    sorted = createImage(img.width,img.height,RGB);
    sorted.loadPixels();
    img.loadPixels();
    sorted = img.get();
    sorted.updatePixels();
    int verted[] = vert(sorted);
    randSort(verted);
    unVert(sorted, verted);
    // randSort();
    // quicksort(sorted.pixels, 0, sorted.pixels.length-1);
    surface.setSize(sorted.width, sorted.height);
    sorted.save("sorted.jpg");
}

public void draw(){
  background(0);
  // image(img,0,0);
  image(sorted,0,0);
}

public void randSort(int pixs[]){
  for(int i=0; i< pixs.length; i++){
    int r = round(random(100));
    if(i + r < pixs.length && findAvg(pixs, i, i+r) < 180){
      quicksort(pixs, i, i+r);
      i += r;
    }
  }
}

public int findAvg(int pixs[], int low, int high){
  int avg = 0;
  for(int i = low; i< high; i++){
    avg+= brightness(pixs[i]);
  }
  // println(avg/pixs.length);
  return avg/(high-low+1);
}

public int[] vert(PImage image){
  int vertArray[] = new int[image.pixels.length];
  int i = 0;
  for(int x=0; x<image.width; x++){
      for(int y=0; y<image.height; y++){
          vertArray[i] = image.get(x,y);
          i++;
      }
  }
  return vertArray;
}

public void unVert(PImage image, int v[]){
  int x,y;
  for(int i = 0; i<v.length; i++){
    y = i % image.width;
    x = floor(i/image.height);
    image.set(x,y,v[i]);
  }
}

public void to2(int index, PImage image){
  int x = index % image.width;
  int y = floor(index/image.height);
  // image.set(x,y,color)
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
  public void settings() {  size(800, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "pixel_sort_vert" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
