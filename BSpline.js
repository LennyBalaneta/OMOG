BSpline.prototype = new CurveI();
function BSpline(cps) {
  this.cPoints = cps;
  this.k = 4;
  this.n = 8;
  this.parameters = function() {
    return null;
  }

  this.evaluate = function(x) {
    return null;
  }
  
  this.getT = function(i) {
    //return the t[i] value for non-uniform B-Spline. Uniform B-spline uses knot vector
    if(i < this.k) {
      return 0;
    }else if(i <= this.n) {
      return i - this.k + 1;
    }else {
      return this.n - this.k + 2;
    }
  }
  
  this.getN = function(i, k, u) {
    if(k == 1) {
      if(this.getT(i) <= u && u < this.getT(i+1)) {
        return 1;
      }else {
        return 0;
      }
    }
    
    //k > 1
    var niku = ((u-this.getT(i))*(this.getN(i, k-1, u)))/(this.getT(i+this.l-1) - this.getT(i)) + ((this.getT(i+this.k)-u)*this.getN(i+1, k-1, u))/(this.getT(i+this.k)-this.getT(i+1));
    return niku;
  }
  
  this.getX = function(u) {
    var valX = 0;
    for (var i=0; i<this.cPoints.length; i++) {
      valX += this.getN(i, 3, u) * cPoints[i].x;
    }
    return valX;
  }
  
  this.getY = function(u) {
    var valY = 0;
    for (var i=0; i<this.cPoints.length; i++) {
      valY += this.getN(i, 3, u) * cPoints[i].y;
    }
    return valY;
  }
  
}