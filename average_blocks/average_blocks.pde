PImage img;
  void setup(){
    size(800, 400);
    img = loadImage("./citymosh.jpg");
    img.loadPixels();
    surface.setSize(img.width, img.height);
    // saveIncremental(sorted, "citymosh-sort", "jpg");
}

void draw(){
  background(0);
  // image(img,0,0);
  image(img,0,0);
}
