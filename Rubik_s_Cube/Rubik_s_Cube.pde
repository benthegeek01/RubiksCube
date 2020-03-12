//IMPORTING REQUIRED MODULES: G4P AND PEASYCAM
import g4p_controls.*;
import peasy.*;
import java.awt.Font;
//INITIALISING CAMERA OBJECT
PeasyCam pc;
//INITIALISING MODE BOOLEANS
int colIndex = 0;
boolean test = false;
boolean custom = false;
boolean solved = true;
boolean free = true;
//INITIALISING COLOUR SIDES
GTextField[] sideCols;
//INITIALISING OTHER BOOLEANS
boolean go = false;
boolean modeChange = true;
boolean colourInvalid = false;
boolean controlInvalid = false;
boolean controlDupe = false;
boolean speedInvalid = false;
boolean menuActive = false;
boolean manual = true;
boolean solving = false;
boolean timing = false;
//INITIALISING DEFAULT BACKGROUND COLOUR
color bgc = #323232;
//INITIALISING DEFAULT EDGE COLOUR
color edgeColour = #000000;
//INITIALISING CHANGEABLE CONTROL SCHEME AS DEFAULT
Integer[] shuffleSolve = {10, 32};
char[] controls = {'F', 'B', 'U', 'D', 'L', 'R', 'M'};
//INITIALISING IMMUTABLE DEFAULT CONTROL SCHEME
Integer[] ogShuffleSolve = {10, 32};
char[] ogControls = {'F', 'B', 'U', 'D', 'L', 'R', 'M'};
//INITIALISING IMMUTABLE DEFAULT COLOUR SCHEME
color[] ogColours = {#FFFFFF, #FFFF00, #00FF00, #0000FF, #FFA500, #FF0000};
//INITIALISING INDIVIDUAL COLOURS AS DEFAULT
color fColour = #FFFF00;
color bColour = #FFFFFF;
color uColour = #FF0000;
color dColour = #FFA500;
color lColour = #00FF00;
color rColour = #0000FF;
int size;
//INITIALISING ARBITRARY COUNTING VARIABLES
int count = 0;
int acount = 0;
//INITALISING PARAMETERS FOR TURN SPEED/OTHER SOLVING VARIABLES
float rotspeed;
float time = 0;
float manspeed = 0.2;
float aispeed = 1;
float angle;
int moveCounter = 0;
float allRot = 0;
boolean rotAll = false;
int rotAllDir = 1;
int lockNo = 0;
//INITIALISE CUBE AS ARRAY OF BLOCKS
Block[] cube;
//INITIALISE DEFAULT CENTRES FOR CUBES
PVector[] centres = {new PVector(0, 0, -1), new PVector(0, 0, 1), new PVector(-1, 0, 0), new PVector(1, 0, 0), new PVector(0, 1, 0), new PVector(0, -1, 0)};
//                                  W                      Y                      G                        B                    O                    R                                  
color[] colours = {bColour, fColour, lColour, rColour, dColour, uColour};
//DEC VALUES        -1       -256   -16711936 -16776961 -23296   -65536        
//INITIALISE POSSIBLE SPIN OBJECTS
Spin[] possMoves = {new Spin(0, 0, 1, 0), new Spin(0, 0, -1, 0), 
  new Spin(0, 1, 0, 0), new Spin(0, -1, 0, 0), 
  new Spin(1, 0, 0, 0), new Spin(-1, 0, 0, 0), 
  new Spin(0, 0, 1, 0)};
Spin thisMove = possMoves[6];
//INITIALISING ALGORITHM STRINGS IN PREP FOR SOLVING
String gen = "FBDURLfbdurl";
String algorithm = "fff";
String solve = "";

//SETUP FUNCTION THAT PREPARES ENVIRONMENT
void setup() {
  size = 3;      //SIZE OF CUBE
  angle = 0;     //STARTING ANGLE OF ROTATION
  rotspeed = 0.5;    //STARTING ROTATION SPEED
  cube = new Block[floor(pow(size, 3))];  //SETTING SIZE OF CUBE (27)
  size(600, 600, P3D);    //SETTING SIZE OF CANVAS AND RENDERER
  pc = new PeasyCam(this, 400);    //SETTING PARAMETERS OF CAMERA
  int c = 0;
  for (int i = -(size / 2); i < ((size/2) + 1); i++) {
    for (int j = -(size / 2); j < ((size/2) + 1); j++) {
      for (int k = -(size / 2); k < ((size/2) + 1); k++) {   //POPULATION OF CUBE ARRAY
        PMatrix3D m = new PMatrix3D();
        m.translate(i, j, k);          //SETTING BLOCK POSITION IN CUBE
        cube[c] = new Block(m);
        c++;
      }
    }
  }
  sideCols = new GTextField[6];
}

//RUNS EVERY FRAME TO CREATE ANIMATION
void draw() {
  if (width != 600 || height != 600) {
    setSize(600, 600);                //ENSURES WINDOW SIZE IS DEFAULT
  }
  background(bgc);  //SETS BACKGROUND COLOUR
  scale(100 / map(size, 1, 125, 1, 50));  //SCALES CUBE UP AS DEFAULT SIZE IS 1X1X1
  fill(255);      //SETS FILL COLOUR
  for (int i = 0; i < cube.length; i++) {      //LOOPS THROUGH ENTIRE CUBE
    float[] things = {cube[i].matrix.m03, cube[i].matrix.m13, cube[i].matrix.m23};
    pushMatrix();
    if ((things[thisMove.layernum] == thisMove.layer) && (!rotAll)) {
      switch(thisMove.axis) {
      case 'x':
        rotateX(thisMove.angle);
        break;
      case 'y':
        rotateY(-thisMove.angle);            //USES PARAMETERS OF thisMove VARIABLE TO IDENTIFY WHICH BLOCKS SHOULD MOVE
        break;
      case 'z':
        rotateZ(thisMove.angle);
        break;
      }
      thisMove.update();
    } else if (rotAll) {
      rotateY(rotAllDir * -allRot);
      allRot += 0.1 * rotspeed;
      if (allRot > PI/2) {
        turn(-1, 'y', rotAllDir);
        turn(0, 'y', rotAllDir);              //ROTATES RELEVANT CUBES USING TURN FUNCTION
        turn(1, 'y', rotAllDir);
        allRot = 0;
        rotAll = false;
        if (!manual) {
          acount++;                          //IF NOT MANUAL (IF STILL ON AUTO) ADD ONE TO ACOUNT TO CONTINUE ALGORITHM
        }
      }
    }
    cube[i].show();
    popMatrix();
  }
  if (solving && manual) {            //IF SPACE BEEN PRESSED, SOLVE WITH DEFAULT ROTSPEED
    solve();
    rotspeed = aispeed;
  } else if (manual) {
    rotspeed = manspeed;              //IF ON MANUAL, SET TO SLOWER SPEED
  }
  if (menuActive) {
    validateColourInputs();          //VALIDATE COLOUR INPUTS USING FUNCTION
    LBL_Valid.setVisible(colourInvalid);
    validateControlInputs();
    LBL_Alpha.setVisible(controlInvalid);
    validateSpeedInputs();
    LBL_Range.setVisible(speedInvalid);
    LBL_Algorithms.setText(algorithm);
    if (modeChange) {
      modeChange = false;
      if (custom) {
        LBL_notCustom.setVisible(false);
        WIN_Builder.setVisible(true);      //WHEN MENU ACTIVATED, SET FORMS TO THEIR REQUIRED STATE
      } else if (test) {
        WIN_Timer.setVisible(true);
        WIN_Builder.setVisible(false);
        timing = true;
      } else if  (free) {
        LBL_notCustom.setVisible(true);
        WIN_Builder.setVisible(false);
        WIN_Timer.setVisible(false);
        WIN_Algorithms.setVisible(false);
        timing = false;
      }
    }
    if (free) {
      LBL_Current.setText("Current Mode: Free");
    } else if (custom) {
      LBL_Current.setText("Current Mode: Custom");      //DISPLAYS CURRENT MODE
    } else if (test) {
      LBL_Current.setText("Current Mode: Test");
    }
    LBL_Current.setTextBold();
  }
  if (timing && menuActive && solving) {
    time += 1;
    LBL_Timer.setTextBold();
    if (frameCount % 5 == 0) {
      float time2 = 0;
      time2 = (float)round(100 * (time/60)) / 100;      //UPDATES TIMER
      println(time2);
      LBL_Timer.setText(Float.toString(time2));
    }
  }
}

//FUNCTION TO MOVE BLOCKS AROUND THE CUBE ACCORDING TO MOVE PARAMETERS
void turn(float id, char axis, float dir) {
  float test = 0;
  float a = 0;
  float b = 0;      //INITIALISE VARIABLES THAT WILL CHANGE DEPENDING ON AXIS OF ROTATION
  char q = axis;
  for (int i = 0; i < cube.length; i++) {
    switch (q) {
    case 'x':
      test = cube[i].matrix.m03;
      a = cube[i].matrix.m13;        //SET VARIABLES DEPENDING ON AXIS
      b = cube[i].matrix.m23;
      break;
    case 'y':
      test = cube[i].matrix.m13;
      a = cube[i].matrix.m03;
      b = cube[i].matrix.m23;
      break;
    case 'z':
      test = cube[i].matrix.m23;
      a = cube[i].matrix.m03;
      b = cube[i].matrix.m13;
    }
    if (test == id) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir * HALF_PI);
      matrix.translate(a, b);
      switch (axis) {
      case 'x':
        cube[i].turn(HALF_PI, 1, dir);
        cube[i].update(round(cube[i].matrix.m03), round(matrix.m02), round(matrix.m12));
        break;
      case 'y':
        cube[i].turn(HALF_PI, 2, dir);
        cube[i].update(round(matrix.m02), round(cube[i].matrix.m13), round(matrix.m12));      //TURNS FACES OF RELEVANT BLOCKS DEPENDING ON THISMOVE
        break;
      case 'z':
        cube[i].turn(HALF_PI, 3, dir);
        cube[i].update(round(matrix.m02), round(matrix.m12), round(cube[i].matrix.m23));
      }
    }
  }
}

