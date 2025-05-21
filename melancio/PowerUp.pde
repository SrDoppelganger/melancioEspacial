class PowerUp{

  //variaveis
  int x;
  int y;
  int d;
  //type <-- para definir qual upgrade?
  
  int speed;
  
  //colisões
  int left,right,top,bottom;
  
  //constructor  
  PowerUp(int startingX, int startingY){
    x = startingX;
    y = startingY;
    d = 32;
    //type = powerType
    
    speed = 5;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void render(){
    fill(255,193,204);
    circle(x,y,d);
  }
  
  void move(){
    y += speed;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }

}
