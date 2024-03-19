class DelaunayTriangulation {
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();
  ArrayList<Point> points = new ArrayList<Point>();
  ArrayList<Point> superVertices = new ArrayList<Point>();
  
  DelaunayTriangulation() {
    Point v1 = new Point( -2*width, -2*height);
    Point v2 = new Point(0.5*width, 4*height);
    Point v3 = new Point(  4*width, -2*height);
    this.points.add(v1);
    this.points.add(v2);
    this.points.add(v3);
    this.superVertices.add(v1);
    this.superVertices.add(v2);
    this.superVertices.add(v3);
    this.triangles.add(new Triangle(v1, v2, v3));
  }

  void add(Point v) {
    this.points.add(v);
    ArrayList<Triangle> nextTriangles = new ArrayList<Triangle>();
    ArrayList<Triangle> newTriangles = new ArrayList<Triangle>();
    for (Triangle tri : this.triangles) {
      if (tri.isInCircle(v)) {
        newTriangles.addAll(tri.divide(v));
      } else {
        nextTriangles.add(tri);
      }
    }

    for (Triangle tri : newTriangles) {
      boolean isIllegal = false;
      for (int vi = 0; vi < this.points.size(); vi++) {
        if (this.isIllegalTriangle(tri, this.points.get(vi))) {
          isIllegal = true;
          break;
        }
      }
      if (!isIllegal) {
        nextTriangles.add(tri);
      }
    }
    this.triangles = nextTriangles;
  }

  ArrayList<Triangle> getTriangles() {
    ArrayList<Triangle> ts = new ArrayList<Triangle>();
    boolean hasSuper;

    for (Triangle t : this.triangles) {
      hasSuper = false;
      for (int vi = 0; vi < 3; vi++) {
        if (t.isContain(this.superVertices.get(vi))) {
          hasSuper = true;
          break;
        }
      }
      if (!hasSuper)
        ts.add(t);
    }

    return ts;
  }

  boolean isIllegalTriangle(Triangle t, Point v) {
    if (t.isContain(v)) {
      return false;
    }
    return t.isInCircle(v);
  }
}
