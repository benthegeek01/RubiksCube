//CREATES CUSTOM FACE OBJECT
class Face {
  PVector normal;
  color c;
  boolean rendered;
  //INITIALISATION FUNCTION
  Face(color c, PVector normal) { 
    this.normal = normal;
    this.c = c;
    this.rendered = false;
  }
  
  //DISPLAYS A SQUARE IN 3D SPACE IN CORRECT PLACE OVER BLOCK
  void show() {
    rectMode(CENTER);
    pushMatrix();
    translate(0.5*normal.x, 0.5*normal.y, 0.5*normal.z);
    fill(c);
    if (abs(normal.x) > 0) { 
      rotateY(HALF_PI);
    } else if (abs(normal.y) > 0) {
      rotateX(HALF_PI);
    } else if (abs(normal.z) > 0) {    //ROTATES SQUARE TO CORRECT ORIENTATION
      rotateZ(HALF_PI);
    }
    square(0, 0, 1);
    noFill();
    popMatrix();    //DRAWS SQUARE
  }
  
  //TURNS FACE AROUND BLOCK IT IS LINKED
  void turn(float angle, int axis, float dir) {
    PVector temp = new PVector();
    switch (axis) {
      case 1:
        temp.x = round(normal.x);
        temp.y = round(cos(angle) * normal.y - dir * sin(angle) * normal.z);
        temp.z = round(dir * sin(angle) * normal.y + cos(angle) * normal.z);    //CARRIES OUT 3D MATRIX TRANSFORMATION DEPENDING ON POSITION ON CUBE
        break;
      case 2:
        temp.x = round(cos(angle) * normal.x - dir * sin(angle) * normal.z);
        temp.y = round(normal.y);
        temp.z = round(dir * sin(angle) * normal.x + cos(angle) * normal.z);
        break;
      case 3:
        temp.x = round(cos(angle) * normal.x - dir * sin(angle) * normal.y);
        temp.y = round(dir * sin(angle) * normal.x + cos(angle) * normal.y);
        temp.z = round(normal.z);
    }
    normal = temp;
    
  }
}
