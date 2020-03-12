//CUSTOM SPIN OBJECT THAT REPRESENTS A MOVE
class Spin {
  float angle = 0;
  int x = 0;
  int y = 0;
  int z = 0;
  int layer;
  int layernum;
  char axis;
  int dir;
  boolean go = false;
  
  //INITIALISES THE OBJECT WITH AN X, Y, Z AND DIRECTION
  Spin(int x, int y, int z, int dir) {
    this.x = x;
    this.y = y;
    this.z = z;
    int[] checkLayer = {x, y, z};
    for (int i = 0; i < checkLayer.length; i++) {
      if (abs(checkLayer[i]) > 0) {
        layer = checkLayer[i];
        layernum = i;
        axis = (char)(i+120);
      }
    }
    this.dir = dir;
  }
  
  //STARTS THE MOVE
  void start() {
    go = true;
  }
  
  //UPDATES ALL BLOCKS AFFECTED BY THE SPIN
  void update() {
    if (go) {
      angle += rotspeed * dir * 0.1;
    }
    if (abs(angle) > HALF_PI) {
      angle = 0;
      go = false;
      if (!manual) {
        acount++;
        moveCounter++;    //COUNTS NUMBER OF MOVES THIS FAR
        println(moveCounter - 20);
      }
      turn(layer, axis, dir);
      if (manual) {
        thisMove = possMoves[6];
      }
    }
    if (!manual) {
      if (acount < algorithm.length()) {
        read(algorithm.charAt(acount));      //BYPASSES ANYTHING THAT AFFECTS THE CUBE BY ADDING AN UP TURN IN THE FIRST STEP
        if (solving && count < 4) {
          for (Block i : isLocked) {
            if (i != null) {
              if (((thisMove.x != 0) && (thisMove.x == i.matrix.m03)) || ((thisMove.z != 0) && thisMove.z == i.matrix.m23)) {
                algorithm = algorithm.substring(0, acount) + "U" + algorithm.substring(acount);
                read(algorithm.charAt(acount));
              }
            }
          }
        }
      } else {
        manual = true;
        acount = 0;
      }
    }
  }
}
