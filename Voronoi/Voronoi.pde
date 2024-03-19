
ArrayList<Point> points = new ArrayList<Point>();
DelaunayTriangulation delaunayTriangulation;

int mode = 5;
int numPoints = 500;
boolean dots = true;
PrintWriter output;
void setup(){
  size(900,900);
  colorMode(HSB);
  //noLoop();
  for(int i = 0 ; i < numPoints ; i++) {
    Point p = new Point();
    points.add(p);
  }
}

void draw(){
  background(255);
  
  delaunayTriangulation = new DelaunayTriangulation();
  for(Point p : points) {
    delaunayTriangulation.add(p);
  }
  
  switch(mode){
    default: 
      for(Point p : points) p.display();  
      break;
    case 0: 
      generateBad(); 
      break;
    case 1: 
      for (Triangle t : delaunayTriangulation.getTriangles()) t.DrawEdges();
      break;
    case 2:   
      for (Triangle t : delaunayTriangulation.getTriangles()) {t.DrawEdges(); t.DrawCircle();}
      break;
    case 3:   
      for (Triangle t : delaunayTriangulation.getTriangles()) {t.DrawEdges(); t.DrawCenter(); t.DrawCircle();}
      break;
    case 4: 
      for (Triangle t : delaunayTriangulation.getTriangles()) {t.DrawCenter();}
      break;
    case 5: 
      voronoi();
      break;
    case 6: 
      voronoiColour();
      break;
    case 7: 
      for (Triangle t : delaunayTriangulation.getTriangles()) t.DrawEdges();
      voronoiColour();
      break;
    case 8: 
      generateBadWeighted();
      break;
  }
  
  if(dots) for(Point p : points){ p.display(); }
  for(Point p : points) p.movePoint();
}

void mousePressed(){
  if(mouseButton == RIGHT){
    Point p = new Point(mouseX,mouseY);
    points.add(p);
    delaunayTriangulation.add(p);
    redraw();
  }
}

void keyPressed(){
  if(str(key).matches("[0-9]")){
    mode = int(str(key));
    redraw();
  }
  if(key==' '){
    dots=!dots;
    redraw();
  }
}
