Block[] headlights = new Block[4];  //INITIALISES ARRAY FOR USE IN STEP
//FINDS BLOCKS IN HEADLIGHT POSITION
Block[] getLights() {
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
  return toReturn;  //RETURNS BLOCKS IN SOUGHT AFTER POSITION
}

//MATCHES CORNERS TO THEIR COLOUR SIDES
void orientCorners() {
  String alg = "";
  PVector target = betweenLights()[0];
  if (buffer < 2) {
    if (target.y == 0) {
      alg += "RfRbbrFRbbrr";
    } else {
      for (Block i : cube) {
        if (i.matrix.m03 == target.x && i.matrix.m13 == target.y && i.matrix.m23 == target.z) {
          for (Face j : i.faces) {
            if (j.rendered && j.normal.y == 0) {
              alg += faceTheFront(blockClone(i), j.c);
            }
          }
        }
      }
      alg += "uuRfRbbrFRbbrr";
    }
  }
  algorithm = alg;
  manual = false;  //SETS ALGORITHM TO FOUND STRING AND DISABLES MANUAL MODE
}

//IMPLEMENTS ABOVE FUNCTIONS AND ALGORITHMS
void topCorners() {
  if (manual) {
    headlights = getLights();
    orientCorners();
    count++;
  }
}
