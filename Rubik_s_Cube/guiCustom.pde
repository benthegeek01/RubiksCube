//CUSTOMISES GUI ONCE IT IS BOOTED UP
Build_Side[] sides = new Build_Side[6];
public void customGUI() {
  LBL_Valid.setVisible(false);
  LBL_Duplicate.setVisible(false);
  LBL_Alpha.setVisible(false);
  LBL_CDuplicate.setVisible(false);
  LBL_Range.setVisible(false);
  LBL_Title.setFont(new Font("Monospaced", Font.PLAIN, 20));
  LBL_Settings.setFont(new Font("Monospaced", Font.PLAIN, 16)); 
  LBL_Modes.setFont(new Font("Monospaced", Font.PLAIN, 16));
  LBL_Colour.setFont(new Font("Monospaced", Font.PLAIN, 14));
  LBL_Controls.setFont(new Font("Monospaced", Font.PLAIN, 14));
  LBL_Cube.setFont(new Font("Monospaced", Font.PLAIN, 14));
  TXT_CBGround.setPromptText(hex(bgc, 6));
  WIN_Algorithms.setLocation(displayWidth/2 - 400, 0);
  LBL_Algorithms.setFont(new Font("Monospaced", Font.PLAIN, 50));
  LBL_Algorithms.setText("Rubik's Cube");
  LBL_Algorithms.setTextBold();
  WIN_Builder.setLocation(displayWidth - 500, 0);
  sides[0] = new Build_Side(250, 70, 0); //back
  sides[1] = new Build_Side(130, 190, 2); //left
  sides[2] = new Build_Side(250, 190, 4); //down
  sides[3] = new Build_Side(370, 190, 3); //right
  sides[4] = new Build_Side(250, 310, 1); //front
  sides[5] = new Build_Side(250, 430, 5); //up
}
