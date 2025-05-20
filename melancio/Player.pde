class Player{

//variaveis
int x;
int y;

int playerWidth;
int playerHeight;

int speed;

boolean movingLeft;
boolean movingRight;

//constructor (ngc que inicializa variaveis)
Player(int startingX, int startingY){
  x = startingX;
  y = startingY;
  
  playerWidth = 40;
  playerHeight = 40;
  
  speed = 10;
  
  movingLeft = false;
  movingRight = false;
}

 //renderiza o jogador na tela
 void render(){
   rect(x,y,playerWidth,playerHeight);
 }

 void move(){
   if(movingLeft == true){
     x -= speed;
   }
   if(movingRight == true){
     x += speed;
   }
 }


}
