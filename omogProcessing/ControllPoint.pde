class ControllPoint {
  float radius = 8, x, y, z;
  boolean selected;
  
  ControllPoint(float pX, float pY, float pZ) {
  this.x = pX;
  this.y = pY;
  this.z = pZ;
  this.selected = false;
  }
  
  void show() {
    ellipse(this.x, this.y, this.radius*2, this.radius*2);
  }
  
  void update() {
    if (this.selected == true) {
      this.x = mouseX;
      this.y = mouseY;
    }
  }
}