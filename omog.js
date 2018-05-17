var cPoints, qtdCP, c;
 
function setup() {
  createCanvas(800, 600);
  qtdCP = 2;//qtd of controll points
  cPoints = [];
  c = new Rect();
  for(var i=0 ; i<qtdCP ; i++) {
    cPoints.push(new ControllPoint(width*(i/(qtdCP+1))+width/(qtdCP+1), height/2));
  }
 
 
  ///
  //print("evaluate: " + new Rect().parameters(1))
}
 
function draw() {
  updateCPoints();
  drawCPoints();
  c.parameters(cPoints);
  showFunction();
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
 
function drawCPoints() {
  strokeWeight(15);
  fill(255);
  rect(0, 0, width, height);
  strokeWeight(2);
  fill(0);
  for(var i=0 ; i<qtdCP ; i++) {
    cPoints[i].show();
  }
}
 
function updateCPoints() {
  for(var i=0 ; i<qtdCP ; i++) {
    cPoints[i].update();
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
 
function CurveI() {
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
}
 
Rect.prototype = new CurveI();
//Uses 2 points
function Rect() {
    this.a = 0;
    this.b = 0;
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
 
function showFunction() {
    for(var i=0 ; i<width ; i++) {
        strokeWeight(1);
        point(i, c.evaluate(i));
    }
}
 
 
function mousePressed() {
  colisionVerification();
}
 
function mouseReleased() {
  releaseAll();
}