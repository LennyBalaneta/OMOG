static class Joint {
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
  }

  static void c2(CurveI curve1, CurveI curve2) {
    Joint.c1(curve1, curve2);
    println("c2");
  }
  
  static float derivatePre(CurveI curve, float u, float h) {
    //Numerical derivation using 3 points before x0
    //x0 -> u
    float dx = 1/(2*h) * (curve.getX(u - 2*h) - 4*curve.getX(u-h) + 3*curve.getX(u));
    float dy = 1/(2*h) * (curve.getY(u - 2*h) - 4*curve.getY(u-h) + 3*curve.getY(u));
    return dy/dx;
  }
}