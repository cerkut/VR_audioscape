class Building{
  
  int posx, posy, posz;
  int type = 1;
  float building_height;
  float size;
  
  int res = 100;
  
  Extrusion e;
  Path path;
  Contour contour;
  ContourScale conScale;
  
  PShape s;
  
  public Building(int posx, int posy, int posz){
    this.posx = posx; this.posy = posy; this.posz = posz;
    
    if (random(0, 1)<.9) building_height = random(10, 20)*5;
    else building_height = random(20, 40)*5;
    size = 3*5;
    
    e = createBuildingStructure();
    
  }
  
  Extrusion createBuildingStructure(){
    
    path = new P_LinearPath(new PVector(0, building_height, 0), new PVector(0, 0, 0));
    contour = getBuildingContour();
    conScale = new CS_ConstantScale();
    
    // Create the texture coordinates for the end
    contour.make_u_Coordinates();
    
    // Create the extrusion
    e = new Extrusion(sketchPApplet, path, 1, contour, conScale);
    
    e.setTexture(createTexture(), 1, 1);
    e.drawMode(S3D.TEXTURE );
    // Extrusion end caps
    //e.setTexture("grass.jpg", S3D.E_CAP);
    //e.setTexture("sky.jpg", S3D.S_CAP);
    e.drawMode(S3D.TEXTURE, S3D.BOTH_CAP);
    return e;
  }
  
  public Contour getBuildingContour() {
      PVector[] c = new PVector[]{
        new PVector(-size, size),
        new PVector(size, size),
        new PVector(size, -size),
        new PVector(-size, -size)
      };
      return new Building_Contour(c);
  }
  
  PImage createTexture(){
    float resolution = 0.5;
    
    PImage img = createImage((int)(size*resolution*4), (int)(building_height*resolution), ARGB);

    img.loadPixels();

    for (int x=0; x<img.width; x++){
      for (int y=0; y<img.height; y++){
        int i = (int)(x+y*img.width);
        if (y%5==0) img.pixels[i] = color(200, 200+y, 200+y);
        else img.pixels[i] = color(50, 50+y, 50+ y);
      }
    }

    img.updatePixels();
    return img;
  }
  
  void update(){}
  
  void display(){
    pushMatrix();
    translate(posx, posy, posz);
    rotateX(PI);
    e.draw();
    popMatrix();
   
  }
}

public class Building_Contour extends Contour {
  public Building_Contour(PVector[] c) {
    this.contour = c;
  }
}