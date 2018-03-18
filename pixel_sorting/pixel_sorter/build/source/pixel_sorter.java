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

public class pixel_sorter extends PApplet {

PImage finalImg, cutImg;
ArrayList<Integer> nonAlpha;
public void setup(){
    
    cutImg = loadImage("person-face.png");
    finalImg = loadImage("person-sm.jpg");
    nonAlpha = new ArrayList<Integer>();
    finalImg.loadPixels();
    cutImg.loadPixels();
    // finalImg = ogImg.get();
    finalImg.updatePixels();
    doit();
    surface.setSize(finalImg.width, finalImg.height);
    finalImg.save("final.jpg");
}

public void draw(){
  background(0);
  // image(img,0,0);
  image(finalImg,0,0);
}

public void doit(){
  println("doit");
  findNonAlphas();
  int[] naColors = new int[nonAlpha.size()];

  // for(int i = 0; i<naColors.length; i++){
  //   naColors[i] = finalImg.pixels[nonAlpha.get(i)];
  // }

  // color[] = vert(naColors, finalImg, nonAlpha.get(0), nonAlpha.get(nonAlpha.size()-1));
  // sortVertical(naColors, finalImg, nonAlpha.get(0), nonAlpha.get(nonAlpha.size()-1));
  // quicksort(naColors, 0, naColors.length-1);
  println("vert");
  int vertFinal[] = vert(cutImg);



  println("sort");
  // quicksort(vertFinal, 0, vertFinal.length-1);
  alphaSort(vertFinal, nonAlpha);

  println("unvert");
  unVert(vertFinal, finalImg);

}

public void findNonAlphas(){
  println("find");
    for(int i = 0; i < cutImg.pixels.length; i++){
      if(alpha(cutImg.pixels[i]) > 0 ){
          nonAlpha.add(i);
          // println("add");
      }
    }
}

public void alphaSort(int pixs[], ArrayList<Integer> alphas){
  for(int i=0; i<alphas.size(); i++){
      int r = round(random(150, 300)); int offset = alphas.get(i) - round(random(100));
      if(offset > 0 && offset+r < pixs.length){
        quicksort(pixs, offset, offset+r);
      }
      if(alphas.contains(offset+r)){
          i = alphas.indexOf(offset+r);
      }
  }
}
public void sortVertical(int pixs[], PImage ogImage, int low, int high){
  int[] newArr = vert(pixs, ogImage, low, high);
  int vertLow;
  quicksort(newArr, low, high);
  unVert(newArr, ogImage);
}

public int[] vert(PImage image){
  int vertArray[] = new int[image.pixels.length];
  // int i = 0;
  for(int x=0; x<image.width; x++){
      for(int y=0; y<image.height; y++){
          int i = (y*image.width) + x;
          vertArray[i] = image.get(y,x);
          // i++;
      }
  }
  return vertArray;
}

public int[] vert(int pixs[], PImage image, int low, int high){
  int vertArray[] = new int[pixs.length];

  int lowy = low % image.width;
  int lowx = floor(low/image.height);
  int highy = high % image.width;
  int highx = floor(high/image.height);

  int i = 0;
  for(int x=lowx; x<highx; x++){
      for(int y=lowy; y<highy; y++){
          vertArray[i] = (y*width) + x;
          i++;
      }
  }
  return vertArray;
}

public void unVert(int v[], PImage image){
  int x,y;
  for(int i = 0; i<v.length; i++){
    y = i % image.width;
    x = floor(i/image.height);
    image.set(x,y,v[i]);
  }
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
    String[] appletArgs = new String[] { "pixel_sorter" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
