class Enemy{
  //variaveis
  int x;
  int y;
  
  int enmWidth;
  int enmHeight;
  
  //variaveis de colisão
  int left,right,top,bottom;
  
  //constructor
  Enemy(int startingX,int startingY){
    x = startingX;
    y = startingY;
    
    enmWidth = 30;
    enmHeight = 30;
    
    //lembrar de colocar isso na função move() dps ;3
    left = x - enmWidth/2;
    right = x + enmWidth/2;
    top = y - enmHeight/2;
    bottom = y + enmHeight/2;
  }
  
  void render(){
    rectMode(CENTER);
    fill(255,0,0);
    rect(x,y,enmWidth,enmHeight);
  }
  
}
