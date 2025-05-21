class Player{

//variaveis
int x;
int y;

int playerWidth;
int playerHeight;

int speed;

boolean movingLeft;
boolean movingRight;
boolean isDead;

//variaveis de Sprites
int currFrame;
//loopFrames <--variavel para mudar animações

//variaveis de colisões
int left,right,top,bottom;

//constructor (ngc que inicializa variaveis)
Player(int startingX, int startingY){
  x = startingX;
  y = startingY;
  
  playerWidth = 96;
  playerHeight = 72;
  
  speed = 10;
  
  movingLeft = false;
  movingRight = false;
  isDead = false;
  
  currFrame = 0;
  
   left = x - playerWidth/2;
   right = x + playerWidth/2;
   top = y - playerHeight/2;
   bottom = y + playerHeight/2;
}

 //renderiza o jogador na tela
 void render(){
   //retangulo de hitbox
   fill(0,0,255);
   rectMode(CENTER);
   rect(x,y,playerWidth,playerHeight);
   
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
   
   left = x - playerWidth/2;
   right = x + playerWidth/2;
   top = y - playerHeight/2;
   bottom = y + playerHeight/2;
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
