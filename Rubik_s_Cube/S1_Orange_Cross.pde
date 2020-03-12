//FINDS ALL EDGE PIECES WITH RENDERED ORANGE ON
Block[] getOrangeEdges() {
  Block[] toReturn = new Block[4];
  int c = 0;
  for (Block i : cube) {
    if ((abs(i.matrix.m03) + abs(i.matrix.m23) + abs(i.matrix.m13) == 2)) {
      for (Face j : i.faces) {
        if ((j.c == colours[4]) && (j.rendered)) {
          toReturn[c] = i;
          c++;
        }
      }
    }
  }
  return toReturn;  //RETURNS LIST OF BLOCKS
}

//MOVES ORANGE EDGES TO SURROUND THE RED
void OToTop(Block b) {
  String alg = "";
  PMatrix3D m = b.matrix;
  PVector n = new PVector(0, 0, 0);
  for (Face i : b.faces) {
    if (i.rendered && (i.c == -23296)) {
      n = i.normal;
    }
  }
  if (m.m13 == 0) {
    if (n.z != 0) {
      alg += (char)(spinToMove(new Spin(round(m.m03), 0, 0, 0)) + 16 + -1 * n.z * 16);
    } else if (n.x != 0) {
      alg += (char)(spinToMove(new Spin(0, 0, round(m.m23), 0)) + 16 + -1 * n.x * 16);
    }
  } else if (m.m13 == -1) {
    if (n.z != 0) {
      alg += (char)(spinToMove(new Spin(0, 0, round(m.m23), 0)) + 16 + n.z * 16);
      alg += (char)(spinToMove(new Spin(round(-m.m13), 0, 0, 0)) + 16 + -1 * n.z * 16);
    } else if (n.x != 0) {
      alg += (char)(spinToMove(new Spin(round(m.m03), 0, 0, 0)) + 16 + n.x * 16);
      alg += (char)(spinToMove(new Spin(0, 0, round(m.m13), 0)) + 16 + n.x * 16);    //IDENTIFIES THE STRING OF MOVES THAT 
      //WILL PUT ORANGE ON THE TOP OF CUBE
    }
  } else if (m.m13 == 1) {
    if (n.y == 1) {
      if (m.m03 != 0) {
        alg += (char)(spinToMove(new Spin(round(m.m03), 0, 0, 0)));
        alg += (char)(spinToMove(new Spin(round(m.m03), 0, 0, 0)));
      } else if (m.m23 != 0) {
        alg += (char)(spinToMove(new Spin(0, 0, round(m.m23), 0)));
        alg += (char)(spinToMove(new Spin(0, 0, round(m.m23), 0)));
      }
    } else if (n.x != 0) {
      alg += (char)(spinToMove(new Spin(round(m.m03), 0, 0, 0)) + 16 + -1 * 16 * n.x);
      alg += (char)(spinToMove(new Spin(0, 0, round(m.m13), 0)) + 16 + -1 * n.x * 16);
    } else if (n.z != 0) {
      alg += (char)(spinToMove(new Spin(0, 0, round(m.m23), 0)) + 16 + -1 * 16 * n.z);
      alg += (char)(spinToMove(new Spin(round(m.m13), 0, 0, 0)) + 16 + -1 * n.z * 16);
    }
  }
  algorithm = oppoChar(alg);
  for (Block i : cube) {
    if (abs(i.matrix.m03) + abs(i.matrix.m13) + abs(i.matrix.m23) == 1) {
      for (Face j : i.faces) {
        if (j.rendered && j.c == colours[1]) {
          algorithm += faceTheFront(blockClone(i), j.c);
        }
      }
    }
  }
  isLocked = getLocked();
  manual = false;    //SETS ALGORITHM TO IDENTIFIED STRING, THEN DISABLES MANUAL MODE
}


//PUTS ORANGE BLOCKS BACK ON BOTTOM TO FORM CROSS
void OToBottom(Block b) {
  String alg = "";
  Face toMatch = new Face(0, new PVector(0, 0, 0));
  for (Face i : b.faces) {
    if ((i.rendered) && (i.normal.y != -1)) {
      toMatch = i;
    }
  }
  PVector matchV = new PVector(0, 0, 0);
  for (int i = 0; i < colours.length; i++) {
    if (colours[i] == toMatch.c) {
      matchV = centres[i];
    }
  }
  if (abs(matchV.x + b.matrix.m03) + abs(matchV.z + b.matrix.m23) == 0) {
    alg = "UU";
  } else if ((b.matrix.m03 - matchV.x == 0) && (b.matrix.m23 - matchV.z == 0)) {
    alg = "";
  } else if (matchV.x != 0) {
    alg += (char)(101 + -1 * b.matrix.m23 * matchV.x * 16);
  } else if (matchV.z != 0) {
    alg += (char)(101 + b.matrix.m03 * matchV.z * 16);
  }
  alg += spinToMove(new Spin(round(matchV.x), 0, round(matchV.z), 0));
  alg += spinToMove(new Spin(round(matchV.x), 0, round(matchV.z), 0));
  algorithm = alg;
  manual = false;    //SETS ALGORITHM TO IDENTIFIED STRING
}

//IMPLEMENTS ABOVE FUNCTIONS IN CORRERCT ORDER
void orangeCross() {
  if (manual && count < 4) {
    OToTop(toCross[count]);
    getLocked();
    if (count == 3) {
      if (lockNo == 4) {
        count++;
      } else {
        count = 0;
      }
    } else {
      count++;
    }
  } else if (manual && count < 8) {
    OToBottom(toCross[count-4]);
    count++;
  }
}
