float c1MaxError = 0.2;
float c2MaxError = 0.5;
float globalH = 0.001;

void c0(CurveI curve1, CurveI curve2) {
  println("-----Start c0-----");
  float difX = curve1.cPoints[curve1.cPoints.length-1].x - curve2.cPoints[0].x;
  float difY = curve1.cPoints[curve1.cPoints.length-1].y - curve2.cPoints[0].y;
  for (int i=0; i<curve2.cPoints.length; i++ ) {
    curve2.cPoints[i].x += difX;
    curve2.cPoints[i].y += difY;
  }
  println("-----Finish c0-----");
}

void c1(CurveI curve1, CurveI curve2) {
  c0(curve1, curve2);
  println("-----Start c1-----");

  float dC1 = curve1.derivativePre(float(curve1.n-curve1.k+2), globalH);
  float dC2 = curve2.derivativePos(0, globalH);
  println("Curve 1 first derivative:"+dC1);
  println("Curve 2 initial first derivative:"+dC2);

  //TODO improve the brute force method(p0 foreward)
  float yOld = curve2.cPoints[1].y;
  float c1ActualError = 0.001;

  if (abs(dC1 - dC2) > c1ActualError) {
    curve2.cPoints[1].y = 0;
  }
  while (abs(dC1 - dC2) > c1ActualError) {
    curve2.cPoints[1].y += 1;
    dC2 = curve2.derivativePos(0, globalH);
    if (curve2.cPoints[1].y > 1000) {
      if (c1ActualError >= c1MaxError) {
        println("****Error to find c1****");
        curve2.cPoints[1].y = yOld;
        break;
      } else {
        curve2.cPoints[1].y = 0;
        c1ActualError *= 2;
        if (c1ActualError > c1MaxError) {
          c1ActualError = c1MaxError;
        }
        println("Changing max error to "+c1ActualError);
      }
    }
  }
  println("Curve 2 final first derivative:"+dC2);
  println("-----Finish c1-----");
}

void c2(CurveI curve1, CurveI curve2) {
  c1(curve1, curve2);
  //TODO don't use x0-h and 0+h
  println("-----Start c2-----");
  float d2C1 = curve1.secondDerivative(float(curve1.n-curve1.k+2)-globalH, globalH);
  float d2C2 = curve2.secondDerivative(0+globalH, globalH);
  println("Curve 1 second derivative:"+d2C1);
  println("Curve 2 second derivative:"+d2C2);

  //Find the equation of the line
  float a = curve2.derivativePos(0, globalH);
  float x = curve2.getX(0);
  float y = curve2.getY(0);
  float b = y - a*x;

  float xOld = curve2.cPoints[1].x;
  float yOld = curve2.cPoints[1].y;
  if (abs(d2C1 - d2C2) > c2MaxError) {
    curve2.cPoints[1].x = 0;
  }
  float c2ActualError = 0.05;

  //curve2.cPoints[1].x = 0;
  //line(0, 0*a + b, width, width*a + b);
  while (abs(d2C1 - d2C2) > c2ActualError) {
    curve2.cPoints[1].x += 1;
    curve2.cPoints[1].y = a*curve2.cPoints[1].x + b;
    d2C2 = curve2.secondDerivative(0+globalH, globalH);

    if (curve2.cPoints[1].x > 1000) {
      if (c2ActualError == c2MaxError) {
        println("****Error to find c2****");
        curve2.cPoints[1].x = xOld;
        curve2.cPoints[1].y = yOld;
        break;
      } else {
        curve2.cPoints[1].x = 0;
        c2ActualError *= 2;
        if (c2ActualError > c2MaxError) {
          c2ActualError = c2MaxError;
        }
        println("Changing max error to "+c2ActualError);
      }
    }
  }
  println("Curve 2 final first derivative:"+d2C2);
  println("-----Finish c2-----");
}