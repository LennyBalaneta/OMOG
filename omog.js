var cPoints, qtdCP, curves;

function setup() {
  createCanvas(800, 600);

  //array of curves
  curves = [];

  //curve 1
  cPoints = [];
  qtdCP = 2;
  for (var i=0; i<qtdCP; i++) {
    cPoints.push(new ControllPoint(width*(i/(qtdCP+1))+width/(qtdCP+1), height/2, 0));
  }
  curves.push(new Line(cPoints));
}

function draw() {
  background(255);
  strokeWeight(15);
  noFill();
  rect(0, 0, width, height);

  for (var i=0; i< curves.length; i++) {
    curves[i].updateCPoints();
    curves[i].drawCPoints();
    curves[i].parameters();
    curves[i].showCurve();
  }
}

function colisionVerification(c) {
  for (var i=0; i<c.cPoints.length; i++) {
    if (sqrt(sq(mouseX-c.cPoints[i].x) + sq(mouseY-c.cPoints[i].y)) < ControllPoint.radius) {
      c.cPoints[i].selected = true;
    }
  }
}

function releaseAll(c) {
  for (var i=0; i<c.cPoints.length; i++) {
    c.cPoints[i].selected = false;
  }
}

function mousePressed() {
  for (var i=0; i< curves.length; i++) {
    colisionVerification(curves[i]);
  }
}

function mouseReleased() {
  for (var i=0; i< curves.length; i++) {
    releaseAll(curves[i]);
  }
}