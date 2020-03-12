Block[] toRFace;  //INITIALISES BLOCK ARRAY
//IDENTIFIES RED CORNER BLOCKS
Block[] getRedFace() {
  Block[] toReturn = new Block[4];
  int tcount = 0;
  for (Block i : cube) {
    if (i.matrix.m13 == -1) {
      if (abs(i.matrix.m03) + abs(i.matrix.m23) == 2) {
        toReturn[tcount] = i;
        tcount++;
      }
    }
  }
  return toReturn;    //RETURNS ARRAY OF PERTINENT BLOCKS
}

//IDENTIFIES WHICH CORNER OF THE CUBE THE GIVEN BLOCK IS
String cornerID(Block[] a) {
  String toReturn = "";
  Block[] corners = new Block[4];
  int count;
  color tc = 0;
  Block result = new Block(new PMatrix3D());
  for (int i = 0; i < a.length; i++) {
    corners[i] = blockClone(a[i]);
  }
  for (int k = 0; k < 4; k++) {
    count = 0;
    for (Block i : corners) {
      pretendRead(i, "RUUruRur");    //ADDS CORRECT ALGORITHM TO THE STRING
    }
    for (Block i : corners) {
      for (Face j : i.faces) {
        if (j.rendered && j.c == -65536 && j.normal.y == -1) {
          count++;
        }
      }
    }
    for (Block i : corners) {
      pretendRead(i, "RUrURuurT");  //ADDS CORRECT ALGORITHM TO THE STRING
    }
    if (count == 1) {
      for (int i = 0; i < corners.length; i++) {
        if (corners[i].matrix.m03 == -1 && corners[i].matrix.m23 == 1) {
          result = blockClone(a[i]);
        }
      }
    }
  }
  for (Face i : result.faces) {
    if (i.rendered) {
      tc = i.c;
    }
  }
  toReturn += faceTheFront(result, tc);
  if (result.matrix.m03 == -1) {
    toReturn += "t";
  }
  toReturn += "RUUruRur";    //ADDS FINAL ALGORITHM TO STRING
  return toReturn;    //RETURNS IDENTIFIED STRING
}

//MOVES RED CORNERS IBNTO CORRECT POSITIONS
void redCorners() {
  String alg = "";
  int tcount = 0;
  Block[] temp = new Block[4];
  for (Block i : toRFace) {
    for (Face j : i.faces) {
      if (j.normal.y == -1 && j.c == colours[5]) {
        temp[tcount] = i;
        tcount++;    //COUNTS NUMBER OF RED CORNERS ON TOP
      }
    }
  }
  if (tcount == 4) {
    alg = "";
  } else if (tcount == 1) {    //DO X DEPENDING ON HOW MANY RED CORNERS
    color tc = 0;
    for (Face i : temp[0].faces) {
      if (i.rendered && i.c != colours[5]) {
        tc = i.c;
      }
    }
    Block t = blockClone(temp[0]);
    alg += faceTheFront(t, tc);
    if (t.matrix.m03 == -1) {
      alg += "t";
    }
    alg += "RUUruRur";
  } else if (tcount == 3) {
    alg += cornerID(toRFace);
  } else if (tcount == 0) {
    alg += cornerID(toRFace);
  } else if (tcount == 2) {
    alg += cornerID(toRFace);
  }
  algorithm = alg;
  manual = false;    //SETS ALGORITHM TO FOUND STRING AND DISABLES MANUAL MODE
}

void redFace() {
  if (manual) {
    toRFace = getRedFace();
    redCorners();
    count++;
  }
}
