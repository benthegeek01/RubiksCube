Block[] toMiddle;  //INITIALISES BLOCK LIST

//IDENTIFIES ALL MIDDLE LAYER EDGE BLOCKS
Block[] getMiddleEdges() {
  boolean skip;
  int c = 0;
  Block[] toReturn = new Block[4];
  for (Block i : cube) {
    skip = false;
    if (i.matrix.m13 != 1) {
      if (abs(i.matrix.m03) + abs(i.matrix.m13) + abs(i.matrix.m23) == 2) {  //CHECKS IF IT IS AN EDGE BLOCK
        for (Face j : i.faces) {
          if (j.rendered && j.c == colours[5]) {
            skip = true;    //SKIPS IF ORANGE
          }
        }
        if (!skip) {
          if (!i.locked) {
            toReturn[c] = i;
            c++;
          }
        }
      }
    }
  }
  return toReturn;    //RETURNS ARRAY OF PERTINENT BLOCKS
}

//POPS OUT BLOCK FROM MIDDLE LAYER FOR USE IN THE TOP
String middleSwap(Block b) {
  String toReturn = "";
  PVector target = new PVector(0, 0, 0);    //INITIALISES DEFAULT TARGET
  if (b.matrix.m13 == -1) {
    for (Face i : b.faces) {
      if (i.rendered && i.normal.y == -1) {
        for (int j = 0; j < colours.length; j++) {
          if (i.c == colours[j]) {
            target = centres[j];    //SETS TARGET TO CENTRE OF COLOUR CENTRE NEEDED
          }
        }
      }
    }
    if (target.x == 1) {
      toReturn += "urURUFuf";
    } else if (target.x == -1) {
      toReturn += "ULulufUF";
    }

    pretendRead(b, toReturn);      //ADDS CORRECT ALGORITHM TO STRING
  } else if (b.matrix.m13 == 0) {
    if (b.matrix.m03 == 1) {
      toReturn += "urURUFuf";
    } else if (b.matrix.m03 == -1) {
      toReturn += "ULulufUF";
    }
  }
  pretendRead(b, toReturn);
  return toReturn;    //RETURNS IDENTIFIED STRING
}

//PUTS MIDDLE EDGE BLOCK INTO CORRECT POSITION IN LAYER
void middleEdge(Block a) {
  String alg = "";
  color c = 0;
  Block b = new Block(new PMatrix3D());
  b.matrix.translate(a.matrix.m03, a.matrix.m13, a.matrix.m23);
  b.locked = a.locked;
  for (int i = 0; i < b.faces.length; i++) {
    b.faces[i] = new Face(a.faces[i].c, a.faces[i].normal);
    if (a.faces[i].rendered) {
      b.faces[i].rendered = true;
    }
  }
  if (b.matrix.m13 == 0) {
    for (Face i : b.faces) {
      if (i.rendered) {
        c = i.c;
      }
    }
    alg += faceTheFront(b, c);      //ADDS CORRECT ALGORITHM TO STRING
    alg += middleSwap(b);
  }
  for (Face i : b.faces) {
    if (i.rendered && i.normal.y == 0) {
      c = i.c;
    }
  }
  alg += putAbove(b);
  alg += faceTheFront(b, c);
  alg += middleSwap(b);

  algorithm = alg;
  manual = false;    //DISABLES MANUAL MODE AND CARRIES OUT IDENTIFIED ALGORITHM
  a.locked = true;
}

//IMPLEMENTS ABOVE FUNCTIONS/ALGORITHMS AT CORRECT TIME
void middleLayer() {
  if (manual) {
    toMiddle = getMiddleEdges();
    middleEdge(toMiddle[15-count]);
    count++;
  }
}
