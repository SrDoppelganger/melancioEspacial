class Player{

//variaveis
int x;
int y;

int playerWidth;
int playerHeight;

int speed;
int health;
int bombs;

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
  health = 3;
  bombs = 0;
  
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
   //fill(0,0,255);
   //rectMode(CENTER);
   //rect(x,y,playerWidth,playerHeight);
   
   imageMode(CENTER);
   image(playerSprites[currFrame],x,y);
   
   manageHealth();
 }

 void move(){
   
   checkCollision();
   
   if(movingLeft == true){
     x -= speed;
   }
   if(movingRight == true){
     x += speed;
   }
   
   //atualiza posição da hitbox
   left = x - playerWidth/2;
   right = x + playerWidth/2;
   top = y - playerHeight/2;
   bottom = y + playerHeight/2;
 }
 
  //toca a animação de atirar
 void shootingAnim(){
   currFrame++;
   if(currFrame == playerFrames){
     currFrame = 0;
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
 
 void manageHealth(){
   if(health<=0){
     isDead = true;
   }
 }
 
 void resetStats(){
   health = 3;
   isDead = false;
   
   x = width/2;
   y = 550;
   pontos = 0;
 }
 
 
 void updateStats(String dificuldade){
   //reseta timer de power ups para só começar na tela de jogo
   powerTimer = millis();
   println(powerTimer);
   
   if(dificuldade == "fácil"){
     health = 5;
     bombs = 3;
   }
   if(dificuldade == "médio"){
     health = 3;
     bombs = 0;
   }
   if(dificuldade == "difícil"){
     health = 2;
     bombs = 0;
   }
   if(dificuldade == " "){
     health = 1;
     bombs = 0;
   }
 }


}
