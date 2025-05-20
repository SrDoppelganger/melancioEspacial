
//variaveis de classes 
Player p1;
ArrayList<Bullet> bulletList;

//variaveis de imagens
PImage playerSprites[];
//sprites dos inimigos aqui
int playerFrames; //e frames dos inimigos tbm ;)



void setup(){
  size(480,600);
  
  //carrega os sprites do jogador no inicio do jogo
  playerFrames = 4;
  playerSprites = new  PImage[playerFrames];
  for(int i = 0; i<playerFrames; i++){
    playerSprites[i] = loadImage("data/Player/sprite_"+i+".png");
  }
  
  p1 = new Player(220,480);
  bulletList = new ArrayList<Bullet>();
}


void draw(){
 gameLoop();
}

void gameLoop(){
  background(16,12,8);
  
  p1.render();
  p1.move();
  
  println(p1.x);
  
  //loop que armazena balas
  for(Bullet aBullet : bulletList){
    aBullet.render();
    aBullet.move();
    aBullet.checkScreen();
  }
  
  //loop que remove balas
  for(int i = bulletList.size()-1; i>=0; i--){
    Bullet aBullet = bulletList.get(i); 
    
    if(aBullet.foraDeTela == true){
      bulletList.remove(aBullet);
    }
  }

}

void keyPressed(){
  if(keyCode == LEFT){
    p1.movingLeft = true;
  }
  if(keyCode == RIGHT){
    p1.movingRight = true;
  }
  if(key == 'z'){
    bulletList.add(new Bullet(p1.x + 45,p1.y + 5));
    p1.shootingAnim();
  }
}

void keyReleased(){
  if(keyCode == LEFT){
    p1.movingLeft = false;
  }
  if(keyCode == RIGHT){
    p1.movingRight = false;
  }
  if(key == 'z'){
    //reseta animação de atirar
    p1.currFrame = 0;
  }
}
