class Nurbs extends CurveI {
  ControllPoint[] cPoints;
  int k, n;
  FloatList t;
  color curveColor;

  Nurbs(ControllPoint[] cps, int k) {
    super(cps);
    this.cPoints = cps;
    this.k = k;
    this.n = this.cPoints.length - 1;
    this.t = this.generateT();
    this.curveColor = color(3, 116, 29);
  }

  void showCurve() {
    strokeWeight(2);
    stroke(this.curveColor);
    for (float u=0; u<=this.n-this.k+2; u+=this.increment) {
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
    println("Knots Nurbs: " + ts);
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
    float valX = 0, denValX = 0;
    for (int i=0; i<this.cPoints.length; i++) {
      float baseFunc = this.getN(i, this.k, u);
      valX += baseFunc * cPoints[i].x * cPoints[i].weight;
      denValX += baseFunc * cPoints[i].weight;
    }
    return valX/denValX;
  }
  float getY(float u) {
    float valY = 0, denValY = 0;
    for (int i=0; i<this.cPoints.length; i++) {
      float baseFunc = this.getN(i, this.k, u);
      valY += baseFunc * cPoints[i].y * cPoints[i].weight;
      denValY += baseFunc * cPoints[i].weight;
    }
    return valY/denValY;
  }

  void drawCPoints() {
    strokeWeight(2);
    fill(0);
    //Points
    for (int i=0; i<this.cPoints.length; i++) {
      this.cPoints[i].show();
    }

    //Weights
    for (int i=0; i<this.cPoints.length; i++) {
      textSize(12);
      fill(0);
      text("CP"+i, 10+50*i, 10);
      ellipse(20+50*i, 25, 20, 20);
      text(nf(this.cPoints[i].weight, 0, 2), 10+50*i, 50);
      ellipse(20+50*i, 65, 20, 20);
      fill(255);
      textSize(20);
      text("+", 12+50*i, 30);
      text("-", 15+50*i, 70);
    }
  }
}
