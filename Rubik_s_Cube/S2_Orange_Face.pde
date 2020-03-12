//IDENTIFIES CORNER BLOCKS WITH ORANGE ON
Block[] getOrangeCorners() {
  Block[] toReturn = new Block[4];
  int c = 0;
  for (Block i : cube) {
    if (abs(i.matrix.m03) + abs(i.matrix.m13) + abs(i.matrix.m23) == 3) {
      for (Face j : i.faces) {
        if ((j.rendered) && (j.c == colours[4])) {
          if (!i.locked) {
            toReturn[c] = i;
            c++;
          }
        }
      }
    }
  }
  return toReturn;  //RETURNS LIST OF CORNER BLOCKS
}

//PUTS GIVEN BLOCK BETWEEN ITS TWO COLOUR CENTRES
String betweenCentres(Block b) {
  PVector target = new PVector(0, -1, 0);
  PVector centre1 = new PVector(0, 0, 0);
  PVector centre2 = new PVector(0, 0, 0);
  String toReturn = "";
  for (Face i : b.faces) {
    if (i.rendered && (i.c != colours[4])) {
      for (int j = 0; j < colours.length; j++) {
        if (colours[j] == i.c && centre1.mag() == 0) {
          centre1 = centres[j];
        } else if (colours[j] == i.c) {
          centre2 = centres[j];      //IDENTIFIES COLOURS OF TWO FACES ON BLOCK
        }
      }
    }
  }
  target.x = centre1.x + centre2.x;
  target.z = centre1.z + centre2.z;
  toReturn += spinDir(target, new PVector(b.matrix.m03, b.matrix.m13, b.matrix.m23));
  pretendRead(b, toReturn);
  return toReturn;    //RETURNS IDENTIFIED STRING
}

//CHECKS IF GIVEN BLOCK IS IN THE CORRECT PLACE
boolean checkDone(Block b) {
  boolean toReturn;
  PVector target = new PVector(0, 1, 0);
  PVector centre1 = new PVector(0, 0, 0);    //INITIALISE DEFAULT TARGETS
  PVector centre2 = new PVector(0, 0, 0);
  for (Face i : b.faces) {
    if (i.rendered && (i.c != colours[4])) {
      for (int j = 0; j < colours.length; j++) {
        if (colours[j] == i.c && centre1.mag() == 0) {
          centre1 = centres[j];
        } else if (colours[j] == i.c) {    //REDEFINE TARGETS (THE TWO CENTRES)
          centre2 = centres[j];
        }
      }
    }
  }
  target.x = centre1.x + centre2.x;
  target.z = centre1.z + centre2.z;
  if (target.x == b.matrix.m03 && target.y == b.matrix.m13 && target.z == b.matrix.m23) {  //CHECKS IF TARGET AND CENTRE ARE THE SAME
    return true;    
  } else {
    return false;
  }
}

//RETURNS RIGHT OR LEFT ALGORITHM DEPENDING ON POSITION OF GIVEN BLOCK
String rightOrLeft(Block b) {
  if (b.matrix.m03 == 1) {
    pretendRead(b, "urUR");
    return "urUR";
  } else if (b.matrix.m03 == -1) {
    pretendRead(b, "ULul");
    return "ULul";
  } else {
    return "";
  }
}


//SPINS BLOCK TO GIVEN TARGET DEPENDING ON CURRENT POSITION
String spinDir(PVector target, PVector pos) {
  String toReturn = "";
  if (target.x == pos.x && target.z == pos.z) {
    toReturn = "";
  } else if (target.x != pos.x && target.z != pos.z) {
    toReturn += "uu";
  } else if (target.x == pos.x) {
    toReturn += (char)(101 + 16 * pos.x * target.z);
  } else if (target.z == pos.z) {
    toReturn += (char)(101 + 16 * pos.x * target.z);
  }
  return toReturn;    //RETURNS STRING OF MOVES
}


//MOVES ORANGE CORNER INTO THE CORRECT PLACE
void orangeCorner(Block a) {
  a.locked = true;
  String alg = "";
  Face f = new Face(0, new PVector(0, 0, 0));
  Block b = blockClone(a);
  for (Face i : b.faces) {
    if (i.c == colours[4]) {    //IDENTIFIES IMPORTANT FACE ON BLOCK
      f = i;
    }
  }
  if (b.matrix.m13 == 1) {      //DOES DIFFERENT THINGS DEPENDING ON Y-POSITION OF BLOCK
    if (f.normal.y == 0) {
      alg += faceTheFront(b, colours[4]);
      alg += rightOrLeft(b);
      alg += betweenCentres(b);
      alg += faceTheFront(b, colours[4]);
      alg += rightOrLeft(b);
    } else if (f.normal.y == 1) {
      if (!checkDone(b)) {
        color c = 0;
        for (Face i : b.faces) {
          if (i.rendered && i.c != colours[4]) {
            c = i.c;
          }
        }
        alg += faceTheFront(b, c);
        alg += rightOrLeft(b);
        alg += betweenCentres(b);
        alg += faceTheFront(b, colours[4]);
        alg += rightOrLeft(b);
      } else {
        alg = "";
      }
    }
  } else if (b.matrix.m13 == -1) {
    if (f.normal.y == 0) {
      alg += betweenCentres(b);
      alg += faceTheFront(b, colours[4]);
      alg += rightOrLeft(b);
    } else {
      alg += betweenCentres(b);
      alg += faceTheFront(b, colours[4]);
      alg += rightOrLeft(b);
      alg += rightOrLeft(b);
      alg += rightOrLeft(b);
    }
  }
  algorithm = alg;
  manual = false;    //DISABLES MANUAL MODE AND CARRIES OUT ALGORITHM FOUND
}

//CHECKS THAT STEP IS COMPLETE
boolean check(Block b) {
  boolean toReturn = false;
  if (abs(b.matrix.m03) + abs(b.matrix.m13) + abs(b.matrix.m23) == 3) {
    if (b.matrix.m13 == 1) {
      for (Face i : b.faces) {
        if (i.rendered) {
          for (int j = 0; j < colours.length; j++) {
            if (i.c == colours[j]) {
              if (centres[j] == i.normal) {
                toReturn = true;
              }
            }
          }
        }
      }
    }
  }
  return toReturn;
} 

//IMPLEMENTS ABOVE FUNCTIONS/ALGORITHMS
void orangeFace() {
  if (manual) {
    toCorner = getOrangeCorners();
    orangeCorner(toCorner[11 - count]);
    count++;
  }
}
