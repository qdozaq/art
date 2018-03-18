PImage finalImg, cutImg;
ArrayList<Integer> nonAlpha;
void setup(){
    size(800, 400);
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

void draw(){
  background(0);
  // image(img,0,0);
  image(finalImg,0,0);
}

void doit(){
  println("doit");
  findNonAlphas();
  color[] naColors = new color[nonAlpha.size()];

  // for(int i = 0; i<naColors.length; i++){
  //   naColors[i] = finalImg.pixels[nonAlpha.get(i)];
  // }

  // color[] = vert(naColors, finalImg, nonAlpha.get(0), nonAlpha.get(nonAlpha.size()-1));
  // sortVertical(naColors, finalImg, nonAlpha.get(0), nonAlpha.get(nonAlpha.size()-1));
  // quicksort(naColors, 0, naColors.length-1);
  println("vert");
  color vertFinal[] = vert(cutImg);



  println("sort");
  // quicksort(vertFinal, 0, vertFinal.length-1);
  alphaSort(vertFinal, nonAlpha);

  println("unvert");
  unVert(vertFinal, finalImg);

}

void findNonAlphas(){
  println("find");
    for(int i = 0; i < cutImg.pixels.length; i++){
      if(alpha(cutImg.pixels[i]) > 0 ){
          nonAlpha.add(i);
          // println("add");
      }
    }
}

void alphaSort(color pixs[], ArrayList<Integer> alphas){
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

class pixel{
  color c; int x,y,index;
  pixel(color c, int x, int y, int i){
    this.c = c;
    this.x = x;
    this.y = y;
    this.index = i;
  }  
}
