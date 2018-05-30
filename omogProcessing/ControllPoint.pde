class ControllPoint {
  float radius = 8, x, y, z, weight;
  boolean selected, selectedPlus, selectedMinus;

  ControllPoint(float pX, float pY, float pZ) {
    this.x = pX;
    this.y = pY;
    this.z = pZ;
    this.weight = 1.0;
    this.selected = false;
    this.selectedPlus = false;
    this.selectedMinus = false;
  }

  void show() {
    ellipse(this.x, this.y, this.radius*2, this.radius*2);
  }

  void update() {
    if (this.selected == true) {
      this.x = mouseX;
      this.y = mouseY;
    }
    if(this.selectedPlus == true) {
      this.weight += 0.2;
    }
    if(this.selectedMinus == true) {
      this.weight -= 0.2;
      if(this.weight < 0) {
        this.weight = 0.0;
      }
    }
  }
}