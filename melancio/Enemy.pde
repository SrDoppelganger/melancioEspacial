class Enemy{
  //variaveis
  int x;
  int y;
  
  int enmWidth;
  int enmHeight;
  
  int speed;
  
  //variaveis de sprites
  int currFrame;
  
  int timer,interval;
  
  //variaveis de colisão
  int left,right,top,bottom;
  
  boolean isDead;
  boolean remove;
  
  //constructor
  Enemy(int startingX,int startingY){
    x = startingX;
    y = startingY;
    
    enmWidth = 48;
    enmHeight = 48;
    
    speed = 4;
    
    currFrame = 0;
    
    //lembrar de colocar isso na função move() dps ;3
    left = x - enmWidth/2;
    right = x + enmWidth/2;
    top = y - enmHeight/2;
    bottom = y + enmHeight/2;
    
    isDead = false;
    remove = false;
    
    timer = millis();
    interval = 120;
  }
  
  void render(){
    //quadrado de hitbox
    //fill(255,0,0);
    //rectMode(CENTER);
    //rect(x,y,enmWidth,enmHeight);
    imageMode(CENTER);
    image(enemySprites[currFrame],x,y);
    
    
    //toca a animação do inimigo em loop num frameRate menor doq o do jogo em si
    if(millis() > timer+interval){
      currFrame++;
      if(currFrame == enemyFrames){
        currFrame = 0;
      }
      timer = millis();
    }
    
  }//render
  
 void move(){
   y += speed;
   
   left = x - enmWidth/2;
   right = x + enmWidth/2;
   top = y - enmHeight/2;
   bottom = y + enmHeight/2;
   
   checkScreen();
 }
 
 void checkScreen(){
   if(y>=650){
     remove = true;
   }
 }
 
 void hitPlayer(Player p1){
    //checa se o inimigo atingiu o jogador, e se sim, remove o inimigo da tela
    if(top <= p1.bottom && bottom >= p1.top && left <= p1.right && right >= p1.left){
      //substituir por -= damage dps
      p1.health -= 1;
      remove = true;
    }
 }
 
 void lunacy(boolean toggled_on){
   if(toggled_on == true){
     speed = 8;
     spawnInterval = 300;
   }
   else{
     spawnInterval = 500;
   }
 }
  
}
