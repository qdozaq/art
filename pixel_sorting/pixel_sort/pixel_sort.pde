PImage img;
PImage sorted;
  void setup(){
    size(800, 400);
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

void draw(){
  background(0);
  // image(img,0,0);
  image(sorted,0,0);
}

//for every random amount of pixels in a row
//if their average brightness is above a certain amount sort
void randSort(){
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

int findAvg(color pixs[], int low, int high){
  float avg = 0;
  for(int i = low; i< high; i++){
    avg+= brightness(pixs[i]);
    // avg+= pixs[i] & 0xFF;
  }
  // println(avg/pixs.length);
  return (int)avg/(high-low+1);
}
