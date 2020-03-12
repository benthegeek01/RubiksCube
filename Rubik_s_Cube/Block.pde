//CREATION OF CUSTOM BLOCK CLASS
class Block {
  PMatrix3D matrix;
  boolean locked;
  Face[] faces = new Face[6];
  //INITIALISATION FUNCTION      
  Block(PMatrix3D matrix) {
    this.locked = false;
    this.matrix = matrix;
    this.faces[0] = new Face(colours[0], new PVector(0, 0, -1)); //WHITE
    this.faces[1] = new Face(colours[1], new PVector(0, 0, 1));  //YELLOW
    this.faces[2] = new Face(colours[2], new PVector(-1, 0, 0));  //GREEN
    this.faces[3] = new Face(colours[3], new PVector(1, 0, 0)); //BLUE
    this.faces[4] = new Face(colours[4], new PVector(0, 1, 0));  //ORANGE
    this.faces[5] = new Face(colours[5], new PVector(0, -1, 0)); //RED
    float comparethis, comparenum;
    comparenum = 0;
    comparethis = 0;
    //PREPARES FOR VISIBILITY CHECK
    for (Face i : faces) {
      float[] temp = {i.normal.x, i.normal.y, i.normal.z};
      for (int j = 0; j < temp.length; j++) {
        if (temp[j] != 0) {
          comparenum = j;
          comparethis = temp[j];
        }
      }
      //CHECKS WHICH FACES ARE VISIBLE TO THE USER
      switch (round(comparenum)) {
          case 0:
            if (matrix.m03 == comparethis) {
              i.rendered = true;  
            }
            break;
          case 1:
            if (matrix.m13 == comparethis) {
              i.rendered = true;  
            }
            break;
          case 2:
            if (matrix.m23 == comparethis) {
              i.rendered = true;  
            }
        }
      }
    }
  
  //DISPLAYS A CUBE WITH FACES SURROUNDING IT AT MATRIX POSITION
  void show() {
    pushMatrix();
    applyMatrix(matrix);
    for (Face f : faces) {
      if (f.rendered) {
        f.show();
      } else {
        f.c = edgeColour;
        f.show();
      }
    }
    strokeWeight(map(size, 3, 15, 0.2, 0.01));
    stroke(edgeColour);
    noFill();
    box(1);
    popMatrix();
  }
  
  //UPDATES MATRIX POSITION TO NEW X, Y AND Z
  void update(float x, float y, float z) {
    matrix.reset();
    matrix.translate(x, y, z);
  }
  
  //CALLS TURN FUNCTION ON ALL FACES OF BLOCK
  void turn(float angle, int axis, float dir) {
    for (Face i : faces) {
      i.turn(angle, axis, dir);
    }
  }
  
  //ROUNDS ALL MATRIX VALUES
  void reset() {
    matrix.m00 = round(matrix.m00);
    matrix.m01 = round(matrix.m01);
    matrix.m02 = round(matrix.m02); 
    matrix.m10 = round(matrix.m10);
    matrix.m11 = round(matrix.m11);
    matrix.m12 = round(matrix.m12);
    matrix.m20 = round(matrix.m20);
    matrix.m21 = round(matrix.m21);
    matrix.m22 = round(matrix.m22);
    matrix.m03 = round(matrix.m03);
    matrix.m13 = round(matrix.m13);
    matrix.m23 = round(matrix.m23);
  }
  
}
