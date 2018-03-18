PImage img;
PImage sorted;
PImage finalImg;
ArrayList<Integer> nonAlpha;
  void setup(){
    size(800, 400);
    img = loadImage("person-face.png");
    finalImg = loadImage("person-sm.jpg");
    sorted = createImage(img.width,img.height,RGB);
    sorted.loadPixels();
    img.loadPixels();
    sorted = img.get();
    sorted.updatePixels();
    nonAlpha = new ArrayList<Integer>();
    doit();
    // randSort();
    // quicksort(sorted.pixels, 0, sorted.pixels.length-1);
    surface.setSize(sorted.width, sorted.height);
    sorted.save("sorted.png");
    finalImg.save("final.png");
}

void draw(){
  background(0);
  // image(img,0,0);
  image(finalImg,0,0);
}

void doit(){
  findNonAlphas();

  color[] colors = new color[nonAlpha.size()];

  for(int i = 0; i<colors.length; i++){
    colors[i] = sorted.pixels[nonAlpha.get(i)];
  }

  // quicksort(colors, 0, colors.length-1);
  randSort(colors);

  for(int i = 0; i<colors.length; i++){
    sorted.pixels[nonAlpha.get(i)] = colors[i];
    finalImg.pixels[nonAlpha.get(i)] = colors[i];
  }
}



void findNonAlphas(){
    for(int i = 0; i < sorted.pixels.length; i++){
      if(alpha(sorted.pixels[i]) > 0 ){
          nonAlpha.add(i);
      }
    }
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
