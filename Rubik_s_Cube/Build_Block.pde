//CREATION OF 2D BLOCK FOR CUBE BUILDER
class Build_Block {
  float x, y;
  int colNum;
  Build_Block(float x, float y, int colNum) {
    this.x = x;
    this.y = y;
    this.colNum = colNum;
  }
  
  //DISPLAYS A SQUARE AT POS ON CUBE BUILDER WINDOW
  void show(PApplet appc, float px, float py) {
    appc.rectMode(CENTER);
    appc.pushMatrix();
    appc.translate(px, py);
    appc.fill(colours[colNum]);
    appc.square(x, y, 40);
    appc.popMatrix();
  }
  
  //CYCLES COLOUR OF 2D BLOCK
  void colourChange(PApplet appc) {
    if (colNum + 1 > 5) {
      colNum = 0;
    }
    else {
      colNum++;
    }
  }
}
