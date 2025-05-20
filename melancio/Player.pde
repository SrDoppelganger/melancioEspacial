class Player{

//variaveis
int x;
int y;

int playerWidth;
int playerHeight;

int speed;

boolean movingLeft;
boolean movingRight;

//variaveis de Sprites
int currFrame;


//constructor (ngc que inicializa variaveis)
Player(int startingX, int startingY){
  x = startingX;
  y = startingY;
  
  playerWidth = 40;
  playerHeight = 40;
  
  speed = 10;
  
  movingLeft = false;
  movingRight = false;
  
  currFrame = 0;
}

 //renderiza o jogador na tela
 void render(){
   rect(x,y,playerWidth,playerHeight);
   image(playerSprites[currFrame],x,y);
 }

 void move(){
   if(movingLeft == true){
     x -= speed;
   }
   if(movingRight == true){
     x += speed;
   }
   
   currFrame++;
   if(currFrame == playerFrames){
     currFrame = 0;
   }
 }


}
