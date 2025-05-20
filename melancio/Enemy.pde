class Enemy{
  //variaveis
  int x;
  int y;
  
  int enmWidth;
  int enmHeight;
  
  //constructor
  Enemy(int startingX,int startingY){
    x = startingX;
    y = startingY;
    
    enmWidth = 30;
    enmHeight = 30;
  }
  
  void render(){
    rectMode(CENTER);
    fill(255,0,0);
    rect(x,y,enmWidth,enmHeight);
  }
  
}
