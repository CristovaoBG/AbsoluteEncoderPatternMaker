PImage img;
color frontColor;
color backColor;
int posicaoX;
int posicaoY;
int bigRadius = 300;
int smallRadius = 20;
int definition = 4;

void setup() {
  smooth(0);
  frameRate(4);
  size(700, 700);
  posicaoX = width/2;
  posicaoY = height/2;
  frontColor = color(0,0,0);
  backColor = color(255,255,255);
}

void drawPizzaSlice(int x, int y, float circleRadius, float angStart, float angFinish){
  float step = 1/(circleRadius*10);
  float th = angStart;
  while(th<angFinish){
    line(x,y,x+circleRadius*cos(th),y+circleRadius*sin(th));
    th+=step;    
  }
}

void drawLayer(int x,int y,float circleRadius, int divAmount){
  float iDiv = 0;
  float iDivStep= 2*PI/(divAmount*2);
  while (iDiv<2*PI){
    //desenha um
    stroke(frontColor);
    drawPizzaSlice(x,y,circleRadius,iDiv,iDiv+iDivStep);
    //pula outro
    stroke(backColor);
    drawPizzaSlice(x,y,circleRadius,iDiv+iDivStep,iDiv+2*iDivStep); 
    iDiv+= 2*iDivStep;
  } 
}

void draw() {
  rect(0,0,width,height,backColor);
  //desenha camada mais externa
  float radiusStep = (bigRadius-smallRadius)/definition;
  //comeca do raio mais externo
  int divAmnt = (int)pow(2,definition);
  float radius = bigRadius;
  while(divAmnt>=1){
    drawLayer(posicaoX,posicaoY,radius, divAmnt);
    divAmnt/=2;
    radius-=radiusStep;
  }
}

void keyPressed(){
  if (key == 'q' && definition>1) definition -=1;
  if (key == 'w') definition +=1;
  if (key == 'a') bigRadius -=10;
  if (key == 's') bigRadius +=10;
  if (key == 'z' && smallRadius > 0) smallRadius -=10;
  if (key == 'x' && smallRadius < bigRadius) smallRadius +=10;
}