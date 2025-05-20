class Bullet{

  //variaveis
  int x;
  int y;
  int size;
  
  int speed;
  //color[]
  
  boolean foraDeTela;
  
  //constructor
  Bullet(int startingX, int startingY){
    x = startingX;
    y = startingY;
    
    size = 8;
    speed = 15;
    foraDeTela = false;
  }
  
  void render(){
    //fill(color[0],color[1],color[2])
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
