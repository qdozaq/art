// Saves a file with automatically incrementing filename,
// so that existing files are not overwritten. Will 
// function correctly for less than 1000 files.

void saveIncremental(String prefix,String extension) {
  int savecnt=0;
  boolean ok=false;
  String filename="";
  File f;
  
  while(!ok) {
    // Get a correctly configured filename
    filename=prefix;  
    if(savecnt<10) filename+="00";
    else if(savecnt<100) filename+="0";
    filename+=""+savecnt+"."+extension;

    // Check to see if file exists, using the undocumented
    // savePath() to find sketch folder
    f=new File(savePath(filename));
    if(!f.exists()) ok=true; // File doesn't exist
    savecnt++;
  }

  println("Saving "+filename);
  save(filename);
}
