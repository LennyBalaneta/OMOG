BSpline.prototype = new CurveI();
function BSpline(cps) {
  this.cPoints = cps;
  this.k = 4;
  this.n = this.cPoints.length - 1;

  this.parameters = function() {
    return null;
  }

  this.evaluate = function(x) {
    return null;
  }

  this.showCurve = function() {
    strokeWeight(2);
    for (var u=0; u<=this.n-this.k+2; u+=0.005) {
      //stroke(cores[int(u)]);
      var x = this.getX(u);
      var y = this.getY(u);
      point(this.getX(u), this.getY(u));
    }
  }

  this.generateT = function() {
    var uniform = false;
    var ts = [];

    if (uniform) {
      var m = this.n-this.k+2;
      var tot = this.n+this.k+1;
      for (var i=0; i<=this.n+this.k+1; i++) {
        ts.push((m/tot)*i);
      }
    } else {
      for (var i=0; i<=this.n+this.k+1; i++) {
        if (i < this.k) {
          ts.push(0);
        } else if (i <= this.n) {
          ts.push(i - this.k + 1);
        } else {
          ts.push(this.n - this.k + 2);
        }
      }
    }
    print(ts);
    return ts;
  }
  this.t = this.generateT();

  this.getN = function(i, j, u) {
    if (j == 0) {//sei la 0 ou 1
      if (this.t[i] <= u && u <= this.t[i+1]) {
        return 1;
      } else {
        return 0;
      }
    }

    //k > 1
    var t1 = ((u-this.t[i])) * this.getN(i, j-1, u);
    var dt1 = (this.t[i+j]-this.t[i]);
    if (dt1 == 0) {
      dt1 = 1;
      t1 = 0;
    }
    var t2 = ((this.t[i+j+1] - u)) * this.getN(i+1, j-1, u);
    var dt2 = (this.t[i+j+1] - this.t[i+1]);
    if (dt2 == 0) {
      dt2 = 1;
      t2 = 0;
    }
    var niku = t1/dt1 + t2/dt2;
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
    //print("u: "+u);
    for (var i=0; i<this.cPoints.length; i++) {
      //print("i:"+i+" | cPoints[i]:"+cPoints[i].y+" | "+this.getN(i, this.k, u));
      valY += this.getN(i, this.k, u) * cPoints[i].y;
    }
    //print("valY: "+valY);
    return valY;
  }
}