//FUNCTION TO READ A CHARACTER AND CARRY OUT THE MATCHING MOVE
void read(char c) {
  char x = c;
  int rev = 1;
  if ((x > 64) && (x < 91)) {
    rev = -1;
    x = Character.toLowerCase(x);
  }
  if (x == 'r') {              
    thisMove = possMoves[4];
    thisMove.dir = rev;
  } else if (x == 'l') {
    thisMove = possMoves[5];
    thisMove.dir = -rev;
  } else if (x == 'u') {
    thisMove = possMoves[3];
    thisMove.dir = rev;
  } else if (x == 'd') {
    thisMove = possMoves[2];    //DETECTS VALID LETTER OF C AND SETS THISMOVE TO CORRECT SPIN OBJECT
    thisMove.dir = rev;
  } else if (x == 'f') {
    thisMove = possMoves[0];  
    thisMove.dir = rev;
  } else if (x == 'b') {
    thisMove = possMoves[1];
    thisMove.dir = rev;
  } else if (x == 't') {
    rotAll = true;
    rotAllDir = -rev;
  }
  thisMove.start();            //CARRIES OUT THISMOVE
}

//IDENTIFIES MOVE AND RETURNS CHARACTER THAT MATCHES GIVEN SPIN
char spinToMove(Spin s) {
  char x = 'X';
  for (int i = 0; i < possMoves.length; i++) {
    if ((s.x == possMoves[i].x) && (s.y == possMoves[i].y) && (s.z == possMoves[i].z)) { 
      x = gen.charAt(i);
    }
  }
  return x;
}

