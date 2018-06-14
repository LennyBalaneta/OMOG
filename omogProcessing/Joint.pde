float c1MaxError = 0.02;
float c2MaxError = 0.1;
float h = 0.01;

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
  
  float dC1 = curve1.derivativePre(float(curve1.n-curve1.k+2), h);
  float dC2 = curve2.derivativePos(0, h);
  println("Curve 1 first derivative:"+dC1);
  println("Curve 2 initial first derivative:"+dC2);
  
  //TODO improve the brute force method(p0 foreward)
  float yOld = curve2.cPoints[1].y;
  if(abs(dC1 - dC2) > c1MaxError) {
    curve2.cPoints[1].y = 0;
  }
  while(abs(dC1 - dC2) > c1MaxError) {
    curve2.cPoints[1].y += 1;
    dC2 = curve2.derivativePos(0, h);
    if(curve2.cPoints[1].y > 1000) {
      println("****Error to find c1****");
      curve2.cPoints[1].y = yOld;
      break;
    }
  }
  println("Curve 2 final first derivative:"+dC2);
  println("-----Finish c1-----");
}

void c2(CurveI curve1, CurveI curve2) {
  c1(curve1, curve2);
  //TODO don't use x0-h and 0+h
  println("-----Start c2-----");
  float d2C1 = curve1.secondDerivative(float(curve1.n-curve1.k+2)-h, h);
  float d2C2 = curve2.secondDerivative(0+h, h);
  println("Curve 1 second derivative:"+d2C1);
  println("Curve 2 second derivative:"+d2C2);
  
  //Find the equation of the line
  float a = curve2.derivativePos(0, 0.2);
  float x = curve2.getX(0);
  float y = curve2.getY(0);
  float b = y - a*x;
  //println("a:"+a+" | b:"+b);
  
  float xOld = curve2.cPoints[1].x;
  float yOld = curve2.cPoints[1].y;
  if(abs(d2C1 - d2C2) > c2MaxError) {
    curve2.cPoints[1].x = 0;
  }
  
  //curve2.cPoints[1].x = 0;
  //line(0, 0*a + b, width, width*a + b);
  while(abs(d2C1 - d2C2) > c2MaxError) {
    //println("c2 error:"+abs(d2C1 - d2C2));
    //println("d2C1:"+d2C1+" | d2C2:"+d2C2);
    curve2.cPoints[1].x += 1;
    curve2.cPoints[1].y = a*curve2.cPoints[1].x + b;
    //ellipse(curve2.cPoints[1].x, curve2.cPoints[1].y, 10, 10);
    d2C2 = curve2.secondDerivative(0+h, h);
    if(curve2.cPoints[1].x > 1000) {
      println("****Error to find c2****");
      curve2.cPoints[1].x = xOld;
      curve2.cPoints[1].y = yOld;
      break;
    }
  }
  println("Curve 2 final first derivative:"+d2C2);
  println("-----Finish c2-----");
}