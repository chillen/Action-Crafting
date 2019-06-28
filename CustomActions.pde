//import controlP5.*;

float SPEED_SCALE = 2;
int state = 0;
int cooldown = 0;
int SCREEN_SIZE = 800;
float scale = 1;
Player p1;
//ControlP5 cp5; 
//InfoPanel ip;
int counter = 0;
Action selectedAction;
Subaction selectedSubaction;
Subaction highlightedSubaction;
Subaction defaultHighlight;
ArrayList<Action> actions;
String[] TRANSITIONS = {"Normal", "Quick", "Slow", "Forceful"};
String[] TRANSITION_EFFECTS = {"1x Speed 1x Damage\n 1x AP Cost", "3x Speed 1x Damage\n 2x AP cost", "0.3x Speed 0.1x Damage\n 0.1x AP cost", "2x Speed 2x Damage\n 2x AP cost"};
String[] SUBACTIONS = {"Down", "Up", "Left", "Right", "Back", "Front", "Defend"};

void setup() {
  
  size(SCREEN_SIZE, SCREEN_SIZE);
  p1 = new Player(7 * SCREEN_SIZE/8 , 75, 1, 1, 1, 1, 1);
  //cp5 = new ControlP5(this);
  actions = new ArrayList<Action>();
  addPrebuiltActions();
  actions.add(new Action("New Action"));
  //ip = new InfoPanel(0.5, 0.4);
  selectedAction = actions.get(0);
  selectedSubaction = selectedAction.head;
  defaultHighlight = new Subaction(SUBACTIONS.length, SUBACTIONS.length, SUBACTIONS.length, -10, -10);
  highlightedSubaction = defaultHighlight;
}

void draw() {
  counter++;
  background(0);
   
  switch(state){
    case 0:
      drawTitle();
      break;
    case 1:
      fill(255);
      rectMode(CORNER);
      rect(width - 200, 0, 200, 200);
      if(cooldown != 0)
        cooldown--;
      else
        highlightedSubaction = defaultHighlight; 
      selectedAction.getHighlighted();
      drawActionUI();
      drawSubactionUI();
      selectedAction.draw();
      p1.draw();
      break;    
  }
}

void addPrebuiltActions() {
  //TODO - Add transitions
  Action temp = new Action("Slash");
  Subaction currentSubaction = temp.head;
  currentSubaction.leftArmState = 1;
  currentSubaction.transition = 0;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(0);
  currentSubaction.leftArmState = 5;
  currentSubaction.transition = 1;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(0);
  currentSubaction.leftArmState = 0;
  currentSubaction.transition = 0;
  
  actions.add(temp);
  
  temp = new Action("Assassin's Kiss");
  currentSubaction = temp.head;
  currentSubaction.leftArmState = 4;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(0);
  currentSubaction.leftArmState = 5;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(0);
  currentSubaction.leftArmState = 4;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(0);
  currentSubaction.leftArmState = 5;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(0);
  currentSubaction.leftArmState = 0;
  
  currentSubaction = currentSubaction.parent.parent;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(1);
  currentSubaction.rightArmState = 4;
  currentSubaction.leftArmState = 0;
  currentSubaction.addChild(currentSubaction);
  
  currentSubaction = currentSubaction.children.get(0);
  currentSubaction.rightArmState = 5;
  currentSubaction.addChild(currentSubaction);
  
  actions.add(temp);
  
}

void drawActionUI() {
  
  fill (50);
  rectMode(CORNER);
  rect(0, 0, 200, height);
  
  fill(100);
  rectMode(RADIUS);
  rect(100, 30, 90, 20);
  rect(100, 80, 90, 20);
  rect(100, 130, 90, 20);
  
  for(int i = 0; i < actions.size(); i++) {
    
    fill(100);
    rectMode(RADIUS);
    
    if(actions.get(i) == selectedAction)
      fill(160, 80, 80);
      
    rect(100, 30 + (i * 50), 90, 20);
    
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text(actions.get(i).name, 100, 30 + (i * 50));
  }
    
  
}

