PImage img1;
PImage img2;
PImage sorted;
  void setup(){
    size(800, 400);
    img1 = loadImage("nature-crop.jpg");
    img2 = loadImage("machine-crop.jpg");

    sorted = createImage(img1.width,img1.height,RGB);
    sorted.loadPixels();
    img1.loadPixels();
    sorted = img1.get();
    sorted.updatePixels();
    bit2();
    randSort();
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
    int r = round(random(100, 500));
    if(i + r < sorted.pixels.length && brightness(sorted.pixels[i]) > 150){
      quicksort(sorted.pixels, i, i+r);
    }
    i += r;
  }
}

void bit2(){
  for(int i=0; i< sorted.pixels.length; i++){
    if(brightness(img1.pixels[i]) > brightness(img2.pixels[i])){
      sorted.pixels[i] = img1.pixels[i] | img2.pixels[i];
    }else{
      sorted.pixels[i] = img1.pixels[i] & img2.pixels[i];
    }
  }
}

void bit(){
  // for(int i=0; i< sorted.pixels.length; i++){
  //   sorted.pixels[i] = img1.pixels[i] & img2.pixels[i];
  // }
  int i = 0;
  int j = sorted.pixels.length -1;
  while(i<j){
    sorted.pixels[i] = img1.pixels[i] & img2.pixels[j];
    i++;
    j--;
  }
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



// void bit(color pixs[], int low, int high){
//   int i = low;
//   int j = high;
//   while(i < j){
//     color newc = pixs[i] | pixs[j];
//     pixs[i] = newc;
//     pixs[j] = newc >> 2;
//     i++;
//     j--;
//   }
// }
