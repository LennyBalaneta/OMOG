class CurveI {
  boolean onlyPoints = true;
  float increment;
  ControllPoint[] cPoints;
  int n, k;
  color curveColor;

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

  float getX(float u) {
    return -1;
  }

  float getY(float u) {
    return -1;
  }

  color getColor() {
    return this.curveColor;
  }

  float derivativePre(float u, float h) {
    //Numerical derivation using 3 points before x0
    float dx = 1/(2*h) * (this.getX(u - 2*h) - 4*this.getX(u-h) + 3*this.getX(u));
    float dy = 1/(2*h) * (this.getY(u - 2*h) - 4*this.getY(u-h) + 3*this.getY(u));
    return dy/dx;
  }

  float derivativePos(float u, float h) {
    //Numerical derivation using 3 points after x0
    float dx = 1/(2*h) * (-3*this.getX(u) + 4*this.getX(u+h) - this.getX(u+2*h));
    float dy = 1/(2*h) * (-3*this.getY(u) + 4*this.getY(u+h) - this.getY(u+2*h));
    return dy/dx;
  }

  void showDerivativeLastPoint() {
    float a = this.derivativePre(float(this.n-this.k+2), globalH);
    float x = this.getX(float(this.n-this.k+2));
    float y = this.getY(float(this.n-this.k+2));
    float b = y - a*x;
    line(0, 0*a + b, width, width*a + b);
  }

  void showDerivativeFirstPoint() {
    float a = this.derivativePos(0, globalH);
    float x = this.getX(0);
    float y = this.getY(0);
    float b = y - a*x;
    line(0, 0*a + b, width, width*a + b);
  }

  float secondDerivative(float u, float h) {
    //Numerical second derivation
    float dx = (this.getX(u+h) - 2*this.getX(u) + this.getX(u-h))/sq(h);
    float dy = (this.getY(u+h) - 2*this.getY(u) + this.getY(u-h))/sq(h);
    return (dy/dx);
  }
}