void sortVertical(color pixs[], PImage ogImage, int low, int high){
  color[] newArr = vert(pixs, ogImage, low, high);
  int vertLow;
  quicksort(newArr, low, high);
  unVert(newArr, ogImage);
}

color[] vert(PImage image){
  color vertArray[] = new color[image.pixels.length];
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

color[] vert(color pixs[], PImage image, int low, int high){
  color vertArray[] = new color[pixs.length];

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

void unVert(color v[], PImage image){
  int x,y;
  for(int i = 0; i<v.length; i++){
    y = i % image.width;
    x = floor(i/image.height);
    image.set(x,y,v[i]);
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
