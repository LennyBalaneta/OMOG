var cPoints, qtdCP, c;
 
function setup() {
  createCanvas(800, 600);
  qtdCP = 2;//qtd of controll points
  cPoints = [];
  for(var i=0 ; i<qtdCP ; i++) {
    cPoints.push(new ControllPoint(width*(i/(qtdCP+1))+width/(qtdCP+1), height/2));
  }
  c = new Rect(cPoints);
}
 
function draw() {
  strokeWeight(15);
  fill(255);
  rect(0, 0, width, height);
  updateCPoints(c);
  c.drawCPoints();
  c.parameters(cPoints);
  c.showCurve();
}
 
 
ControllPoint.radius = 8;//the radius of each controll point
function ControllPoint(pX, pY) {
  this.x = pX;
  this.y = pY;
  this.selected = false;
 
  this.show = function() {
    ellipse(this.x, this.y, ControllPoint.radius*2, ControllPoint.radius*2);
  }
 
  this.update = function() {
    if(this.selected == true) {
      this.x = mouseX;
      this.y = mouseY;
    }
  }
}

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
}
 
Rect.prototype = new CurveI();
//Uses 2 points
function Rect(cps) {
    this.a = 0;
    this.b = 0;
    this.cPoints = cps;
    this.parameters = function(cps) {
        //TODO fazer maps
        var x1, x2, y1, y2;
        x1 = cps[0].x;
        x2 = cps[1].x;
        y1 = cps[0].y;
        y2 = cps[1].y;
 
        this.a = (y2-y1)/(x2-x1);
        this.b = y1 - (this.a*x1);
        //print("a: " + a + " | b: " + b);
    }
 
    this.evaluate = function(x) {
        return this.a * x + this.b;
    }
}
 
function Parable() {
    this.a = 0;
    this.b = 0;
    this.c = 0
    this.parameters = function(cps) {
        //TODO fazer maps
        var x1, x2, y1, y2;
        x1 = cps[0].x;
        x2 = cps[1].x;
        y1 = cps[0].y;
        y2 = cps[1].y;
 
        this.a = (y2-y1)/(x2-x1);
        this.b = y1 - (this.a*x1);
        //print("a: " + a + " | b: " + b);
    }
 
    this.evaluate = function(x) {
        return this.a * sq(x) + this.b * x + c;
    }
}

function updateCPoints(c) {
  for(var i=0 ; i<c.cPoints.length ; i++) {
    c.cPoints[i].update();
  }
}
 
function colisionVerification() {
  for(var i=0 ; i<qtdCP ; i++) {
      if(sqrt(sq(mouseX-cPoints[i].x) + sq(mouseY-cPoints[i].y)) < ControllPoint.radius) {
          cPoints[i].selected = true;
      }
  }
}
 
function releaseAll() {
  for(var i=0 ; i<qtdCP ; i++) {
    cPoints[i].selected = false;
  }
}
 
function mousePressed() {
  colisionVerification(c);
}
 
function mouseReleased() {
  releaseAll(c);
}