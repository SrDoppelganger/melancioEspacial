class Bullet{

  //variaveis
  int x;
  int y;
  int size;
  
  int speed;
  //color[]
  
  
  //constructor
  Bullet(int startingX, int startingY){
    x = startingX;
    y = startingY;
    
    size = 8;
    speed = 15;
  }
  
  void render(){
    //fill(color[0],color[1],color[2])
    circle(x,y,size);
  }
  
  void move(){
    y -= speed;
  }

}
