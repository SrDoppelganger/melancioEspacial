class PowerUp{

  //variaveis
  int x;
  int y;
  int d;
  
  String type;
  
  int speed;
  
  int currFrame;
  
  boolean taken;
  
  //colisões
  int left,right,top,bottom;
  
  //constructor  
  PowerUp(int startingX, int startingY, String chosenType){
    x = startingX;
    y = startingY;
    d = 40;
    type = chosenType;
    
    speed = 5;
    
    currFrame = 0;
    
    taken = false;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void render(){
    //circulo de hitbox
    //fill(82,24,250);
    //circle(x,y,d);
    if(type=="health"){
      image(powerUpSprites[0],x,y);
    }
    if(type=="bomb"){
      image(powerUpSprites[1],x,y);
    }
  }
  
  void move(){
    y += speed;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
    
    if(y>=650){
      taken = true;
    }
  }
  
  void checkPlayer(Player p1){
   //checa se o jogador pegou o upgrade
   if(top <= p1.bottom && bottom >= p1.top && left <= p1.right && right >= p1.left){
      givePowerUp(type);
      taken = true;
   }
 }
 
 void givePowerUp(String powerType){
   if(powerType == "health"){
      acceptSound.play();
      p1.health += 1;
   }
   if(powerType == "bomb"){
     acceptSound.play();
     p1.bombs += 1;
   }
 }
 
 void lunacy(boolean toggled_on){
   if(toggled_on == true){
        powerInterval = 60000;
   }
   else{
     powerInterval = 30000;
   }
 }

}
