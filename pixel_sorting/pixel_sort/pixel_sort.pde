PImage img;
PImage sorted;
  void setup(){
    size(800, 400);
    img = loadImage("../lake_small.jpg");
    sorted = createImage(img.width,img.height,RGB);
    sorted.loadPixels();
    img.loadPixels();
    sorted = img.get();
    sorted.updatePixels();
    randSort();
    // quicksort(sorted.pixels, 0, sorted.pixels.length-1);
    surface.setSize(sorted.width, sorted.height);
    sorted.save("sorted.jpg");
}

void draw(){
  background(0);
  // image(img,0,0);
  image(sorted,0,0);
}

void randSort(){
  for(int i=0; i< sorted.pixels.length; i++){
    int r = round(random(500));
    if(i + r < sorted.pixels.length && findAvg(sorted.pixels, i, i+r) < 180){
      quicksort(sorted.pixels, i, i+r);
      i += r;
    }
  }
}

int findAvg(color pixs[], int low, int high){
  int avg = 0;
  for(int i = low; i< high; i++){
    avg+= brightness(pixs[i]);
  }
  // println(avg/pixs.length);
  return avg/(high-low+1);
}
