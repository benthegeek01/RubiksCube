//CYCLES TOP EDGES AROUND CUBE ONCE
void edgeCycle() {
  int buff = 0;
  String alg = "";
  PVector[] potentials = betweenLights();
  Block a = new Block(new PMatrix3D());
  Block b = new Block(new PMatrix3D());
  PMatrix3D temp = new PMatrix3D();
  temp.translate(10, 10, 10);
  Block target = new Block(temp);
  for (PVector i : potentials) {
    for (Block j : cube) {
      if (j.matrix.m13 == -1) {
        if (j.matrix.m03 == i.x && j.matrix.m23 == i.z) {
          a = j;
        } else {
          if (i.x == 0) {
            if (abs(j.matrix.m03) == 1 && j.matrix.m23 == i.z) {  //CHECKS IF COLOURS ARE SAME ACROSS TOP LINE OF SIDE
              b = j;
            }
          } else if (i.z == 0) {
            if (abs(j.matrix.m23) == 1 && j.matrix.m03 == i.x) {
              b = j;
            }
          }
        }
      }
    }
    for (Face j : a.faces) {
      if (j.normal.y == 0 && j.rendered) {
        for (Face k : b.faces) {
          if ((round(j.normal.x) == round(k.normal.x) && round(j.normal.y) == round(k.normal.y) && round(j.normal.z) == round(k.normal.z)) && k.rendered && k.c == j.c) {
            target = blockClone(a);    //IDENTIFIES LINE OF SIMILAR COLOURS AND SETS CENTRE AS TARGET
            buff++;
          }
        }
      }
    }
  }
  if (buff < 2) {
    for (Face i : target.faces) {
      if (i.normal.y == 0 && i.rendered) {
        alg += putAbove(target);
        alg += faceTheFront(target, i.c);
      }  //FACES TARGET TO THE FRONT
    }
    if (target.matrix.m03 == 10) {
      alg += "rUrururURUrr";
    } else {
      alg += "ttrUrururURUrr";    //USES CYCLE ALGORITHM TO CYCLE EDGES
    }
  }
  alg += "u";
  algorithm = alg;
  manual = false;  //SETS ALGORITHM TO STRING AND DISABLES MANUAL MODE
}

//IMPLEMENTS ABOVE ALGORITHMS AND FUNCTIONS
void finishHim() {
  if (manual) {
    headlights = getLights();
    edgeCycle();
    count++;
  }
}
