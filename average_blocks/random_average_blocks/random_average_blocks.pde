PImage og_img;
PImage block_img;
int block_size = 4;
int block_width = 200;
int block_height = 200;
  void setup(){
    size(500, 500);
    og_img = loadImage("./guy.jpg");
    og_img.loadPixels();
    // block_img = og_img.get();
    // block_img.updatePixels();
    block_img = createImage(og_img.width, og_img.height, ARGB);
    block_img.loadPixels();
    //surface.setSize(og_img.width, og_img.height);
    // blockIt(block_width, block_height);
    // fillImage();
    blockIt(32, 32);
    blockIt(200, 100);
    blockItSparse(500, 100);
    // blockItSparse(100, 32);
    // blockIt(100, 20);
    // blockIt(200, 300);
    saveIncremental(block_img, "out", "jpg");
}

void draw(){
  background(0);
  image(block_img,0,0,500, 500);
}

void blockIt(int bwidth, int bheight){
int bwr=0, bhr=0;
 for(int y = 0; y < block_img.height; ){
   for(int x = 0; x < block_img.width;){
     bwr = (int)random(1,bwidth);
     bhr = (int)random(1,bheight);
     averageColor(x, y, bwr, bhr);
     bwr = (int)random(1,bwidth);
     x += bwr;
   }
    bhr = (int)random(1,bheight);
    y += bhr;
 } 
}

void blockItSparse(int bwidth, int bheight){
int bwr=0, bhr=0;
 for(int y = 0; y < block_img.height; ){
   for(int x = 0; x < block_img.width;){
     bwr = (int)random(1,bwidth);
     bhr = (int)random(1,bheight);
     averageColor(x, y, bwr, bhr);
     bwr = (int)random(200, 1000);
     x += bwr;
   }
    bhr = (int)random(200, 1000);
    y += bhr;
 } 
}

void averageColor(int x, int y, int bwidth, int bheight){
  float r,g,b;
  r=g=b=0;
  color temp = 0;
  int ybound = y + bheight;
  int xbound = x + bwidth;
  for(int i=y; i < ybound && i < block_img.height; i++){
    for(int j = x; j < xbound && j < block_img.width; j++){
      temp = og_img.get(j, i);
      r += temp >> 16 & 0xFF;
      g += temp >> 8 & 0xFF;
      b += temp & 0xFF;
    }
  }

  r = r/(bwidth*bheight);
  g = g/(bwidth*bheight);
  b = b/(bwidth*bheight);

  for(int i=y; i < ybound && i < block_img.height; i++){
    for(int j = x; j < xbound && j < block_img.width; j++){
      block_img.set(j, i, color(r,g,b));
    }
  }
}

void fillImage(){
  float r,g,b;
  r=g=b=0;
  color temp; 
  for(int i = 0; i < og_img.pixels.length; i++){
    temp = og_img.pixels[i];
    r += temp >> 16 & 0xFF;
    g += temp >> 8 & 0xFF;
    b += temp & 0xFF;
  }

  int d = og_img.height* og_img.width;
  r = r/d;
  g = g/d;
  b = b/d;

  for(int i = 0; i < og_img.pixels.length; i++){
    block_img.pixels[i] = color(r,g,b);
  }
}
