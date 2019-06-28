class Action {
  
  Subaction head;
  String    name;
  
  Action(String name) {
    head = new Subaction(0, 0, 0, 200, width - 200);
    this.name = name;
  }
  
  void draw() { head.draw(); }
  
  void getSubaction() { head.search(); }
  
  void getHighlighted() { head.highlighted(); }
}
