static class Joint {
  private static float c1MaxError = 0.02;
  
  static void c0(CurveI curve1, CurveI curve2) {
    float difX = curve1.cPoints[curve1.cPoints.length-1].x - curve2.cPoints[0].x;
    float difY = curve1.cPoints[curve1.cPoints.length-1].y - curve2.cPoints[0].y;
    for (int i=0; i<curve2.cPoints.length; i++ ) {
      curve2.cPoints[i].x += difX;
      curve2.cPoints[i].y += difY;
    }
    println("c0");
  }

  static void c1(CurveI curve1, CurveI curve2) {
    Joint.c0(curve1, curve2);
    println("c1");
    
    float dC1 = curve1.derivativePre(float(curve1.n-curve1.k+2), 0.2);
    float dC2 = curve2.derivativePos(0, 0.2);
    println("Curve 1 derivative:"+dC1);
    println("Curve 2 initial derivative:"+dC2);
    
    //TODO improve the brute force method
    float yOld = curve2.cPoints[1].y;
    if(abs(dC1 - dC2) > c1MaxError) {
      curve2.cPoints[1].y = 0;
    }
    while(abs(dC1 - dC2) > c1MaxError) {
      curve2.cPoints[1].y += 1;
      dC2 = curve2.derivativePos(0, 0.2);
      if(curve2.cPoints[1].y > 1000) {
        println("Error to find c1");
        curve2.cPoints[1].y = yOld;
        break;
      }
    }
    println("Curve 2 final derivative:"+curve2.derivativePos(0, 0.2));
  }

  static void c2(CurveI curve1, CurveI curve2) {
    Joint.c1(curve1, curve2);
    println("c2");
  }
}