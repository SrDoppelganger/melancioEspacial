class PowerUp{

  //variaveis
  int x;
  int y;
  int d;
  //type <-- para definir qual upgrade?
  
  int speed;
  
  boolean taken;
  
  //colisões
  int left,right,top,bottom;
  
  //constructor  
  PowerUp(int startingX, int startingY){
    x = startingX;
    y = startingY;
    d = 32;
    //type = powerType
    
    speed = 5;
    taken = false;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void render(){
    fill(82,24,250);
    circle(x,y,d);
  }
  
  void move(){
    y += speed;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void givePower(Player p1){
   //checa se o jogador pegou o upgrade
   if(top <= p1.bottom && bottom >= p1.top && left <= p1.right && right >= p1.left){
      p1.health += 1;
      taken = true;
   }
 }

}
