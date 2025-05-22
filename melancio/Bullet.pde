class Bullet{

  //variaveis
  int x;
  int y;
  int size;
  
  int speed;
  int[] bulletColor;
  
  boolean foraDeTela;
  
  //variaveis de colisão 
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
    noStroke();
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
  
  void hitEnemy(Enemy anEnemy){
    //checa se a bala está dentro do inimigo, e se estiver remove ele da tela (talvez add mecanica de HP )
    if(top <= anEnemy.bottom && bottom >= anEnemy.top && left <= anEnemy.right && right >= anEnemy.left){
      anEnemy.isDead = true;
      foraDeTela = true;
    }
  }

}
