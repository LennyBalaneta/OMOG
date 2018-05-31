ControllPoint[] cPoints;
int qtdCP;
CurveI[] curves;

void setup() {
  size(800, 600);
  frameRate(30);
  //array of curves
  curves = new CurveI[2];

  //curve 0 -> BSpline
  qtdCP = 5;
  cPoints = new ControllPoint[qtdCP];
  for (int i=0; i<qtdCP; i++) {
    cPoints[i] = new ControllPoint((width/2*(i+1)/(qtdCP+1)), height/2, 0);
  }
  curves[0] = new BSpline(cPoints, 4);

  //curve 1 -> Nurbs
  qtdCP = 5;
  cPoints = new ControllPoint[qtdCP];
  for (int i=0; i<qtdCP; i++) {
    cPoints[i] = new ControllPoint((width/2 + width/2*(i+1)/(qtdCP+1)), height/2, 0);
  }
  curves[1] = new Nurbs(cPoints, 4);
}

void draw() {
  background(255);
  stroke(0);
  for (int i=0; i< curves.length; i++) {
    curves[i].showCurve();
    curves[i].updateCPoints();
    curves[i].drawCPoints();
  }
  showJointButtons();
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

void showJointButtons() {
  fill(34, 123, 119);
  stroke(0);
  ellipse(30, 570, 40, 40);//c0
  ellipse(80, 570, 40, 40);//c1
  ellipse(130, 570, 40, 40);//c2

  fill(0);
  text("c0", 20, 576);
  text("c1", 70, 576);
  text("c2", 120, 576);
}

void mousePressed() {
  for (int i=0; i< curves.length; i++) {
    colisionVerification(curves[i]);
  }

  for (int i=0; i< curves.length; i++) {
    if (curves[i] instanceof Nurbs) {
      colisionWeightsVerification(curves[i]);
    }
  }
}

void mouseReleased() {
  //Move controll points
  for (int i=0; i< curves.length; i++) {
    releaseAll(curves[i]);
  }

  //Change the weigths of Nurbs curve
  for (int i=0; i< curves.length; i++) {
    if (curves[i] instanceof Nurbs) {
      releaseWeightsAll(curves[i]);
    }
  }
  //joint buttons
  if (sqrt(sq(mouseX-(30)) + sq(mouseY-570)) < 20) {//c0
    Joint.c0(curves[0], curves[1]);
  }
  if (sqrt(sq(mouseX-(80)) + sq(mouseY-570)) < 20) {//c1
    Joint.c1(curves[0], curves[1]);
  }
  if (sqrt(sq(mouseX-(130)) + sq(mouseY-570)) < 20) {//c2
    Joint.c2(curves[0], curves[1]);
  }
}
