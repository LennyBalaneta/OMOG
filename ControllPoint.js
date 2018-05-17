ControllPoint.radius = 8;//the radius of each controll point
function ControllPoint(pX, pY, pZ) {
  this.x = pX;
  this.y = pY;
  this.z = pZ;
  this.selected = false;
 
  this.show = function() {
    ellipse(this.x, this.y, ControllPoint.radius*2, ControllPoint.radius*2);
  }
 
  this.update = function() {
    if(this.selected == true) {
      this.x = mouseX;
      this.y = mouseY;
    }
  }
}