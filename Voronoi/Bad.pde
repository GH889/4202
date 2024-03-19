void generateBad(){
  for(int x = 0 ; x < width ; x++){
    for(int y = 0 ; y < height ; y++){
      Point closest = null;
      float minDistance = sqrt(sq(width)+sq(height))+1;
      for(Point p : points){
        float dist = floor(dist(x,y,p.x,p.y));
        if(dist < minDistance){
          minDistance = dist;
          closest = p;
        }
      }
      stroke(closest==null? 0 : closest.fill);
      point(x,y);
    }
  }
}

void generateBadWeighted(){
  for(int x = 0 ; x < width ; x++){
    for(int y = 0 ; y < height ; y++){
      Point closest = null;
      float minDistance = max(width+1,height+1);
      for(Point p : points){
        float dist = floor(dist(x,y,p.x,p.y))/p.weight;
        if(dist < minDistance){
          minDistance = dist;
          closest = p;
        }
      }
      stroke(closest==null? 0 : closest.fill);
      point(x,y);
    }
  }
}

void voronoi(){
  ArrayList<Point[]> edges = new ArrayList<Point[]>();
  ArrayList<Triangle> ts = delaunayTriangulation.triangles;
  for(int i = 0 ; i < ts.size()-1 ; i++){
    for(int j = i+1 ; j < ts.size() ; j++){
      if(ts.get(i).shareEdge(ts.get(j))){
        Point[] edge = new Point[2];
        edge[0]=ts.get(i).center;
        edge[1]=ts.get(j).center;
        edges.add(edge);
      }
    }
  }
  for(Point[] edge : edges){
    if(delaunayTriangulation.superVertices.contains(edge[0]) && 
    delaunayTriangulation.superVertices.contains(edge[1])) continue;
    stroke(0);
    strokeWeight(2);
    line(edge[0].x,edge[0].y,edge[1].x,edge[1].y);
  }
}
  
void voronoiColour(){
  for(Point p : delaunayTriangulation.points){
    ArrayList<Point> poly = new ArrayList<Point>();
    for(Triangle t : delaunayTriangulation.triangles){
      if(t.isContain(p)) poly.add(t.center);
    }
    
    for(int i = 0 ; i < poly.size()-1 ; i++) {
      for(int j = 0 ; j < poly.size()-(i+1) ; j++) {
        Point p1 = poly.get(j  );
        Point p2 = poly.get(j+1);
        
        float p1a = atan((p1.y-p.y)/(p1.x-p.x));
        float p2a = atan((p2.y-p.y)/(p2.x-p.x));
        
        
        if(p1.x<p.x)p1a=p1a+PI;
        if(p2.x<p.x)p2a=p2a+PI;
        
        
        if(p1a<p2a){
          poly.set(j  ,p2);
          poly.set(j+1,p1);
        }
      }
    }
    
    stroke(0);
    strokeWeight(2);
    fill(p.fill,80);
    
    beginShape();
    for(Point pp : poly) vertex(pp.x,pp.y);
    if(poly.size()>0) vertex(poly.get(0).x,poly.get(0).y);
    endShape();
  }
}
