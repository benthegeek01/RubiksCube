Block[] toRCross;

//IDENTIFIES EDGE BLOCKS WITH RED ON THEM
Block[] getRedCross() {
  Block[] toReturn = new Block[4];
  int tcount = 0;
  for (Block i : cube) {
    if (i.matrix.m13 == -1) {
      if (abs(i.matrix.m03) + abs(i.matrix.m23) == 1) {
        toReturn[tcount] = i;
        tcount++;
      }
    }
  }
  return toReturn;  //RETURNS ARRAY OF BLOCKS
}

//CYCLES RED CROSS ON THE TOP
void crossCycle() {
  String alg = "";
  int tcount = 0;
  Block p = new Block(new PMatrix3D());
  Block q = new Block(new PMatrix3D());    //INITALISES TEMPORARY BLOCKS
  Block[] temp = new Block[4];
  for (Block i : toRCross) {
    for (Face j : i.faces) {
      if (j.normal.y == -1) {
        if (j.c == colours[5]) {
          temp[tcount] = i;    //COUNTS HOW MANY EDGES ARE ON TOP
          tcount++;
        }
      }
    }
  }
  if (tcount > 0) {
    p = blockClone(temp[0]);
    q = blockClone(temp[1]);  //CLONES BLOCKS
  }
  if (tcount == 0) {
    alg = "fruRUF";
  } else if (tcount == 4) {    //FINISHED IF 4 EDGES ON TOP
    alg = "";
  } else if (tcount == 2) {
    if ((p.matrix.m03 == q.matrix.m03) || (p.matrix.m23 == q.matrix.m23)) {
      for (Face i : p.faces) {  
        if (i.rendered && i.c != colours[5]) {    //CHECKS IF PATTERN IS LINE OR L-SHAPE
          alg += faceTheFront(p, i.c);
          alg += 'T';
        }
      }
      alg += "fruRUF";    //ADDS ALGORITHM IF L SHAPE
    } else {
      color tc = 0;
      if (p.matrix.m03 > q.matrix.m03) {
        if (q.matrix.m23 == 0 || q.matrix.m03 == -1) {
          for (Face i : p.faces) {
            if (i.c != colours[5] && i.rendered) {
              tc = i.c;
            }
          }
          alg += faceTheFront(p, tc);
        } else {
          for (Face i : q.faces) {
            if (i.c != colours[5] && i.rendered) {
              tc = i.c;
            }
          }
          alg += faceTheFront(q, tc);  //PREPARES FOR ALGORITHM AGAIN IF LINE SHAPE
        }
      } else {
        if (q.matrix.m23 == 1 || q.matrix.m03 == 1) {
          for (Face i : p.faces) {
            if (i.c != colours[5] && i.rendered) {
              tc = i.c;
            }
          }
          alg += faceTheFront(p, tc);
        } else {
          for (Face i : q.faces) {
            if (i.c != colours[5] && i.rendered) {
              tc = i.c;
            }
          }
          alg += faceTheFront(q, tc);
        }
      }
      alg += "fruRUF";    //CARRIES OUT ALGORITHM INTO THE RED-CROSS
    }
  }
  algorithm = alg;
  manual = false;    //DISABLES MANUAL MODE AND CARRIES OUT IDENTIFIED ALGORITHM
}

//IMPLEMENTS ABOVE FUNCTIONS/ALGORITHMS
void redCross() {
  if (manual) {
    toRCross = getRedCross();
    crossCycle();
    count++;
  }
}
