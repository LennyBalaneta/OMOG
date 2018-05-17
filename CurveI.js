CurveI.onlyPoints = true;
function CurveI(cps) {
    this.cPoints = cps;
    this.parameters = function(cps) {
        //Uses the controllPoints to fit the curve
        print("Implement parameters function to this type of curve");//pseudo abstract method
        return null;
    }
 
    this.evaluate = function(x) {
        //Evaluate de curve equation passing a x value
        print("Implement evaluate function to this type of curve");//pseudo abstract method
        return null;
    }
    
    this.showCurve = function() {
      if(CurveI.onlyPoints) {
        strokeWeight(1);
        for(var i=0 ; i<width ; i++) {
            point(i, this.evaluate(i));
        }
      }else {
        var f0, f1;
        f0 = this.evaluate(0);
        for(var i=1 ; i<width ; i++) {
          f1 = this.evaluate(i);
          line(i-1, f0, i, f1);
          f0 = f1;
        }
      }
    }
    
    this.drawCPoints = function() {
      strokeWeight(2);
      fill(0);
      for(var i=0 ; i<this.cPoints.length ; i++) {
        this.cPoints[i].show();
      }
    }
    
    this.updateCPoints = function() {
      for(var i=0 ; i<this.cPoints.length ; i++) {
        this.cPoints[i].update();
      }
    }
}