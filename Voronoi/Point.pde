class Point{
  float x        = ceil(random(10,width -10));
  float y        = ceil(random(10,height-10));
  float size     = 8;
  float weight = random(2,5);
  
  color stroke = 0;
  color fill   = color(ceil(random(255)),230,ceil(random(100,255)));
  //color fill   = color(ceil(random(255)),ceil(random(255)),ceil(random(255)));
  
  float xvel = random(-1,1);
  float yvel = random(-1,1);
  
  Point(){}
  Point(float x, float y){
    this.x=x;
    this.y=y;
  }
  
  float distance(Point other){
    return sqrt(sq(this.x-other.x)+sq(this.y-other.y)); 
  }  
  boolean IsEqual(Point other) {
    return this.x == other.x && this.y == other.y;
  }
  void movePoint(){
    x = x + xvel;
    y = y + yvel;
    if(x<0) {x = -x; xvel = -xvel;}
    if(y<0) {y = -y;yvel = -yvel;}
    if(x>width) {x = width-(width-x);xvel = -xvel;}
    if(y>height) {y = height-(height-y);yvel = -yvel;}
  }
  void display(){
    fill(fill);
    noStroke();
    circle(x,y,size);
  }
  void displayDot(){
    fill(0);
    stroke(0);
    strokeWeight(0);
    circle(x,y,5);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Triangle {
  Point[] points = new Point[3];
  Point center;
  float radius;

  public Triangle(Point p1, Point p2, Point p3) {
    this.points[0] = p1;this.points[1] = p2;this.points[2] = p3;
    float c = 2 * ((p2.x - p1.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x));
    float x = ((p3.y - p1.y) * (sq(p2.x) - sq(p1.x) + sq(p2.y) - sq(p1.y)) + (p1.y - p2.y) * (sq(p3.x) - sq(p1.x) + sq(p3.y) - sq(p1.y))) / c;
    float y = ((p1.x - p3.x) * (sq(p2.x) - sq(p1.x) + sq(p2.y) - sq(p1.y)) + (p2.x - p1.x) * (sq(p3.x) - sq(p1.x) + sq(p3.y) - sq(p1.y))) / c;
    this.center = new Point(x, y);
    this.radius = p1.distance(center);
  }

  ArrayList<Triangle> divide(Point v) {
    ArrayList<Triangle> tris = new ArrayList<Triangle>();
    for (var i = 0; i < 3; i++) {
      var j = i == 2? 0: i + 1;
      tris.add(new Triangle(this.points[i], this.points[j], v));
    }
    return tris;
  }
  
  boolean isInCircle(Point v){
    return this.center.distance(v) < this.radius;
  }
  
  boolean isContain(Point v) {
    for (var i = 0; i < 3; i++) {
      if (this.points[i].IsEqual(v)) {
        return true;
      }
    }
    return false;
  }
  
  boolean shareEdge(Triangle other) {
    int count = 0;
    for (Point p : other.points) {
      if (this.isContain(p)) {
        count++;
      }
    }
    return count>1;
  }

  public void DrawCenter() {
    center.displayDot();
  }  
  public void DrawEdges() {
    noFill();
    stroke(0);
    strokeWeight(2);
    triangle(this.points[0].x,this.points[0].y,
             this.points[1].x,this.points[1].y,
             this.points[2].x,this.points[2].y);
  }  

  public void DrawCircle() {
    noFill();
    stroke(192);
    strokeWeight(1);
    ellipse(center.x, center.y, radius * 2,radius * 2);
  }
}
