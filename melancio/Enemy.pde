class Enemy{
  //variaveis
  int x;
  int y;
  
  int enmWidth;
  int enmHeight;
  
  //variaveis de sprites
  int currFrame;
  
  int timer,interval;
  
  //variaveis de colisão
  int left,right,top,bottom;
  
  boolean isDead;
  
  //constructor
  Enemy(int startingX,int startingY){
    x = startingX;
    y = startingY;
    
    enmWidth = 70;
    enmHeight = 70;
    
    currFrame = 0;
    
    //lembrar de colocar isso na função move() dps ;3
    left = x - enmWidth/2;
    right = x + enmWidth/2;
    top = y - enmHeight/2;
    bottom = y + enmHeight/2;
    
    isDead = false;
    
    
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
  
}
