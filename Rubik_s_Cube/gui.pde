public void win_draw(PApplet appc, GWinData data) { //_CODE_:WIN_Menu:941366:
  appc.background(230);
  String R, G, B;
  String tempS;
  String[] tempA;
  R = Integer.toHexString(SLD_Red.getValueI());
  if (R.length() == 1) {
    R = "0" + R;
  }
  G = Integer.toHexString(SLD_Green.getValueI());
  if (G.length() == 1) {
    G = "0" + G;
  }
  B = Integer.toHexString(SLD_Blue.getValueI());
  if (B.length() == 1) {
    B = "0" + B;
  }
  tempS = R + G + B;
  tempA = tempS.split("");
  tempS = "";
  for (String x : tempA) {
    int y = x.charAt(0);
    if (y > 57) {
      y -= 32;
    }
    tempS = tempS + (char)y;
  }
  LBL_colourDisplay.setText(tempS);
  LBL_colourDisplay.setTextBold();
  appc.fill(SLD_Red.getValueI(), SLD_Green.getValueI(), SLD_Blue.getValueI());
  appc.rect(270, 560, 100, 210);
  sideCols[1] = TXT_CFront;
  sideCols[0] = TXT_CBack;
  sideCols[2] = TXT_CLeft;
  sideCols[3] = TXT_CRight;    //INITIALISING SAMPLER COLOUR ARRAY
  sideCols[5] = TXT_CUp;
  sideCols[4] = TXT_CDown;
  if (solved) {
    sideCols[colIndex].setText(tempS);
  }
} //_CODE_:WIN_Menu:941366:

public void win_close(GWindow window) { //_CODE_:WIN_Menu:506992:
  println("menu - window closed at " + millis());
} //_CODE_:WIN_Menu:506992:

