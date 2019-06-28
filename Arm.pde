class Arm {
  
  //0 = down | 1 = up | 2 = defending | 3 = back | 4 = front | | 5 = left | 6 = right
  int currentState;
  int restState;
  
  float armAngle;
  float forearmAngle;
  
  int[] armPosition;
  int[] forearmPosition;
  
  Arm(int currentState, int restState, float armAngle, float forearmAngle, int armX, int armY, int forearmX, int forearmY) {
    this.currentState       = currentState;
    this.restState          = restState;
    this.armAngle           = armAngle;
    this.forearmAngle       = forearmAngle;
    this.armPosition        = new int[2];
    this.armPosition[0]     = armX;
    this.armPosition[1]     = armY;
    this.forearmPosition    = new int[2];
    this.forearmPosition[0] = forearmX;
    this.forearmPosition[1] = forearmY;
  } 
  
  void draw() {
    
//    if(armAngle > 190)
//      armAngle -= 360;
//    else if(armAngle < -190)
//      armAngle += 360;
//    
//    if(forearmAngle > 190)
//      forearmAngle -= 360;
//    else if(forearmAngle < -190)
//      forearmAngle += 360;
    
    rectMode(CORNERS);
    
    pushMatrix();
    
//    translate(width/2 + (width/2 - armPosition[0]), height/2 - (height/2 - armPosition[1]) - (40 * scale));
    translate(armPosition[0] + (6*scale), armPosition[1]);
//    translate((width - armPosition[0]), height - armPosition[1] -(40 * scale));
    rotate(radians(-armAngle));
//    translate((width/2 - armPosition[0])-(6 * scale), (height/2 - armPosition[1]));
    translate(-(6 * scale), 0);
    fill(255);
    rect(0, 0, (12 * scale), (40 * scale));
    ellipse(6*scale, 0, 10*scale, 10*scale);
    translate(forearmPosition[0] - armPosition[0]  + (6*scale), forearmPosition[1] - armPosition[1]);
    rotate(radians(armAngle));
    rotate(radians(-forearmAngle));
    translate(-(6 * scale), 0);
    fill(255);
    rect(0, 0, (12 * scale), (40 * scale));
    ellipse(6*scale, 0, 10*scale, 10*scale);
    
    popMatrix();
     
    //drawForearm
//    pushMatrix();
//    translate(forearmPosition[0], forearmPosition[1]);
//    rotate(forearmAngle);
//    fill(255);
//    rect(0, 0, (12 * scale), (40 * scale));
//    popMatrix();
    
  }
  
  float getArmAngleDifference(float angle) { return -(armAngle - angle); }
  
  float getForearmAngleDifference(float angle) { return -(forearmAngle - angle); }
}
