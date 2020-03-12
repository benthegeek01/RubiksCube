Block[] toCross;
Block[] isLocked = new Block[1];  //INITIALISES REQUIRED VARIABLES
Block[] toCorner;
int buffer;

//FUNCTION TO RETURN AN ARRAY OF 'LOCKED' BLOCKS IN CUBE
Block[] getLocked() {
  lockNo = 0;
  for (Block i : cube) {
    if (i.matrix.m13 == -1 && (abs(i.matrix.m03) + abs(i.matrix.m23) == 1)) {
      for (Face j : i.faces) {
        if (j.rendered && (j.normal.y == -1)) {
          if (j.c == colours[4]) {
            i.locked = true;
            lockNo++;
          }
        }
      }
    }
  }
  int tcount = 0;
  Block[] toReturn = new Block[4];
  for (Block i : cube) {
    if (i.locked) {
      toReturn[tcount] = i;
      tcount++;
    }
  }
  return toReturn;
}

//STARTS DIFFERENT STEPS OF SOLVE DEPENDING ON VALUE OF COUNT
void solve() {
  if (count < 8) {
    orangeCross();
    if (count == 8) {
      for (Block i : cube) {    //STEP 1
        i.locked = false;
      }
    }
  }else if (count < 12) {
    orangeFace();
    if (count == 12) {
      for (Block i : cube) {  //STEP 2
        i.locked = false;
      }
    }
  } else if (count < 16) {
    middleLayer();
    if (count == 16) {
      for (Block i : cube) {  //STEP 3
        i.locked = false;
      }
    }
  } else if (count < 19) {    //STEP 4
    redCross();
  } else if (count < 22) {   //STEP 5
    redFace();
  } else if (count < 25) {   //STEP 6
    topCorners();
  } else if (count < 29) {   //STEP 7
    finishHim();
  } else if (count < 30) {
    Block t = new Block(new PMatrix3D());
    for (Block i : cube) {                //FINISHES THE CUBE
      if (i.matrix.m13 == -1) {
        if (abs(i.matrix.m03) + abs(i.matrix.m23) == 1) {
          t = blockClone(i);
        }
      }
    }
    changeCentres();    //UPDATES CENTRES
    algorithm = putAbove(t);
    for (Block i : cube) {
      if (abs(i.matrix.m03) + abs(i.matrix.m13) + abs(i.matrix.m23) == 1) {
        for (Face j : i.faces) {
          if (j.rendered && j.c == colours[1]) {
            algorithm += faceTheFront(blockClone(i), j.c);                    //ENSURES CUBE IS SOLVED AND ORIENTATED
          }
        }
      }
    }
    manual = false;
    count++;
  } else {
    solving = false;
    solved = true;      //RESETS BOOLEAN VARIABLES
    manual = true;
    time = 0;
    thisMove = possMoves[6];
    count = 0;
  }
}

//SIMULATES A TURN (SEE TURN FUNCTION)
void pretendTurn(Block block, float id, char axis, float dir) {
  float test = 0;
  float a = 0;
  float b = 0;
  char q = axis;
  switch (q) {
  case 'x':
    test = block.matrix.m03;
    a = block.matrix.m13;
    b = block.matrix.m23;
    break;
  case 'y':
    test = block.matrix.m13;
    a = block.matrix.m03;
    b = block.matrix.m23;
    break;
  case 'z':
    test = block.matrix.m23;
    a = block.matrix.m03;
    b = block.matrix.m13;
  }
  if (test == id) {
    PMatrix2D matrix = new PMatrix2D();
    matrix.rotate(dir * HALF_PI);
    matrix.translate(a, b);
    switch (axis) {
    case 'x':
      block.turn(HALF_PI, 1, dir);
      block.update(round(block.matrix.m03), round(matrix.m02), round(matrix.m12));
      break;
    case 'y':
      block.turn(HALF_PI, 2, dir);
      block.update(round(matrix.m02), round(block.matrix.m13), round(matrix.m12));
      break;
    case 'z':
      block.turn(HALF_PI, 3, dir);
      block.update(round(matrix.m02), round(matrix.m12), round(block.matrix.m23));
    }
  }
}

//SIMULATES A READ ON A BLOCK (SEE READ FUNCTION)
void pretendRead(Block b, String s) {
  for (int i = 0; i < s.length(); i++) {
    char c = s.charAt(i);
    char x = c;
    int rev = 1;
    if ((x > 64) && (x < 91)) {
      rev = -1;
      x = Character.toLowerCase(x);
    }
    if (x == 'r') {
      pretendTurn(b, 1, 'x', rev);
    } else if (x == 'l') {
      pretendTurn(b, -1, 'x', -rev);
    } else if (x == 'u') {
      pretendTurn(b, -1, 'y', rev);
    } else if (x == 'd') {
      pretendTurn(b, 1, 'y', rev);
    } else if (x == 'f') {
      pretendTurn(b, 1, 'z', rev);
    } else if (x == 'b') {
      pretendTurn(b, -1, 'z', rev);
    } else if (x == 't') {
      pretendTurn(b, -1, 'y', 1);
      pretendTurn(b, 0, 'y', 1);
      pretendTurn(b, 1, 'y', 1);
      updateCentres();
    }
  }
}