void drawSubactionUI() {
  fill (50);
  rectMode(CORNER);
  rect(0, height - 200, width, 200);
  textSize(20);
  textAlign(CENTER, TOP);
  fill(255);
  text("Left Arm",  100, height - 200);
  text("Right Arm", 300, height - 200);
  text("Transition", 500, height - 200);
  text("Effect", 500, height - 75);
  
  textSize(14);
  textAlign(CENTER, TOP);
  text(TRANSITION_EFFECTS[selectedSubaction.transition], 500, height - 50);
  
  fill(80);
  rectMode(RADIUS);
  for(int i = 0; i < 7; i++){
    fill(80);
    if(i == selectedSubaction.leftArmState)
      fill(160, 80, 80);
    if(i == highlightedSubaction.leftArmState)
      fill(80, 80, 80 + (cooldown * 2));
    if(i == highlightedSubaction.leftArmState && i == selectedSubaction.leftArmState)
      fill(160 - (cooldown * 2), 80, 80 + (cooldown * 2));
    rect(100, height - 165 + (i * 25), 95, 10);
    fill(80);
    if(i == selectedSubaction.rightArmState)
      fill(160, 80, 80);
    if(i == highlightedSubaction.rightArmState)
      fill(80, 80, 80 + (cooldown * 2));
    if(i == highlightedSubaction.rightArmState && i == selectedSubaction.rightArmState)
      fill(160 - (cooldown * 2), 80, 80 + (cooldown * 2));
    rect(300, height - 165 + (i * 25), 95, 10);
    fill(80);
    if(i > 3)
      continue;
    if(i == selectedSubaction.transition)
      fill(160, 80, 80);
    if(i == highlightedSubaction.transition)
      fill(80, 80, 80 + (cooldown * 2));
    if(i == highlightedSubaction.transition && i == selectedSubaction.transition)
      fill(160 - (cooldown * 2), 80, 80 + (cooldown * 2));
    rect(500, height - 165 + (i * 25), 95, 10);
  }
  
  fill(100);
  rectMode(RADIUS);
  rect(700, height - 125, 80, 20);
  rect(700, height - 75, 80, 20);
  
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  text("Down", 100, height - 165);
  text("Up", 100, height - 140);
  text("Left", 100, height - 115);
  text("Right", 100, height - 90);
  text("Back", 100, height - 65);
  text("Front", 100, height - 40);
  text("Defend", 100, height - 15);
  
  text("Down", 300, height - 165);
  text("Up", 300, height - 140);
  text("Left", 300, height - 115);
  text("Right", 300, height - 90);
  text("Back", 300, height - 65);
  text("Front", 300, height - 40);
  text("Defend", 300, height - 15);
  
  text("Normal", 500, height - 165);
  text("Quick", 500, height - 140);
  text("Slow", 500, height - 115);
  text("Forceful", 500, height - 90);
  
  text("Add Child", 700, height - 125);
  text("Delete Subaction", 700, height - 75);
  
}

void drawTitle() {
  textAlign(CENTER, CENTER);
  textSize(25);
  fill(255);
  text("Player Customized Actions in Action Games", SCREEN_SIZE/2, 100);
  text("Eashan Singh - 100854996", SCREEN_SIZE/2, 150);
  text("Connor Hillen - 100852453", SCREEN_SIZE/2, 200);
  textSize(15);
  text("Included are three actions available to modify; \n one is simple, one more complex, and one represents a fresh action.\n To view an action, click on a node. This will begin from the head until that node.\n When clicking a node, you may change how it is transitioned into\n and select the form you want the skeleton to be in.\n Hovering over a node will briefly show its properties.", SCREEN_SIZE/2, SCREEN_SIZE/2 + 50);

  text("Press any key to advance into the crafting screen", SCREEN_SIZE/2, SCREEN_SIZE - 50);
  
  if(keyPressed) {
    state++;
  }
}

void mousePressed() {
  
  selectedAction.getSubaction();
  
  for(int i = 0; i < 7; i++) {
    if(mouseX > 5 && mouseX < 195 && mouseY > (height - 175 + (i * 25)) && mouseY < (height - 155 + (i * 25)))
      selectedSubaction.leftArmState = i;
    if(mouseX > 205 && mouseX < 395 && mouseY > (height - 175 + (i * 25)) && mouseY < (height - 155 + (i * 25)))
      selectedSubaction.rightArmState = i;
    if(i > 3)
      continue;
    if(mouseX > 405 && mouseX < 595 && mouseY > (height - 175 + (i * 25)) && mouseY < (height - 155 + (i * 25)))
      selectedSubaction.transition = i;
  }
  if(mouseX > 620 && mouseX < 780 && mouseY > (height - 145) && mouseY < (height - 105))
    selectedSubaction.addChild(selectedSubaction);
  
  if(mouseX > 620 && mouseX < 780 && mouseY > (height - 95) && mouseY < (height - 55)) {
    if(selectedSubaction.parent != null) {
      Subaction temp = selectedSubaction;
      selectedSubaction = temp.parent;
      selectedSubaction.deleteChild(temp);
    }
  }
  
  for(int i = 0; i < actions.size(); i++)
    if(mouseX > 10 && mouseX < 190 && mouseY > 10 + (i * 50) && mouseY < 50 + (i * 50))
      selectedAction = actions.get(i);
  
}