public void TXT_Front_change1(GTextField source, GEvent event) { //_CODE_:TXT_Front:254401:
  try {
    if (TXT_Front.getText().length() == 1 && 64 < TXT_Front.getText().charAt(0) && TXT_Front.getText().charAt(0) < 91) {
      controls[0] = TXT_Front.getText().charAt(0);
      controlUpdate();
    } else {
      controlUpdate();
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Front:254401:

public void TXT_Back_change1(GTextField source, GEvent event) { //_CODE_:TXT_Back:222488:
  try {
    if (TXT_Back.getText().length() == 1 && 64 < TXT_Back.getText().charAt(0) && TXT_Back.getText().charAt(0) < 91) {
      controls[1] = TXT_Back.getText().charAt(0);
      controlUpdate();
    } else {
      controlUpdate();
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Back:222488:

public void TXT_Up_change1(GTextField source, GEvent event) { //_CODE_:TXT_Up:728101:
  try {
    if (TXT_Up.getText().length() == 1 && 64 < TXT_Up.getText().charAt(0) && TXT_Up.getText().charAt(0) < 91) {
      controls[2] = TXT_Up.getText().charAt(0);
      controlUpdate();
    } else {
      controlUpdate();
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Up:728101:

public void TXT_Down_change1(GTextField source, GEvent event) { //_CODE_:TXT_Down:584467:
  try {
    if (TXT_Down.getText().length() == 1 && 64 < TXT_Down.getText().charAt(0) && TXT_Down.getText().charAt(0) < 91) {
      controls[3] = TXT_Down.getText().charAt(0);
      controlUpdate();
    } else {
      controlUpdate();
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Down:584467:

public void TXT_Left_change1(GTextField source, GEvent event) { //_CODE_:TXT_Left:574472:
  try {
    if (TXT_Left.getText().length() == 1 && 64 < TXT_Left.getText().charAt(0) && TXT_Left.getText().charAt(0) < 91) {
      controls[4] = TXT_Left.getText().charAt(0);
      controlUpdate();
    } else {
      controlUpdate();
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Left:574472:

public void TXT_Right_change1(GTextField source, GEvent event) { //_CODE_:TXT_Right:773213:
  try {
    if (TXT_Right.getText().length() == 1 && 64 < TXT_Right.getText().charAt(0) && TXT_Right.getText().charAt(0) < 91) {
      controls[5] = TXT_Right.getText().charAt(0);
      controlUpdate();
    } else {
      controlUpdate();
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Right:773213:

public void TXT_Menu_change1(GTextField source, GEvent event) { //_CODE_:TXT_Menu:975428:
  try {
    if (TXT_Menu.getText().length() == 1 && 64 < TXT_Menu.getText().charAt(0) && TXT_Menu.getText().charAt(0) < 91) {
      controls[6] = TXT_Menu.getText().charAt(0);
      controlUpdate();
    } else {
      controlUpdate();
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Menu:975428:

public void BTN_Custom_click1(GButton source, GEvent event) { //_CODE_:BTN_Custom:583788:
  test = false;
  custom = true;
  free = false;
  modeChange = true;
} //_CODE_:BTN_Custom:583788:

public void BTN_Test_click1(GButton source, GEvent event) { //_CODE_:BTN_Test:302224:
  test = true;
  custom = false;
  free = false;
  modeChange = true;
} //_CODE_:BTN_Test:302224:

public void BTN_Free_click1(GButton source, GEvent event) { //_CODE_:BTN_Free:343728:
  test = false;
  custom = false;
  free = true;
  modeChange = true;
} //_CODE_:BTN_Free:343728:

public void TXT_CEdges_change1(GTextField source, GEvent event) { //_CODE_:TXT_CEdges:638795:
  try {
    if (TXT_CEdges.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      edgeColour = unhex("FF" + TXT_CEdges.getText());
    } else {
      edgeColour = 0;
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CEdges:638795:

public void TXT_CBGround_change1(GTextField source, GEvent event) { //_CODE_:TXT_CBGround:552742:
  try {
    if (TXT_CBGround.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      bgc = unhex(TXT_CBGround.getText());
    } else {
      bgc = #323232;
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CBGround:552742:

public void TXT_CFront_change1(GTextField source, GEvent event) { //_CODE_:TXT_CFront:522845:
  try {
    if (TXT_CFront.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      colourUpdate(1, TXT_CFront.getText());
    } else {
      colourUpdate(1, "FFFF00");
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CFront:522845:

public void TXT_CBack_change1(GTextField source, GEvent event) { //_CODE_:TXT_CBack:592012:
  try {
    if (TXT_CBack.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      colourUpdate(0, TXT_CBack.getText());
    } else {
      colourUpdate(0, "FFFFFF");
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CBack:592012:

public void TXT_CUp_change1(GTextField source, GEvent event) { //_CODE_:TXT_CUp:542311:
  try {
    if (TXT_CUp.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      colourUpdate(5, TXT_CUp.getText());
    } else {
      colourUpdate(5, "FF0000");
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CUp:542311:

public void TXT_CDown_change1(GTextField source, GEvent event) { //_CODE_:TXT_CDown:931249:
  try {
    if (TXT_CDown.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      colourUpdate(4, TXT_CDown.getText());
    } else {
      colourUpdate(4, "FFA500");
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CDown:931249:

public void TXT_CLeft_change1(GTextField source, GEvent event) { //_CODE_:TXT_CLeft:269140:
  try {
    if (TXT_CLeft.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      colourUpdate(2, TXT_CLeft.getText());
    } else {
      colourUpdate(2, "00FF00");
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CLeft:269140:

public void TXT_CRight_change1(GTextField source, GEvent event) { //_CODE_:TXT_CRight:769859:
  try {
    if (TXT_CRight.getText().matches("([a-f]|[A-F]|[0-9]){6}")) {
      colourUpdate(3, TXT_CRight.getText());
    } else {
      colourUpdate(3, "0000FF");
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_CRight:769859:

public void TXT_Rot_change1(GTextField source, GEvent event) { //_CODE_:TXT_Rot:466006:
  try {
    float temp = Float.parseFloat(TXT_Rot.getText());
    if (temp > 0 && temp <= 3) {
      manspeed = temp;
    } else {
      manspeed = 0.05;
    }
  } 
  catch (Exception e) {
  }
} //_CODE_:TXT_Rot:466006:

public void TXT_AISpeed_change1(GTextField source, GEvent event) { //_CODE_:TXT_AISpeed:213674:
  try {
    float temp = Float.parseFloat(TXT_AISpeed.getText());
    if (aispeed > 0 && aispeed <= 3) {
      aispeed = temp;
    } else {
      aispeed = 0.5;
    }
  }
  catch (Exception e) {
  }
} //_CODE_:TXT_AISpeed:213674:

public void SLD_Red_change1(GCustomSlider source, GEvent event) { //_CODE_:SLD_Red:206602:
  if (solved) {
    colourUpdate(colIndex, sideCols[colIndex].getText());
  }
} //_CODE_:SLD_Red:206602:

public void SLD_Green_change1(GCustomSlider source, GEvent event) { //_CODE_:SLD_Green:645222:
  if (solved) {
    colourUpdate(colIndex, sideCols[colIndex].getText());
  }
} //_CODE_:SLD_Green:645222:

public void SLD_Blue_change1(GCustomSlider source, GEvent event) { //_CODE_:SLD_Blue:852185:
  if (solved) {
    colourUpdate(colIndex, sideCols[colIndex].getText());
  }
} //_CODE_:SLD_Blue:852185:

public void dropList1_click1(GDropList source, GEvent event) { //_CODE_:DRP_Faces:391954:
  colIndex = DRP_Faces.getSelectedIndex();
} //_CODE_:DRP_Faces:391954:

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:WIN_Algorithms:320689:
  appc.background(230);
} //_CODE_:WIN_Algorithms:320689:

synchronized public void WIN_Builder_draw(PApplet appc, GWinData data) { //_CODE_:WIN_Builder:677486:
  appc.background(50);
  for (Build_Side i : sides) {
    i.show(appc);
  }
} //_CODE_:WIN_Builder:677486:

synchronized public void WIN_Builder_mouse_pressed(PApplet appc, GWinData data, MouseEvent mevent) { //_CODE_:WIN_Builder:611181:
  if (mevent.toString().charAt(12) == 'P') {
    for (Build_Side i : sides) {
      if (((appc.mouseX > i.x - 60) && (appc.mouseX < i.x + 60)) && ((appc.mouseY > i.y - 60) && (appc.mouseY < i.y + 60))) {
        for (Build_Block j : i.faces) {
          if (((appc.mouseX > i.x + j.x - 20) && (appc.mouseX < i.x + j.x + 20)) && ((appc.mouseY > i.y + j.y - 20) && (appc.mouseY < i.y + j.y + 20))) {
            j.colourChange(appc);
          }
        }
      }
    }
  }
} //_CODE_:WIN_Builder:611181:

public void WIN_Builder_close(GWindow window) { //_CODE_:WIN_Builder:980632:
  println("WIN_Builder - window closed at " + millis());
} //_CODE_:WIN_Builder:980632:

public void BTN_Load_Pressed(GButton source, GEvent event) { //_CODE_:BTN_Load:810045:
  int total;
  boolean invalid = false;
  for (color i : colours) {
    total = 0;
    for (Build_Side j : sides) {
      for (Build_Block k : j.faces) {
        if (colours[k.colNum] == i) {
          total++;
        }
      }
    }
    if (total > 9) {
      invalid = true;
    }
  }
  if (!invalid) {
    float x = 0;
    float y = 0;
    int count = 0;
    Face temp[] = new Face[9];
    for (Build_Side i : sides) {
      x = ((i.x - 250)/120);
      y = ((i.y - 190)/120);
      count = 0;
      if (abs(y) == 1) {
        for (Block j : cube) {
          if (j.matrix.m23 == y) {
            for (Face k : j.faces) {
              if (k.rendered && k.normal.z == y) {
                temp[int(abs(3*(j.matrix.m03 + 1)) + abs((j.matrix.m13 - y)))] = k;
              }
            }
          }
        }
        for (int j = 0; j < i.faces.length; j++) {
          temp[j].c = colours[i.faces[j].colNum];
        }
      } else if (y == 2) {
        for (Block j : cube) {
          if (j.matrix.m13 == -1) {
            for (Face k : j.faces) {
              if (k.rendered && k.normal.y == -1) {
                temp[int(abs(3*(j.matrix.m03 + 1)) + abs(j.matrix.m23 - 1))] = k;
              }
            }
          }
        }
        for (int j = 0; j < i.faces.length; j++) {
          temp[j].c = colours[i.faces[j].colNum];
        }
      } else if (x + y == 0) {
        for (Block j : cube) {
          if (j.matrix.m13 == 1) {
            for (Face k : j.faces) {
              if (k.rendered && k.normal.y == 1) {
                temp[int(3*(j.matrix.m03 + 1) + (j.matrix.m23 + 1))] = k;
              }
            }
          }
        }
        for (int j = 0; j < i.faces.length; j++) {
          temp[j].c = colours[i.faces[j].colNum];
        }
      } else if (abs(x) == 1) {
        for (Block j : cube) {
          if (j.matrix.m03 == x) {
            for (Face k : j.faces) {
              if (k.rendered && k.normal.x == x) {
                temp[int(3*abs(j.matrix.m13 - x) + abs(j.matrix.m23 + 1))] = k;
              }
            }
          }
        }
        for (int j = 0; j < i.faces.length; j++) {
          temp[j].c = colours[i.faces[j].colNum];
        }
      }
    }
  }
} //_CODE_:BTN_Load:810045:

synchronized public void WIN_Timer_draw(PApplet appc, GWinData data) { //_CODE_:WIN_Timer:605118:
  appc.background(230);
} //_CODE_:WIN_Timer:605118:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI() {
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.CYAN_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  WIN_Menu = GWindow.getWindow(this, "Menu", 0, 0, 390, 800, JAVA2D);
  WIN_Menu.noLoop();
  WIN_Menu.setActionOnClose(G4P.KEEP_OPEN);
  WIN_Menu.addDrawHandler(this, "win_draw");
  WIN_Menu.addOnCloseHandler(this, "win_close");
  LBL_Title = new GLabel(WIN_Menu, 120, 10, 140, 40);
  LBL_Title.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Title.setText("Menu");
  LBL_Title.setTextBold();
  LBL_Title.setOpaque(false);
  LBL_Modes = new GLabel(WIN_Menu, 140, 390, 110, 40);
  LBL_Modes.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Modes.setText("Modes");
  LBL_Modes.setTextBold();
  LBL_Modes.setOpaque(false);
  LBL_Settings = new GLabel(WIN_Menu, 120, 70, 140, 40);
  LBL_Settings.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Settings.setText("Settings");
  LBL_Settings.setTextBold();
  LBL_Settings.setOpaque(false);
  LBL_Controls = new GLabel(WIN_Menu, 10, 120, 90, 20);
  LBL_Controls.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Controls.setText("Controls");
  LBL_Controls.setTextBold();
  LBL_Controls.setOpaque(false);
  LBL_Front = new GLabel(WIN_Menu, 10, 150, 40, 20);
  LBL_Front.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Front.setText("Front:");
  LBL_Front.setTextBold();
  LBL_Front.setOpaque(false);
  TXT_Front = new GTextField(WIN_Menu, 50, 150, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_Front.setPromptText("F");
  TXT_Front.setOpaque(false);
  TXT_Front.addEventHandler(this, "TXT_Front_change1");
  LBL_Back = new GLabel(WIN_Menu, 10, 180, 40, 20);
  LBL_Back.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Back.setText("Back:");
  LBL_Back.setTextBold();
  LBL_Back.setOpaque(false);
  LBL_Up = new GLabel(WIN_Menu, 10, 210, 40, 20);
  LBL_Up.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Up.setText("Up");
  LBL_Up.setTextBold();
  LBL_Up.setOpaque(false);
  LBL_Down = new GLabel(WIN_Menu, 10, 240, 40, 20);
  LBL_Down.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Down.setText("Down");
  LBL_Down.setTextBold();
  LBL_Down.setOpaque(false);
  LBL_Menu = new GLabel(WIN_Menu, 10, 330, 40, 20);
  LBL_Menu.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Menu.setText("Menu");
  LBL_Menu.setTextBold();
  LBL_Menu.setOpaque(false);
  LBL_Left = new GLabel(WIN_Menu, 10, 270, 40, 20);
  LBL_Left.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Left.setText("Left");
  LBL_Left.setTextBold();
  LBL_Left.setOpaque(false);
  LBL_Right = new GLabel(WIN_Menu, 10, 300, 40, 20);
  LBL_Right.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Right.setText("Right");
  LBL_Right.setTextBold();
  LBL_Right.setOpaque(false);
  TXT_Back = new GTextField(WIN_Menu, 50, 180, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_Back.setPromptText("B");
  TXT_Back.setOpaque(true);
  TXT_Back.addEventHandler(this, "TXT_Back_change1");
  TXT_Up = new GTextField(WIN_Menu, 50, 210, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_Up.setPromptText("U");
  TXT_Up.setOpaque(true);
  TXT_Up.addEventHandler(this, "TXT_Up_change1");
  TXT_Down = new GTextField(WIN_Menu, 50, 240, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_Down.setPromptText("D");
  TXT_Down.setOpaque(true);
  TXT_Down.addEventHandler(this, "TXT_Down_change1");
  TXT_Left = new GTextField(WIN_Menu, 50, 270, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_Left.setPromptText("L");
  TXT_Left.setOpaque(true);
  TXT_Left.addEventHandler(this, "TXT_Left_change1");
  TXT_Right = new GTextField(WIN_Menu, 50, 300, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_Right.setPromptText("R");
  TXT_Right.setOpaque(true);
  TXT_Right.addEventHandler(this, "TXT_Right_change1");
  TXT_Menu = new GTextField(WIN_Menu, 50, 330, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_Menu.setPromptText("M");
  TXT_Menu.setOpaque(true);
  TXT_Menu.addEventHandler(this, "TXT_Menu_change1");
  BTN_Custom = new GButton(WIN_Menu, 40, 450, 80, 30);
  BTN_Custom.setText("Custom");
  BTN_Custom.setTextBold();
  BTN_Custom.addEventHandler(this, "BTN_Custom_click1");
  BTN_Test = new GButton(WIN_Menu, 150, 480, 90, 30);
  BTN_Test.setText("Test");
  BTN_Test.setTextBold();
  BTN_Test.addEventHandler(this, "BTN_Test_click1");
  BTN_Free = new GButton(WIN_Menu, 270, 450, 80, 30);
  BTN_Free.setText("Free");
  BTN_Free.setTextBold();
  BTN_Free.addEventHandler(this, "BTN_Free_click1");
  LBL_Colour = new GLabel(WIN_Menu, 130, 120, 120, 20);
  LBL_Colour.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Colour.setText("Colour");
  LBL_Colour.setTextBold();
  LBL_Colour.setOpaque(false);
  LBL_Cube = new GLabel(WIN_Menu, 270, 120, 110, 20);
  LBL_Cube.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Cube.setText("Cube");
  LBL_Cube.setTextBold();
  LBL_Cube.setOpaque(false);
  LBL_CEdge = new GLabel(WIN_Menu, 130, 150, 70, 20);
  LBL_CEdge.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CEdge.setText("Edges:");
  LBL_CEdge.setTextBold();
  LBL_CEdge.setOpaque(false);
  LBL_CBGround = new GLabel(WIN_Menu, 130, 180, 70, 20);
  LBL_CBGround.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CBGround.setText("BGround:");
  LBL_CBGround.setTextBold();
  LBL_CBGround.setOpaque(false);
  LBL_CFront = new GLabel(WIN_Menu, 130, 210, 70, 20);
  LBL_CFront.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CFront.setText("Front:");
  LBL_CFront.setTextBold();
  LBL_CFront.setOpaque(false);
  LBL_CBack = new GLabel(WIN_Menu, 130, 240, 70, 20);
  LBL_CBack.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CBack.setText("Back:");
  LBL_CBack.setTextBold();
  LBL_CBack.setOpaque(false);
  LBL_CUp = new GLabel(WIN_Menu, 130, 270, 70, 20);
  LBL_CUp.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CUp.setText("Up:");
  LBL_CUp.setTextBold();
  LBL_CUp.setOpaque(false);
  LBL_CDown = new GLabel(WIN_Menu, 130, 300, 70, 20);
  LBL_CDown.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CDown.setText("Down:");
  LBL_CDown.setTextBold();
  LBL_CDown.setOpaque(false);
  LBL_CLeft = new GLabel(WIN_Menu, 130, 330, 70, 20);
  LBL_CLeft.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CLeft.setText("Left:");
  LBL_CLeft.setTextBold();
  LBL_CLeft.setOpaque(false);
  LBL_CRight = new GLabel(WIN_Menu, 130, 360, 70, 20);
  LBL_CRight.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CRight.setText("Right:");
  LBL_CRight.setTextBold();
  LBL_CRight.setOpaque(false);
  TXT_CEdges = new GTextField(WIN_Menu, 200, 150, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CEdges.setPromptText("000000");
  TXT_CEdges.setOpaque(true);
  TXT_CEdges.addEventHandler(this, "TXT_CEdges_change1");
  TXT_CBGround = new GTextField(WIN_Menu, 200, 180, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CBGround.setPromptText("323232");
  TXT_CBGround.setOpaque(true);
  TXT_CBGround.addEventHandler(this, "TXT_CBGround_change1");
  TXT_CFront = new GTextField(WIN_Menu, 200, 210, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CFront.setPromptText("00FFFF");
  TXT_CFront.setOpaque(true);
  TXT_CFront.addEventHandler(this, "TXT_CFront_change1");
  TXT_CBack = new GTextField(WIN_Menu, 200, 240, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CBack.setPromptText("FFFFFF");
  TXT_CBack.setOpaque(true);
  TXT_CBack.addEventHandler(this, "TXT_CBack_change1");
  TXT_CUp = new GTextField(WIN_Menu, 200, 270, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CUp.setPromptText("FF0000");
  TXT_CUp.setOpaque(true);
  TXT_CUp.addEventHandler(this, "TXT_CUp_change1");
  TXT_CDown = new GTextField(WIN_Menu, 200, 300, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CDown.setPromptText("FFA500");
  TXT_CDown.setOpaque(true);
  TXT_CDown.addEventHandler(this, "TXT_CDown_change1");
  TXT_CLeft = new GTextField(WIN_Menu, 200, 330, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CLeft.setPromptText("0000FF");
  TXT_CLeft.setOpaque(true);
  TXT_CLeft.addEventHandler(this, "TXT_CLeft_change1");
  TXT_CRight = new GTextField(WIN_Menu, 200, 360, 50, 20, G4P.SCROLLBARS_NONE);
  TXT_CRight.setPromptText("00FF00");
  TXT_CRight.setOpaque(true);
  TXT_CRight.addEventHandler(this, "TXT_CRight_change1");
  LBL_Rot = new GLabel(WIN_Menu, 270, 170, 110, 20);
  LBL_Rot.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Rot.setText("Ro Speed:");
  LBL_Rot.setTextBold();
  LBL_Rot.setOpaque(false);
  TXT_Rot = new GTextField(WIN_Menu, 270, 150, 110, 20, G4P.SCROLLBARS_NONE);
  TXT_Rot.setPromptText("      0 < 0.05 < 3");
  TXT_Rot.setOpaque(true);
  TXT_Rot.addEventHandler(this, "TXT_Rot_change1");
  LBL_AISpeed = new GLabel(WIN_Menu, 270, 220, 110, 20);
  LBL_AISpeed.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_AISpeed.setText("AI Speed: ");
  LBL_AISpeed.setTextBold();
  LBL_AISpeed.setOpaque(false);
  TXT_AISpeed = new GTextField(WIN_Menu, 270, 200, 110, 20, G4P.SCROLLBARS_NONE);
  TXT_AISpeed.setPromptText("        0 < 0.5 < 3");
  TXT_AISpeed.setOpaque(true);
  TXT_AISpeed.addEventHandler(this, "TXT_AISpeed_change1");
  LBL_Valid = new GLabel(WIN_Menu, 290, 70, 90, 40);
  LBL_Valid.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Valid.setText("ONE OR MORE BOXES INVALID");
  LBL_Valid.setTextBold();
  LBL_Valid.setOpaque(false);
  LBL_Duplicate = new GLabel(WIN_Menu, 290, 20, 90, 50);
  LBL_Duplicate.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Duplicate.setText("ONE OR MORE DUPLICATES");
  LBL_Duplicate.setTextBold();
  LBL_Duplicate.setOpaque(false);
  LBL_Alpha = new GLabel(WIN_Menu, 10, 70, 80, 40);
  LBL_Alpha.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Alpha.setText("MUST BE UPPERCASE ALPHA");
  LBL_Alpha.setTextBold();
  LBL_Alpha.setOpaque(false);
  LBL_CDuplicate = new GLabel(WIN_Menu, 10, 20, 80, 50);
  LBL_CDuplicate.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_CDuplicate.setText("ONE OR MORE DUPLICATES");
  LBL_CDuplicate.setTextBold();
  LBL_CDuplicate.setOpaque(false);
  LBL_Current = new GLabel(WIN_Menu, 130, 440, 130, 20);
  LBL_Current.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Current.setText("Current Mode: Free");
  LBL_Current.setTextBold();
  LBL_Current.setOpaque(false);
  LBL_Range = new GLabel(WIN_Menu, 270, 290, 90, 50);
  LBL_Range.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Range.setText("NOT IN RANGE");
  LBL_Range.setTextBold();
  LBL_Range.setOpaque(false);
  SLD_Red = new GCustomSlider(WIN_Menu, 80, 560, 210, 60, "grey_blue");
  SLD_Red.setShowValue(true);
  SLD_Red.setRotation(PI/2, GControlMode.CORNER);
  SLD_Red.setLimits(128, 0, 255);
  SLD_Red.setNumberFormat(G4P.INTEGER, 0);
  SLD_Red.setOpaque(false);
  SLD_Red.addEventHandler(this, "SLD_Red_change1");
  SLD_Green = new GCustomSlider(WIN_Menu, 170, 560, 210, 60, "DECIMAL");
  SLD_Green.setShowValue(true);
  SLD_Green.setRotation(PI/2, GControlMode.CORNER);
  SLD_Green.setLimits(128, 0, 255);
  SLD_Green.setNumberFormat(G4P.INTEGER, 0);
  SLD_Green.setOpaque(false);
  SLD_Green.addEventHandler(this, "SLD_Green_change1");
  SLD_Blue = new GCustomSlider(WIN_Menu, 260, 560, 210, 60, "grey_blue");
  SLD_Blue.setShowValue(true);
  SLD_Blue.setRotation(PI/2, GControlMode.CORNER);
  SLD_Blue.setLimits(128, 0, 255);
  SLD_Blue.setNumberFormat(G4P.INTEGER, 0);
  SLD_Blue.setOpaque(false);
  SLD_Blue.addEventHandler(this, "SLD_Blue_change1");
  LBL_Red = new GLabel(WIN_Menu, 20, 780, 60, 20);
  LBL_Red.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Red.setText("Red");
  LBL_Red.setTextBold();
  LBL_Red.setOpaque(false);
  LBL_Green = new GLabel(WIN_Menu, 110, 780, 60, 20);
  LBL_Green.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Green.setText("Green");
  LBL_Green.setTextBold();
  LBL_Green.setOpaque(false);
  LBL_Blue = new GLabel(WIN_Menu, 200, 780, 60, 20);
  LBL_Blue.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Blue.setText("Blue");
  LBL_Blue.setTextBold();
  LBL_Blue.setOpaque(false);
  LBL_colourDisplay = new GLabel(WIN_Menu, 270, 770, 100, 30);
  LBL_colourDisplay.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_colourDisplay.setOpaque(false);
  DRP_Faces = new GDropList(WIN_Menu, 280, 530, 90, 140, 6, 10);
  DRP_Faces.setItems(loadStrings("list_391954"), 0);
  DRP_Faces.addEventHandler(this, "dropList1_click1");
  LBL_ColourSampler = new GLabel(WIN_Menu, 150, 530, 90, 20);
  LBL_ColourSampler.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_ColourSampler.setText("Colour Sampler");
  LBL_ColourSampler.setTextBold();
  LBL_ColourSampler.setOpaque(false);
  WIN_Algorithms = GWindow.getWindow(this, "Algorithms", 600, 0, 800, 100, JAVA2D);
  WIN_Algorithms.noLoop();
  WIN_Algorithms.setActionOnClose(G4P.KEEP_OPEN);
  WIN_Algorithms.addDrawHandler(this, "win_draw2");
  LBL_Algorithms = new GLabel(WIN_Algorithms, 0, 0, 800, 100);
  LBL_Algorithms.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Algorithms.setOpaque(false);
  WIN_Builder = GWindow.getWindow(this, "Cube Builder", 0, 0, 500, 500, P2D);
  WIN_Builder.noLoop();
  WIN_Builder.setActionOnClose(G4P.KEEP_OPEN);
  WIN_Builder.addDrawHandler(this, "WIN_Builder_draw");
  WIN_Builder.addMouseHandler(this, "WIN_Builder_mouse_pressed");
  WIN_Builder.addOnCloseHandler(this, "WIN_Builder_close");
  BTN_Load = new GButton(WIN_Builder, 20, 20, 130, 60);
  BTN_Load.setText("LOAD CUBE");
  BTN_Load.setTextBold();
  BTN_Load.addEventHandler(this, "BTN_Load_Pressed");
  LBL_notCustom = new GLabel(WIN_Builder, 390, 30, 90, 40);
  LBL_notCustom.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_notCustom.setText("CUSTOM MODE NOT ENABLED");
  LBL_notCustom.setTextBold();
  LBL_notCustom.setOpaque(false);
  WIN_Timer = GWindow.getWindow(this, "Timer", 850, 850, 240, 120, JAVA2D);
  WIN_Timer.noLoop();
  WIN_Timer.setActionOnClose(G4P.KEEP_OPEN);
  WIN_Timer.addDrawHandler(this, "WIN_Timer_draw");
  LBL_Timer = new GLabel(WIN_Timer, 0, 0, 240, 120);
  LBL_Timer.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  LBL_Timer.setText("TIME");
  LBL_Timer.setOpaque(false);
  WIN_Menu.loop();
  WIN_Algorithms.loop();
  WIN_Builder.loop();
  WIN_Timer.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow WIN_Menu;
GLabel LBL_Title; 
GLabel LBL_Modes; 
GLabel LBL_Settings; 
GLabel LBL_Controls; 
GLabel LBL_Front; 
GTextField TXT_Front; 
GLabel LBL_Back; 
GLabel LBL_Up; 
GLabel LBL_Down; 
GLabel LBL_Menu; 
GLabel LBL_Left; 
GLabel LBL_Right; 
GTextField TXT_Back; 
GTextField TXT_Up; 
GTextField TXT_Down; 
GTextField TXT_Left; 
GTextField TXT_Right; 
GTextField TXT_Menu; 
GButton BTN_Custom; 
GButton BTN_Test; 
GButton BTN_Free; 
GLabel LBL_Colour; 
GLabel LBL_Cube; 
GLabel LBL_CEdge; 
GLabel LBL_CBGround; 
GLabel LBL_CFront; 
GLabel LBL_CBack; 
GLabel LBL_CUp; 
GLabel LBL_CDown; 
GLabel LBL_CLeft; 
GLabel LBL_CRight; 
GTextField TXT_CEdges; 
GTextField TXT_CBGround; 
GTextField TXT_CFront; 
GTextField TXT_CBack; 
GTextField TXT_CUp; 
GTextField TXT_CDown; 
GTextField TXT_CLeft; 
GTextField TXT_CRight; 
GLabel LBL_Rot; 
GTextField TXT_Rot; 
GLabel LBL_AISpeed; 
GTextField TXT_AISpeed; 
GLabel LBL_Valid; 
GLabel LBL_Duplicate; 
GLabel LBL_Alpha; 
GLabel LBL_CDuplicate; 
GLabel LBL_Current; 
GLabel LBL_Range; 
GCustomSlider SLD_Red; 
GCustomSlider SLD_Green; 
GCustomSlider SLD_Blue; 
GLabel LBL_Red; 
GLabel LBL_Green; 
GLabel LBL_Blue; 
GLabel LBL_colourDisplay; 
GDropList DRP_Faces; 
GLabel LBL_ColourSampler; 
GWindow WIN_Algorithms;
GLabel LBL_Algorithms; 
GWindow WIN_Builder;
GButton BTN_Load; 
GLabel LBL_notCustom; 
GWindow WIN_Timer;
GLabel LBL_Timer; 
