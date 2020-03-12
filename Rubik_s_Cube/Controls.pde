//RUNS EVERYTIME A KEY IS PRESSED
void keyPressed() {
  println(keyCode);
  if (key == ' ') {
    println("SPACE");
  } else {
    println(key);
  }
  if (keyCode == 37) {  //LEFT ARROW PRESS
    rotAll = true;
    rotAllDir = 1;
  } else if (keyCode == 39) {  //RIGHT ARROW PRESS
    rotAll = true;
    rotAllDir = -1;
  } else if (keyCode == shuffleSolve[1]) {  //CUSTOM SOLVE BUTTON
    if (!solving) {
      toCross = getOrangeEdges();
      solving = true;
      solved = false;
      count = 0;
    }
  } else if (keyCode == shuffleSolve[0]) {  //CUSTOM SHUFFLE BUTTON
    String shuffle = "";
    solved = false;
    for (int i = 0; i < 20; i++) {
      shuffle += gen.charAt(round(random(gen.length() - 1)));
    }
    if (manual && !solving) {    //SETS ALGORITHM TO RANDOM STRING
      algorithm = shuffle;
    }
    manual = false;
  } else if (key == controls[6] || key == controls[6] + 32) {
    if (menuActive) {
      menuActive = false;
      WIN_Menu.close();
      WIN_Algorithms.close();
      WIN_Builder.forceClose();    //CLOSES WINDOWS
    } else {
      menuActive = true;
      createGUI();
      customGUI();        //CUSTOMISES GUI
    }
  } else if (manual) {
    char x = key;
    boolean rev = false;
    rotspeed = 0.05;
    if ((x > 64) && (x < 91)) {
      rev = true;
      x = Character.toLowerCase(x);
    }
    if (x == controls[5] + 32) {      //FRONT
      thisMove = possMoves[4];
      thisMove.dir = 1;
    } else if (x == controls[4] + 32) {    //BACK
      thisMove = possMoves[5];
      thisMove.dir = -1;
    } else if (x == controls[2] + 32) {    //LEFT
      thisMove = possMoves[3];
      thisMove.dir = 1;
    } else if (x == controls[3] + 32) {    //RIGHT
      thisMove = possMoves[2];
      thisMove.dir = 1;
    } else if (x == controls[0] + 32) {    //UP
      thisMove = possMoves[0];
      thisMove.dir = 1;
    } else if (x == controls[1] + 32) {    //DOWN
      thisMove = possMoves[1];
      thisMove.dir = -1;
    }
    if (rev) {
      thisMove.dir = -thisMove.dir;    //REVERSES MOVE DIRECTION
    }
    thisMove.start();
  } else {
    println("INVALID KEY");
  }
}
