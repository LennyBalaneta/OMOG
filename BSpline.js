BSpline.prototype = new CurveI();
function BSpline(cps) {
  this.cPoints = cps;
  this.k = 4;
  this.n = 6;
  this.parameters = function() {
    return null;
  }

  this.evaluate = function(x) {
    return null;
  }
  
  this.showCurve = function() {
    strokeWeight(2);
    for(var u=0 ; u<=this.n-this.k+2 ; u+=0.005) {
      //stroke(cores[int(u)]);
      var x = this.getX(u);
      var y = this.getY(u);
      //var cor = cores[this.getT(u)];
      //stroke(cor[0], cor[1], cor[2]);
      //print("u->" + u+ " | t(u)->"+this.getT(u));
      point(this.getX(u), this.getY(u));
      //if(isNaN(x) || isNaN(y)) {
      //}else {
      //  point(this.getX(u), this.getY(u));
      //}
    }
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
  
  this.getN = function(i, j, u) {
    if(j == 0) {//sei la 0 ou 1
      if(this.getT(i) <= u && u < this.getT(i+1)) {
        return 1;
      }else {
        return 0;
      }
    }
    
    //k > 1
    //print("wtf:"+this.l);
    //var nikuOld = ((u-this.getT(i))*(this.getN(i, k-1, u)))/(this.getT(i+this.l-1) - this.getT(i)) + ((this.getT(i+this.k)-u)*this.getN(i+1, k-1, u))/(this.getT(i+this.k)-this.getT(i+1));
    //var niku = ((u-this.getT(i))*(this.getN(i, k-1, u)))/(this.getT(i+k-1) - this.getT(i)) + ((this.getT(i+k)-u)*this.getN(i+1, k-1, u))/(this.getT(i+k)-this.getT(i+1));
    //print("niku: "+niku);
    var t1 = ((u-this.getT(i))) * this.getN(i, j-1, u);
    var dt1 = (this.getT(i+j)-this.getT(i));
    if(dt1 == 0) {
      dt1 = 1;
      t1 = 0;
    }
    var t2 = ((this.getT(i+j+1) - u)) * this.getN(i+1, j-1, u);
    var dt2 = (this.getT(i+j+1) - this.getT(i+1));
    if(dt2 == 0) {
      dt2 = 1;
      t2 = 0;
    }
    var niku = t1/dt1 + t2/dt2;
    
    
    //v3
    //var t1 = (u - this.getT(i)) * this.getN(i, j-1, u);
    //var dt1 = (this.getT(i+j) - this.getT(i));
    //var t2 = (this.getT(i+j+1) - u) * this.getN(i+1, j-1, u);
    //var dt2 = (this.getT(i+j+1) - this.getT(i+1));
    //if(dt1 == 0) {
    //  dt1 = 1;
    //  t1 = 0;
    //}
    //if(dt2 == 0) {
    //  dt2 = 1;
    //  t2 = 0;
    //}
    
    //v2
    //var t1 = (u-this.getT(i))*this.getN(i, j-1, u);
    //var dt1 = this.getT(i+j-1) - this.getT(i);
    //var t2 = (this.getT(i+j) - u)*this.getN(i+1, j-1, u);
    //var dt2 = this.getT(i+j) - this.getT(i+1);
    var niku = t1/dt1 + t2/dt2;
    if(isNaN(niku)) {
      //print("t1="+t1+" | dt1="+dt1+" | t2="+t2+" | dt2="+dt2);
      //print("i:"+i+" | k:"+j+" | u:"+i);
      //return 0;
    }
    return niku;
  }
  
  this.getX = function(u) {
    var valX = 0;
    for (var i=0; i<this.cPoints.length; i++) {
      valX += this.getN(i, this.k, u) * cPoints[i].x;
    }
    return valX;
  }
  
  this.getY = function(u) {
    var valY = 0;
    for (var i=0; i<this.cPoints.length; i++) {
      valY += this.getN(i, this.k, u) * cPoints[i].y;
    }
    return valY;
  }
  
}