//REVERSES A STRING AND RETURNS THE OPPOSITE (LOWER BECOMES UPPER VICE VERSA)
String oppoChar(String s) {
  String toReturn = "";
  for (int i = 0; i < s.length(); i++) {
    char c = s.charAt(i); 
    if (c > 96) {
      toReturn += (char)(c - 32);
    } else {
      toReturn += (char)(c + 32);
    }
  }
  return toReturn;
}

//ITERATES THROUGH THE CUBE AND UPDATES THE CENTRES ARRAY TO BE ACCURATE
void changeCentres() {
  PVector[] temp = new PVector[6];
  for (Block i : cube) {
    if (abs(i.matrix.m03) + abs(i.matrix.m13) + abs(i.matrix.m23) == 1) {
      for (Face j : i.faces) {
        if (j.rendered) {
          for (int k = 0; k < colours.length; k++) {
            if (j.c == colours[k]) {
              temp[k] = new PVector(i.matrix.m03, i.matrix.m13, i.matrix.m23);
            }
          }
        }
      }
    }
  }
  centres = temp;
}

//CHANGES COLOUR OF SPECIFIC FACE THAT HAS BEEN CHANGED VIA MENU
void colourUpdate(int c, String n) {
  boolean colourDupe = false;
  Integer[] toReset = {-1, -1};
  for (Block i : cube) {
    for (Face j : i.faces) {
      if (j.c == colours[c] && j.normal.x == centres[c].x && j.normal.y == centres[c].y && j.normal.z == centres[c].z) {
        j.c = unhex("FF" + n);
      }
    }
  }
  colours[c] = unhex("FF" + n);
  for (int i = 0; i < colours.length - 1; i++) {
    for (int j = i+1; j < colours.length; j++) {
      if (colours[i] == colours[j]) {
        colourDupe = true;
        for (Block k : cube) {                                  //RESETS ANY COLOUR ON THE CUBE THAT HAS A DUPLICATE ELSEWHERE
          for (Face l : k.faces) {
            if (l.c == colours[i]) {
              for (int m = 0; m < centres.length; m++) {
                if (l.normal.x == centres[m].x && l.normal.y == centres[m].y && l.normal.z == centres[m].z) {
                  l.c = ogColours[m];
                }
              }
            }
          }
        }
        colours[i] = ogColours[i];
        colours[j] = ogColours[j];
      }
    }
  }
  LBL_Duplicate.setVisible(colourDupe);        //ACTIVATES DUPLIACTE ERROR IF A DUPLICATE EXISTS
}

