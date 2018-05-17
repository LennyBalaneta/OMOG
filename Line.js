Line.prototype = new CurveI();
//Uses 2 points
function Line(cps) {
    this.a = 0;
    this.b = 0;
    this.cPoints = cps;
    this.parameters = function() {
        //TODO fazer maps
        var x1, x2, y1, y2;
        x1 = this.cPoints[0].x;
        x2 = this.cPoints[1].x;
        y1 = this.cPoints[0].y;Line
        y2 = this.cPoints[1].y;
 
        this.a = (y2-y1)/(x2-x1);
        this.b = y1 - (this.a*x1);
    }
 
    this.evaluate = function(x) {
        return this.a * x + this.b;
    }
}