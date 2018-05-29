class BSpline extends CurveI {
  ControllPoint[] cPoints;
  int k, n;
  FloatList t;
  
  BSpline(ControllPoint[] cps) {
    super(cps);
    this.cPoints = cps;
    this.k = 4;
    this.n = this.cPoints.length - 1;
    this.t = this.generateT();
  }
  
  void showCurve() {
    strokeWeight(2);
    for (float u=0; u<=this.n-this.k+2; u+=0.005) {
      stroke(0);
      float x = this.getX(u);
      float y = this.getY(u);
      point(x, y);
    }
  }
  
    FloatList generateT() {
    boolean periodic = false;
    FloatList ts = new FloatList();

    if (periodic) {
      float m = this.n-this.k+2;
      float tot = this.n+this.k+1;
      for (int i=0; i<=this.n+this.k+1; i++) {
        ts.append((m/tot)*i);
      }
    } else {
      for (int i=0; i<this.n+this.k+1; i++) {
        if (i < this.k) {
          ts.append(0);
        } else if (i <= this.n) {
          ts.append(i - this.k + 1);
        } else {
          ts.append(this.n - this.k + 2);
        }
      }
    }
    print("knots: " + ts);
    return ts;
  }
  
  float getN(int i, int k, float u) {
    if (k == 1) {//sei la 0 ou 1
      if (this.t.get(i) <= u && u <= this.t.get(i+1)) {
        return 1.0;
      } else {
        return 0.0;
      }
    }

    //k > 1
    float t1 = ((u-this.t.get(i))) * this.getN(i, k-1, u);
    float dt1 = (this.t.get(i+k-1)-this.t.get(i));
    if (dt1 == 0) {
      dt1 = 1;
      t1 = 0;
    }
    float t2 = ((this.t.get(i+k) - u)) * this.getN(i+1, k-1, u);
    float dt2 = (this.t.get(i+k) - this.t.get(i+1));
    if (dt2 == 0) {
      dt2 = 1;
      t2 = 0;
    }
    float niku = t1/dt1 + t2/dt2;
    return niku;
  }
  
  float getX(float u) {
    float valX = 0;
    for (int i=0; i<this.cPoints.length; i++) {
      valX += this.getN(i, this.k, u) * cPoints[i].x;
    }
    return valX;
  }
  float getY(float u) {
    float valY = 0;
    for (int i=0; i<this.cPoints.length; i++) {
      valY += this.getN(i, this.k, u) * cPoints[i].y;
    }
    return valY;
  }
}