//ENSURES CENTRE VECTORS ARE CORRECT
void updateCentres() {
  for (PVector i : centres) {
    if (i.x != 0) {
      i.z = i.x;
      i.x = 0;
    } else if (i.z != 0) {
      i.x = -i.z;
      i.z = 0;
    }
  }
}

//FACES A PARTICULAR BLOCK/COLOUR TO THE FRONT OF THE CUBE
String faceTheFront(Block b, color c) {
  Face f = new Face(0, new PVector(0, 0, 0));
  for (Face i : b.faces) {
    if (i.c == c) {
      f = new Face(i.c, i.normal);
    }
  }
  if (f.normal.z == -1) {
    pretendRead(b, "TT");
    return "TT";
  } else if (f.normal.x == -1) {
    pretendRead(b, "TTT");
    return "TTT";
  } else if (f.normal.x == 1) {    //DEPENDS ON X AND Z POSITION OF CUBE IN QUESTION
    pretendRead(b, "T");
    return "T";
  } else if (abs(f.normal.y) == 1) {
    if (b.matrix.m23 == -1) {
      pretendRead(b, "TT");
      return "TT";
    } else {
      return "";
    }
  } else {
    return "";
  }
}

//CLONES A BLOCK AND RETURNS CLONE TO PREVENT ERRORS
Block blockClone(Block a) {
  Block b = new Block(new PMatrix3D());
  b.matrix.translate(a.matrix.m03, a.matrix.m13, a.matrix.m23);
  for (int i = 0; i < b.faces.length; i++) {
    b.faces[i] = new Face(a.faces[i].c, a.faces[i].normal);
    if (a.faces[i].rendered) {
      b.faces[i].rendered = true;
    }
  }
  return b;
}

//RETURNS ARRAY OF ALL CUBES IN TOP MIDDLE POSITION IN RUBIKS CUBE
PVector[] betweenLights() {
  PVector targets[] = new PVector[4];
  Block[] tHeadlights = new Block[4];
  Block[] temp = new Block[4];
  for (int i = 0; i < tHeadlights.length; i++) {
    temp[i] = blockClone(headlights[i]);
  }
  for (int i = 0; i < temp.length; i++) {
    if (temp[i].matrix.m03 == -1 && temp[i].matrix.m23 == -1) {
      tHeadlights[0] = temp[i];
    } else if (temp[i].matrix.m03 == -1 && temp[i].matrix.m23 == 1) {
      tHeadlights[1] = temp[i];
    } else if (temp[i].matrix.m03 == 1 && temp[i].matrix.m23 == -1) {    //CHECKS BLOCK POSITION
      tHeadlights[2] = temp[i];
    } else {
      tHeadlights[3] = temp[i];
    }
  }
  int tcount = -1;
  PVector target = new PVector(0, 0, 0);
  targets[0] = target;
  Face[] toCompare = new Face[8];
  for (Block i : tHeadlights) {
    tcount++;
    for (Face j : i.faces) {
      if (j.rendered && j.normal.y == 0) {
        if (j.normal.x != 0) {
          toCompare[tcount] = j;
        } else if (j.normal.z != 0) {      //PREPARES TO COMPARE TWO+ BLOCKS
          toCompare[tcount + 4] =  j;
        }
      }
    }
  }
  buffer = 0;
  for (int i = 0; i < 7; i += 2) {
    if (i < 3) {
      if (toCompare[i].c == toCompare[i+1].c) {
        target = new PVector(toCompare[i].normal.x, -1, 0);
        targets[buffer] = target;
        buffer++;
      }
    } else if (i == 4) {
      if (toCompare[i].c == toCompare[i+2].c) {
        target = new PVector(0, -1, toCompare[i].normal.z);    
        targets[buffer] = target;
        buffer++;
      }
    } else if (i == 6) {
      if (toCompare[i-1].c == toCompare[i+1].c) {
        target = new PVector(0, -1, toCompare[i-1].normal.z);
        targets[buffer] = target;
        buffer++;
      }
    }
  }
  return targets;    //RETURNS THE 4 CUBES
}

//PUTS A BLOCK ABOVE A PARTICULAR CENTRE
String putAbove(Block b) {
  String toReturn = "";
  PVector target = new PVector (0, -1, 0);
  for (Face i : b.faces) {
    if (i.rendered && i.normal.y == 0) {
      for (int j = 0; j < colours.length; j++) {
        if (colours[j] == i.c) {
          target.x = centres[j].x;
          target.z = centres[j].z;
        }
      }
    }
  }
  if (abs(target.x + b.matrix.m03) + abs(target.z + b.matrix.m23) == 0) {
    toReturn = "UU";
  } else if ((b.matrix.m03 - target.x == 0) && (b.matrix.m23 - target.z == 0)) {
    toReturn = "";
  } else if (target.x != 0) {
    toReturn += (char)(101 + -1 * b.matrix.m23 * target.x * 16);
  } else if (target.z != 0) {
    toReturn += (char)(101 + b.matrix.m03 * target.z * 16);
  }
  pretendRead(b, toReturn);
  return toReturn;    //RETURNS THE FOUND STRING
}
