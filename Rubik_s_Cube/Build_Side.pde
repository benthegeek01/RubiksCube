//CREATION OF GROUP OF 2D BLOCKS IN CUBE BUILDER
class Build_Side {
  Build_Block[] faces = new Build_Block[9];
  float x, y;
  int colNum;
  Build_Side(float x, float y, int colNum) {
    this.x = x;
    this.y = y;
    this.colNum = colNum;
    int count = 0;
    for (float i = -40; i < 41; i+= 40) {    //CREATES GROUP OF 9 2D BLOCKS
      for (float j = -40; j < 41; j+= 40) {
          faces[count] = new Build_Block(i, j, colNum);
          count++;
      }
    }
  }
  
  //DISPLAYS THE 3X3 GROUP OF 9 2D BLOCKS
  void show(PApplet appc) {
    for (Build_Block i : faces) {
      i.show(appc, this.x, this.y);
    }
  }
}
