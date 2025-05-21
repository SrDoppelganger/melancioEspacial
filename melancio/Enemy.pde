class Enemy{
  //variaveis
  int x;
  int y;
  
  int enmWidth;
  int enmHeight;
  
  //variaveis de sprites
  int currFrame;
  
  //variaveis de colisão
  int left,right,top,bottom;
  
  boolean isDead;
  
  //constructor
  Enemy(int startingX,int startingY){
    x = startingX;
    y = startingY;
    
    enmWidth = 30;
    enmHeight = 30;
    
    currFrame = 0;
    
    //lembrar de colocar isso na função move() dps ;3
    left = x - enmWidth/2;
    right = x + enmWidth/2;
    top = y - enmHeight/2;
    bottom = y + enmHeight/2;
    
    isDead = false;
  }
  
  void render(){
    fill(255,0,0);
    rect(x,y,enmWidth,enmHeight);
    imageMode(CENTER);
    image(enemySprites[currFrame],x,y);
  }
  
}
