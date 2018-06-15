float c1MaxError = 0.2;
float c1IMaxError = 0.5;
float c2MaxError = 0.5;
float globalH = 0.1;

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
        println("****Error to find g1****");
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
  println("g1 achieved");
  //g1 achieved
  float intensityV1 = sqrt(sq(curve1.getX(curve1.n-curve1.k+2) - curve1.getX(curve1.n-curve1.k+2-globalH))//
  + sq(curve1.getY(curve1.n-curve1.k+2) - curve1.getY(curve1.n-curve1.k+2-globalH)));
  
  float intensityV2 = sqrt(sq(curve2.getX(0) - curve2.getX(0+globalH))//
  + sq(curve2.getY(0) - curve2.getY(0+globalH)));
  
  float distV1V2 = sqrt(sq(curve1.cPoints[curve1.cPoints.length-2].x-curve2.cPoints[1].x)//
  + sq(curve1.cPoints[curve1.cPoints.length-2].y-curve2.cPoints[1].y));
  println("Curve 1 initial intensity:"+intensityV1);
  println("Curve 2 initial intensity:"+intensityV2);
  
  //Find the equation of the line
  float a = dC2;
  float x = curve2.cPoints[1].x;
  float y = curve2.cPoints[1].y;
  float b = y - a*x;
  stroke(255, 0, 0);
  strokeWeight(10);
  //line(0, 0*a + b, width, width*a + b);
  //noLoop();
  
  float xOld = curve2.cPoints[1].x;
  yOld = curve2.cPoints[1].y;
  float c1IActualError = 0.005;
  if (abs(intensityV1 - intensityV2) > c1IActualError || distV1V2 < 30) {
    curve2.cPoints[1].x = 0;
  }
  
  while (abs(intensityV1 - intensityV2) > c1IActualError || distV1V2 < 30) {
    curve2.cPoints[1].x += 1;
    curve2.cPoints[1].y = a*curve2.cPoints[1].x + b;
    intensityV2 = sqrt(sq(curve2.getX(0) - curve2.getX(0+globalH)) + sq(curve2.getY(0) - curve2.getY(0+globalH)));
    distV1V2 = sqrt(sq(curve1.cPoints[curve1.cPoints.length-2].x-curve2.cPoints[1].x) + sq(curve1.cPoints[curve1.cPoints.length-2].y-curve2.cPoints[1].y));

    if (curve2.cPoints[1].x > 1000) {
      if (c1IActualError == c1IMaxError) {
        println("****Error to find c1****");
        curve2.cPoints[1].x = xOld;
        curve2.cPoints[1].y = yOld;
        break;
      } else {
        curve2.cPoints[1].x = 0;
        c1IActualError *= 2;
        if (c1IActualError > c1IMaxError) {
          c1IActualError = c1IMaxError;
        }
        println("Changing max error to "+c1IActualError);
      }
    }
  }
  
  println("Curve 2 final intensity:"+intensityV2);
  println("distV1V2:"+distV1V2);
  
  println("-----Finish c1-----");
}

void c2(CurveI curve1, CurveI curve2) {
  //c1(curve1, curve2);
  //TODO don't use x0-h and 0+h
  println("-----Start c2-----");
  float d2C1 = curve1.secondDerivative(float(curve1.n-curve1.k+2)-globalH*2, globalH);
  float d2C2 = curve2.secondDerivative(0+globalH*2, globalH);
  println("Curve 1 second derivative:"+d2C1);
  println("Curve 2 second derivative:"+d2C2);
    float intensityV1 = sqrt(sq(curve1.getX(curve1.n-curve1.k+2) - curve1.getX(curve1.n-curve1.k+2-globalH))//
  + sq(curve1.getY(curve1.n-curve1.k+2) - curve1.getY(curve1.n-curve1.k+2-globalH)));
  
  float intensityV2 = sqrt(sq(curve2.getX(0) - curve2.getX(0+globalH))//
  + sq(curve2.getY(0) - curve2.getY(0+globalH)));
  println("Curve 1 intensity:"+intensityV1);
  println("Curve 2 intensity:"+intensityV2);
  println("-----Finish c2-----");
}