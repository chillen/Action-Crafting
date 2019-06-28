class Player {
  
  int posX;
  int posY;
  
  int str;
  int spd;
  int intel;
  int bal;
  int sta;  
  
  int selected;
  
  Arm leftArm;
  Arm rightArm;
  
  float [] desiredArmAngles = {0, 170, 30, -30, -70, 60, 45};
  float [] desiredForearmAngles = {0, 180, 30, -30, 30, 90, 180};
  float [] modifiers = {1, 3, 0.3, 2};
  
  boolean twoHanded;
  
  ArrayList<Subaction> actionQueue;
  
  Player(int posX, int posY, int str, int spd, int intel, int bal, int sta) {
    this.posX  = posX;
    this.posY  = posY;
    this.str   = str;
    this.spd   = spd;
    this.intel = intel;
    this.bal   = bal;
    this.sta   = sta;
  
    selected = 0;
    
    leftArm = new Arm(0, 0, 0, 0, (int)(posX - (8 * scale)), (int)(posY - (40 * scale)), (int)(posX - (8 * scale)), posY);
    rightArm = new Arm(0, 0, 0, 0, (int)(posX - (8 * scale)), (int)(posY - (40 * scale)), (int)(posX - (8 * scale)), posY);
    
    twoHanded = false;
    
    setupAction(selectedSubaction);
  }
  
  void draw() {
    stroke(0);
    leftArm.draw();
    
    //torso
    rectMode(RADIUS);
    fill(#C3B091);
    rect(posX, posY, (10 * scale), (40 * scale));
    
    //head
    fill(255);
    ellipse(posX, posY-(55*scale), 30*scale, 30*scale);
    
    rectMode(CORNER);
    fill(50, 50, 200);
    rect(posX - (10 * scale), posY  + (40 * scale), (20 * scale), (80 * scale));
    
    rightArm.draw();
    
    doAction();
  }
  
  void setupAction(Subaction currentAction) {
    leftArm = new Arm(0, 0, 0, 0, (int)(posX - (8 * scale)), (int)(posY - (40 * scale)), (int)(posX - (8 * scale)), posY);
    rightArm = new Arm(0, 0, 0, 0, (int)(posX - (8 * scale)), (int)(posY - (40 * scale)), (int)(posX - (8 * scale)), posY);
    
    actionQueue = new ArrayList<Subaction>();
    
    while(currentAction != null) {
      actionQueue.add(currentAction);
      currentAction = currentAction.parent;
    }
  }
  
  void doAction() {
    int count = 0;
//    if(actionQueue.isEmpty())
//      setupAction(selectedSubaction);
    if(actionQueue.isEmpty())
      return;
    Subaction current = actionQueue.get(actionQueue.size() - 1);
    
//    for(int i = 0; i < desiredArmAngles.length; i++) {
//      if(current.leftArmState == i) {
//        
//      } 
//    }
    
    if(abs(leftArm.getArmAngleDifference(desiredArmAngles[current.leftArmState])) < (spd * modifiers[current.transition] * SPEED_SCALE * 1.0)) {
      leftArm.armAngle = desiredArmAngles[current.leftArmState];
      count++;
    }
    if(abs(rightArm.getArmAngleDifference(desiredArmAngles[current.rightArmState])) < (spd * modifiers[current.transition] * SPEED_SCALE * 1.0)) {
      rightArm.armAngle = desiredArmAngles[current.rightArmState];
      count++;
    }
    if(abs(leftArm.getForearmAngleDifference(desiredForearmAngles[current.leftArmState])) < (spd * modifiers[current.transition] * SPEED_SCALE * 1.0)) {
      leftArm.forearmAngle = desiredForearmAngles[current.leftArmState];
      count++;
    }
    if(abs(rightArm.getForearmAngleDifference(desiredForearmAngles[current.rightArmState])) < (spd * modifiers[current.transition] * SPEED_SCALE * 1.0)) {
      rightArm.forearmAngle = desiredForearmAngles[current.rightArmState];
      count++;
    }
    
    if(count == 4) {
      actionQueue.remove(actionQueue.size() - 1);
      return;
    }
    
    if(leftArm.getArmAngleDifference(desiredArmAngles[current.leftArmState]) < 0)
      leftArm.armAngle -= spd * modifiers[current.transition] * SPEED_SCALE * 1.0;
    else if(leftArm.getArmAngleDifference(desiredArmAngles[current.leftArmState]) > 0)
      leftArm.armAngle += spd * modifiers[current.transition] * SPEED_SCALE * 1.0;
      
    if(rightArm.getArmAngleDifference(desiredArmAngles[current.rightArmState]) < 0)
      rightArm.armAngle -= spd * modifiers[current.transition] * SPEED_SCALE * 1.0;
    else if (rightArm.getArmAngleDifference(desiredArmAngles[current.rightArmState]) > 0)
      rightArm.armAngle += spd * modifiers[current.transition] * SPEED_SCALE * 1.0;
      
     if(leftArm.getForearmAngleDifference(desiredForearmAngles[current.leftArmState]) < 0)
      leftArm.forearmAngle -= spd * modifiers[current.transition] * SPEED_SCALE * 1.0;
    else if(leftArm.getForearmAngleDifference(desiredForearmAngles[current.leftArmState]) > 0)
      leftArm.forearmAngle += spd * modifiers[current.transition] * SPEED_SCALE * 1.0;
      
    if(rightArm.getForearmAngleDifference(desiredForearmAngles[current.rightArmState]) < 0)
      rightArm.forearmAngle -= spd * modifiers[current.transition] * SPEED_SCALE * 1.0;
    else if (rightArm.getForearmAngleDifference(desiredForearmAngles[current.rightArmState]) > 0)
      rightArm.forearmAngle += spd * modifiers[current.transition] * SPEED_SCALE * 1.0;

  }
  
}
