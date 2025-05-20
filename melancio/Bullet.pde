class Bullet{

  //variaveis
  int x;
  int y;
  int size;
  
  int speed;
  int[] bulletColor;
  
  boolean foraDeTela;
  
  //variaveis de colisão (limites do tamanho da bala)
  int left,right,top,bottom;
  
  //constructor
  Bullet(int startingX, int startingY){
    x = startingX;
    y = startingY;
    
    size = 8;
    speed = 15;
    bulletColor = new int[]{255,255,0};
    foraDeTela = false;
    
    left = x - size/2;
    right = x + size/2;
    top = y - size/2;
    bottom = y + size/2;
  }
  
  void render(){
    fill(bulletColor[0],bulletColor[1],bulletColor[2]);
    circle(x,y,size);
  }
  
  void move(){
    y -= speed;
    
    left = x - size/2;
    right = x + size/2;
    top = y - size/2;
    bottom = y + size/2;
  }
  
  void checkScreen(){
    if (y < 0){
      foraDeTela = true;
    }
  }

}
