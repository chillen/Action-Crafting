class Subaction {
  
  int[] position;
  
  //For tree balancing
  int minX;
  int maxX;
  
  //0 = Down | 1 = Up | 2 = Left | 3 = Right | 4 = Back | 5 = Forward | 6 = Defend
  int leftArmState;
  int rightArmState;
  
  //0 = Normal | 1 = Quick | 2 = Slow | 3 - Forceful 
  int transition;
  
  Subaction parent;
  ArrayList<Subaction> children;
  
  Subaction(int leftArmState, int rightArmState, int intent, int minX, int maxX){
    this(leftArmState, rightArmState, intent, minX, maxX, null);
  }
  
  Subaction(int leftArmState, int rightArmState, int transition, int minX, int maxX, Subaction parent){
    this.leftArmState  = leftArmState;
    this.rightArmState = rightArmState;
    this.transition    = transition;
    this.minX          = minX;
    this.maxX          = maxX;
    this.children      = new ArrayList<Subaction>();
    this.position      = new int[2];
    this.position[0]   = (minX + maxX) / 2;
    this.parent        = parent;
    if(parent != null)
      this.position[1] = parent.position[1] + 75;
    else
      this.position[1] = 40;
  }
  
  void delete() {
    if(parent != null)
      parent.deleteChild(this);
  }
  
  void deleteChild(Subaction child) {
    children.remove(child);
    balance();
  }
  
  void addChild(Subaction parent) {
    children.add(new Subaction(0, 0, 0, minX, maxX, parent));
    balance(); 
  }
  
  void balance() {
    if(children.isEmpty())
      return;
    int numChildren = children.size();
    float space = 0;
    if(numChildren > 1) {
    space = (maxX - minX) / (numChildren) * 1.0;
      for(int i = 0; i < numChildren; i++) {
        children.get(i).minX = (int) (minX + (i * space));
  //      children.get(i).maxX = minX + ((i + 1) * (maxX - minX)/numChildren);
        children.get(i).maxX = (int) (children.get(i).minX + space);
        children.get(i).calculatePosition();
        children.get(i).balance();
      }
    }
    if(numChildren == 1) {
      children.get(0).minX = minX;
      children.get(0).maxX = maxX;
      children.get(0).calculatePosition();
      return;
    }
  }
  
  void calculatePosition() { position[0] = (minX + maxX) / 2; }
  
  void draw() {
    for(Subaction child : children) {
      stroke(255);
      line(position[0], position[1], child.position[0], child.position[1]);
      child.draw();
    }
    fill(255);
    if(selectedSubaction == this)
      fill(255, 0, 0);
    noStroke();
    ellipse(position[0], position[1], 20, 20);
  }
  
  void search() {
    
    for(Subaction child : children)
      child.search();
        
    if(sqrt(sq(mouseX - position[0]) + sq(mouseY - position[1])) < 10) {
      selectedSubaction = this;
      p1.setupAction(this);
    }
  }
  
  void highlighted() {
    
    for(Subaction child : children)
      child.highlighted();
        
    if(sqrt(sq(mouseX - position[0]) + sq(mouseY - position[1])) < 10) {
      cooldown = 40;
      highlightedSubaction = this;
    }
    
  }
  
}
