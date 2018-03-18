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
    int verted[] = vert(sorted);
    randSort(verted);
    unVert(sorted, verted);
    // randSort();
    // quicksort(sorted.pixels, 0, sorted.pixels.length-1);
    surface.setSize(sorted.width, sorted.height);
    sorted.save("sorted.jpg");
}

void draw(){
  background(0);
  // image(img,0,0);
  image(sorted,0,0);
}

void randSort(color pixs[]){
  for(int i=0; i< pixs.length; i++){
    int r = round(random(100));
    if(i + r < pixs.length && findAvg(pixs, i, i+r) < 180){
      quicksort(pixs, i, i+r);
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

color[] vert(PImage image){
  color vertArray[] = new color[image.pixels.length];
  int i = 0;
  for(int x=0; x<image.width; x++){
      for(int y=0; y<image.height; y++){
          vertArray[i] = image.get(x,y);
          i++;
      }
  }
  return vertArray;
}

void unVert(PImage image, color v[]){
  int x,y;
  for(int i = 0; i<v.length; i++){
    y = i % image.width;
    y = floor(i/image.height);
    image.set(x,y,v[i]);
  }
}

void to2(int index, PImage image){
  int x = index % image.width;
  int y = floor(index/image.height);
  // image.set(x,y,color)
}

void quicksort(color pixs[], int low, int high){
  if(low<high){
    int pi = partition(pixs, low, high);
    quicksort(pixs, low, pi -1);
    quicksort(pixs, pi+1, high);
  }
}

int partition(color pixs[], int low, int high){
  color pivot = pixs[high];
  int i = low -1;

  for(int j=low; j < high; j++){
    if(sortby(pixs[j], pivot)){
        i++;
        color temp = pixs[i];
        pixs[i] = pixs[j];
        pixs[j] = temp;
    }
  }
  color temp = pixs[i+1];
  pixs[i+1] = pixs[high];
  pixs[high] = temp;
  return i + 1;
}

boolean sortby(color a, color b){
  //brightness
  return brightness(a) <= brightness(b);
  //hue
  // return hue(a) <= hue(b);
}
