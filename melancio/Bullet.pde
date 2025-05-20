class Bullet{

  //variaveis
  int x;
  int y;
  int size;
  
  int speed;
  int[] bulletColor;
  
  boolean foraDeTela;
  
  //constructor
  Bullet(int startingX, int startingY){
    x = startingX;
    y = startingY;
    
    size = 8;
    speed = 15;
    bulletColor = new int[]{255,255,0};
    foraDeTela = false;
  }
  
  void render(){
    fill(bulletColor[0],bulletColor[1],bulletColor[2]);
    circle(x,y,size);
  }
  
  void move(){
    y -= speed;
  }
  
  void checkScreen(){
    if (y < 0){
      foraDeTela = true;
    }
  }

}
