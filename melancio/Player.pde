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
//loopFrames <--variavel para mudar animações

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
   imageMode(CENTER);
   image(playerSprites[currFrame],x,y);
 }

 void move(){
   
   checkCollision();
   
   if(movingLeft == true){
     x -= speed;
   }
   if(movingRight == true){
     x += speed;
   }
 }
 
 void checkCollision(){
   if(x >= 440){
     movingRight = false;
   }
   if(x <= 40){
     movingLeft = false;
   }
 }
 
 //toca a animação de atirar
 void shootingAnim(){
   currFrame++;
   if(currFrame == playerFrames){
     currFrame = 0;
   }
 }

}