//ENSURES ALL COLOUR INPUTS ARE CORRECT
void validateColourInputs() {
  GTextField toCheck[] = new GTextField[8];
  toCheck[0] = TXT_CEdges;
  toCheck[1] = TXT_CBGround;
  toCheck[2] = TXT_CFront;
  toCheck[3] = TXT_CBack;
  toCheck[4] = TXT_CUp;			//SETS A LIST OF ALL TEXTBOXES TO BE VALIDATED
  toCheck[5] = TXT_CDown;
  toCheck[6] = TXT_CLeft;
  toCheck[7] = TXT_CRight;
  for (int i = 0; i < toCheck.length; i++) {
    if (!toCheck[i].hasFocus()) {
      if (!toCheck[i].getText().matches("([A-F]|[0-9]){6}") && (toCheck[i].getText().length() != 0)) {
        toCheck[i].setText("");										//ITERATES THROUGH AND USES REGEX EXPRESSIONS TO VALIDATE CONTENTS
      }
    } else {
      if (!toCheck[i].getText().matches("([A-F]|[0-9]){6}") && (toCheck[i].getText().length() != 0)) {
        colourInvalid = true;
      }													//IF ANY ARE INVALID, SET VARIABLE TO TRUE
    }
  }
  boolean temp = false;
  for (int i = 0; i < toCheck.length; i++) {
    if (!toCheck[i].getText().matches("([A-F]|[0-9]){6}") && (toCheck[i].getText().length() != 0)) {	//RECHECKS INVALIDITY
      temp = true;
    }
  }
  if (temp) {
    colourInvalid = true;
  } else {
    colourInvalid = false;
  }
}

void controlUpdate() {
}

