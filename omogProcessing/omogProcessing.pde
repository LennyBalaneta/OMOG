ControllPoint[] cPoints;
int qtdCP;
CurveI[] curves;

void setup() {
  size(800, 600);
  frameRate(30);
  //array of curves
  curves = new CurveI[1];

  //curve 1
  qtdCP = 5;
  cPoints = new ControllPoint[qtdCP];
  for (int i=0; i<qtdCP; i++) {
    cPoints[i] = new ControllPoint((width*(i+1)/(qtdCP+1)), height/2, 0);
  }
  curves[0] = new Nurbs(cPoints, 4);
}

void draw() {
  background(255);
  strokeWeight(15);
  stroke(0);
  for (int i=0; i< curves.length; i++) {
    curves[i].showCurve();
    curves[i].updateCPoints();
    curves[i].drawCPoints();
  }
}

void colisionVerification(CurveI c) {
  for (int i=0; i<c.cPoints.length; i++) {
    if (sqrt(sq(mouseX-c.cPoints[i].x) + sq(mouseY-c.cPoints[i].y)) < c.cPoints[i].radius) {
      c.cPoints[i].selected = true;
    }
  }
}

void releaseAll(CurveI c) {
  for (int i=0; i<c.cPoints.length; i++) {
    c.cPoints[i].selected = false;
  }
}

void releaseWeightsAll(CurveI c) {
  for (int i=0; i<c.cPoints.length; i++) {
    c.cPoints[i].selectedPlus = false;
    c.cPoints[i].selectedMinus = false;
  }
}

void colisionWeightsVerification(CurveI c) {
  for (int i=0; i<c.cPoints.length; i++) {
    if (sqrt(sq(mouseX-(20+50*i)) + sq(mouseY-25)) < c.cPoints[i].radius) {
      c.cPoints[i].selectedPlus = true;
    }
    if (sqrt(sq(mouseX-(20+50*i)) + sq(mouseY-65)) < c.cPoints[i].radius) {
      c.cPoints[i].selectedMinus = true;
    }
  }
}

void mousePressed() {
  for (int i=0; i< curves.length; i++) {
    colisionVerification(curves[i]);
  }
  
  for (int i=0; i< curves.length; i++) {
    if(curves[i] instanceof Nurbs) {
      colisionWeightsVerification(curves[i]);
    }
  }
}

void mouseReleased() {
  for (int i=0; i< curves.length; i++) {
    releaseAll(curves[i]);
  }
  
  for (int i=0; i< curves.length; i++) {
    if(curves[i] instanceof Nurbs) {
      releaseWeightsAll(curves[i]);
    }
  }
}