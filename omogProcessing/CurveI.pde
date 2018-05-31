class CurveI {
  boolean onlyPoints = true;
  float increment;
  ControllPoint[] cPoints;

  CurveI(ControllPoint[] cps) {
    this.cPoints = cps;
    this.increment = 0.005;
  }

  void drawCPoints() {
    strokeWeight(2);
    fill(0);
    for (int i=0; i<this.cPoints.length; i++) {
      this.cPoints[i].show();
    }
  }

  void updateCPoints() {
    for (int i=0; i<this.cPoints.length; i++) {
      this.cPoints[i].update();
    }
  }

  void showCurve() {
  }
}