//ENSURES ALL CONTROL INPUTS ARE CORRECT
void validateControlInputs() {
  GTextField toCheck[] = new GTextField[7];
  toCheck[0] = TXT_Front;
  toCheck[1] = TXT_Back;
  toCheck[2] = TXT_Up;				//SETS A LIST OF ALL TEXTBOXES TO CHECK
  toCheck[3] = TXT_Down;
  toCheck[4] = TXT_Left;
  toCheck[5] = TXT_Right;
  toCheck[6] = TXT_Menu;
  for (int i = 0; i < toCheck.length; i++) {
    if (!toCheck[i].getText().matches("[A-Z]") && (toCheck[i].getText().length() != 0)) {		//ITERATES AND USES REGEX TO ENSURE VALIDITY
      if (toCheck[i].hasFocus()) {
        controlInvalid = true;
      } else {
        toCheck[i].setText("");
      }
    }
  }
  boolean temp = false;
  for (int i = 0; i < toCheck.length; i++) {
    if (!toCheck[i].getText().matches("[A-Z]") && (toCheck[i].getText().length() != 0)) {
      temp = true;
    }
  }
  controlInvalid = temp;
  Integer toReset[] = {-1, -1};
  for (int i = 0; i < controls.length - 1; i++) {
    for (int j = i + 1; j < controls.length; j++) {
      if (controls[j] == controls[i]) {
        controlDupe = true;
        controls[i] = ogControls[i];
        controls[j] = ogControls[j];								//CHECKS FOR DUPLICATES AND RESETS ANY DUPLICATES
        toReset[0] = i + 1;
        toReset[1] = j + 1;
      }
    }
  }
  LBL_CDuplicate.setVisible(controlDupe);
  if (LBL_CDuplicate.isVisible()) {
    for (int i : toReset) {
      if (i - 1 != -2) {
        if (!toCheck[i-1].hasFocus()) {			//LIVE UPDATES AS USER TYPES
          toCheck[i-1].setText("");
        }
      }
    }
    temp = true;
    for (GTextField i : toCheck) {
      if (i.hasFocus()) {
        temp = false;
      }
    }
    if (temp) {
      controlDupe = false;
    }
  }
}

//ENSURES SPEED INPUTS ARE CORRECT
void validateSpeedInputs() {
  boolean check = false;
  GTextField toCheck[] = new GTextField[2];
  toCheck[0] = TXT_AISpeed;
  toCheck[1] = TXT_Rot;
  Double temp;
  for (int i = 0; i < toCheck.length; i++) {
    if (!toCheck[i].getText().matches("([0-9]\\.[0-9]+)|([0-9])") && (toCheck[i].getText().length() != 0)) {	//USES REGEX TO ENSURE CORRECT TEXT INPUTS
      if (!toCheck[i].hasFocus()) {
        toCheck[i].setText("");
      } else {
        speedInvalid = true;
      }
    } else {
      if (toCheck[i].getText().matches("([0-9]\\.[0-9]+)|([0-9])") && (toCheck[i].getText().length() != 0)) {	//PARSES INTEGER AND CHECKS THE RANGE
        temp = Double.parseDouble(toCheck[i].getText());
        println(temp);
        if (temp <= 0 || temp > 3) {
          if (!toCheck[i].hasFocus()) {
            toCheck[i].setText("");
          } else {
            speedInvalid = true;
          }
        }
      }
    }
  }

  for (int i = 0; i < toCheck.length; i++) {
    if ((!toCheck[i].getText().matches("([0-9]\\.[0-9]+)|([0-9])") && (toCheck[i].getText().length() != 0))) {
      check = true;
    } else if (toCheck[i].getText().matches("([0-9]\\.[0-9]+)|([0-9])")) {					//SETS THE SPEEDINVALID VARIABLE TO THE APPROPRIATE VALUE
      temp = Double.parseDouble(toCheck[i].getText());
      if (temp <= 0 || temp > 3) {
        check = true;
      }
    }
  }
  speedInvalid = check;
}



void mousePressed() {
}
