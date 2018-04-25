PImage og_img;
PImage block_img;
int block_size = 4;
int block_width = 5;
int block_height = 200;
  void setup(){
    size(800, 400);
    og_img = loadImage("./forest.jpg");
    og_img.loadPixels();
    block_img = og_img.get();
    block_img.updatePixels();
    surface.setSize(og_img.width, og_img.height);
    blockIt(block_width, block_height);
    saveIncremental(block_img, "out", "jpg");
}

void draw(){
  background(0);
  // image(img,0,0);
  image(block_img,0,0);
}

void blockIt(int bwidth, int bheight){
 for(int y = 0; y < block_img.height; ){
   for(int x = 0; x < block_img.width;){
     averageColor(x, y, bwidth, bheight);
     x += bwidth;
   }
    y += bheight;
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
      temp = block_img.get(j, i);
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