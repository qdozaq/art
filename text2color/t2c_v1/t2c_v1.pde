int framesize = 1080;
String text = "../harry_potter1_chapter1.txt";
  void setup(){
    // size(f);
    surface.setSize(framesize, framesize);
    // saveIncremental(block_img, "out", "jpg");
    // generate("../harry_potter1.txt");
   noLoop();
}

// int i =0;
// float x = 0;
// float y = 0;
void draw(){
  //  generateChars();
  //  generateLines();
  generateWords();
   saveIncremental("thing", "jpg");
}

void generateChars(){
   byte bytes[] = loadBytes(text);

   println(bytes.length);
   float coef = (float)framesize/sqrt(bytes.length);
   println(coef);
  float x = 0;
  float y = 0;

   for (int i = 0; i < bytes.length; i++) { 
      color c = (bytes[i] & 0xffff); 
      fill(c);
      rect(x, y, coef, coef);
      x+=coef;
      if(x > framesize){
        x = 0;
        y += coef;
      }
    } 
}

void generateWords(){
  String lines[] = loadStrings(text);
  println(lines[0].split(" ")[0]);

  //find number of words
  int numWords = 0;
  int avgWordLength = 0;
  int maxHexVal = 16777215;

  for(String line : lines){
    String words[] = line.split(" ");
    for(String word : words){
      if(word.length()>0){
        numWords++;
        avgWordLength += word.length();
      }
    }
  }

  avgWordLength /= numWords;

  int multiplier = (maxHexVal/127)/avgWordLength;
  float coef = (float)framesize/sqrt(numWords);
  float x = 0;
  float y = 0;

  for(String line : lines){
    String words[] = line.split(" ");
    for(String word : words){
      char chars[] = word.toCharArray();
      int num = 0;
      for(char ch : chars){
        num += int(ch);
      }
      //mod max color value ffffff
      color c = (num*multiplier)%maxHexVal;
      if(c == 0) continue;
      // println(hex(c));
      fill(red(c), green(c), blue(c));
      rect(x, y, coef, coef);
      x+=coef;
      if(x > framesize){
        x = 0;
        y += coef;
      }
      
    }
  }
}

void generateLines(){
  String lines[] = loadStrings(text);
  // println(lines[0].split(" ")[0]);

  int numLines = 0;
  int avgLineLength = 0;
  int maxHexVal = 16777215;


  for(String line: lines){
    if(line.length() > 0 ){
      numLines++;
      avgLineLength += line.length();
    }
  }

  avgLineLength /= numLines;

  int multiplier = (maxHexVal/127)/avgLineLength;
  float coef = (float)framesize/sqrt(numLines);
  float x = 0;
  float y = 0;

  for(String line : lines){
      char chars[] = line.toCharArray();
      int num = 0;
      for(char ch : chars){
        num += int(ch);
      }

      //mod max color value ffffff
      color c = (num*multiplier)%16777215;
      if(c == 0) continue;

      // println(hex(c));
      fill(red(c), green(c), blue(c));
      rect(x, y, coef, coef);
      x+=coef;
      if(x > framesize){
        x = 0;
        y += coef;
      }
      
  }
}