
//variaveis de classes 
Player p1;
ArrayList<Enemy> enemyList;
ArrayList<Bullet> bulletList;
ArrayList<Player> playerList;

//variaveis de imagens
PImage playerSprites[];
PImage enemySprites[];
int playerFrames; 
int enemyFrames;

//variaveis de cenas
String cena;

//variaveis de customização
PFont font;
PFont fontBold;
int pontos;

void setup(){
  size(480,600);
  
  font = createFont("PixelOperator.ttf",64);
  fontBold = createFont("PixelOperator-Bold.ttf",64);
  
  loadSprites();
  
  
  p1 = new Player(width/2,550);
  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();
  
  //DEBUG
  playerList = new ArrayList<Player>();
  playerList.add(p1);
  
  
  cena = "titulo";
}


void draw(){
  if(cena == "titulo"){
    titleScreen();
  }
  if(cena == "jogo"){
    gameLoop();
  }
  if(cena == "gameOver"){
    gameOverScreen();
  }
}

void loadSprites(){
  //carrega os sprites do jogador no inicio do jogo
  playerFrames = 4;
  playerSprites = new PImage[playerFrames];
  for(int i = 0; i<playerFrames; i++){
    playerSprites[i] = loadImage("data/Player/sprite_"+i+".png");
  }
  
  enemyFrames = 5;
  enemySprites = new PImage[enemyFrames];
  for(int i = 0; i<enemyFrames; i++){
    enemySprites[i] = loadImage("data/Enemies/nectafiro-Sheet/sprite_"+i+".png");
    enemySprites[i].resize(48,48);
  }
}

void gameLoop(){
  background(0,0,14);
  textFont(font);
  
  textSize(24);
  textAlign(LEFT);
  fill(255);
  text("pontuação: "+nf(pontos,4),5,20);
  
  p1.render();
  p1.move();
  
  bulletLogic();
  enemyLogic();
  
  if(p1.isDead == true){
    cena = "gameOver";
  }
}

void titleScreen(){
  background(0,0,14);
  
  textFont(fontBold);
  textSize(48);
  textAlign(CENTER);
  text("Melâncio no Espaço",width/2,100);
  
  textFont(font);
  textSize(32);
  text("pressione espaço para jogar",width/2,550);
  
  //achar um jeito melhor de fazer isso
  p1.isDead = false;
}

void gameOverScreen(){
  background(0,0,14);
  
  textFont(fontBold);
  textSize(64);
  textAlign(CENTER);
  fill(237,41,57);
  text("GAME OVER",width/2,100);
  
  textFont(font);
  textSize(32);
  fill(255,255,49);
  text("Sua pontuação: "+ nf(pontos,4), width/2,height/2);
  
  
  
  fill(255);
  text("pressione espaço para continuar",width/2,550);
}

void bulletLogic(){
  //loop que armazena balas
  for(Bullet aBullet : bulletList){
    aBullet.render();
    aBullet.move();
    aBullet.checkScreen();
    
    //checa para ver se a bala acertou algum dos inimigos na tela
    for(Enemy anEnemy : enemyList){
      aBullet.hitEnemy(anEnemy);
    }
  }
  
  //loop que remove balas
  for(int i = bulletList.size()-1; i>=0; i--){
    Bullet aBullet = bulletList.get(i); 
    
    if(aBullet.foraDeTela == true){
      bulletList.remove(aBullet);
    }
  }
}

void enemyLogic(){ 
  for(Enemy anEnemy : enemyList){
    anEnemy.render();
    anEnemy.move();
    
    //checa para ver se o inimigo colidiu com o jogador
    for(Player aPlayer : playerList){
      anEnemy.hitPlayer(aPlayer);
    }
  }
  
  //loop que remove inimigos
  for(int i = enemyList.size()-1; i>=0; i--){
    Enemy anEnemy = enemyList.get(i);
    
    if(anEnemy.isDead == true){
      enemyList.remove(anEnemy);
      pontos++;
    }
  }
    
  //DEBUG, implementar um sistema de spawn melhor dps
  int randX = round(random(40,440));
  if(enemyList.size() < 1){
    Enemy anEnemy = new Enemy(randX,0);
    enemyList.add(anEnemy);
    
 
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
    bulletList.add(new Bullet(p1.x,p1.y - 40));
    p1.shootingAnim();
  }
  if(key == ' ' && cena == "titulo"){
    cena = "jogo";
  }
  //DEBUG
  if(key == 'k' && cena == "jogo"){
    cena = "gameOver";
  }
  if(key == ' ' && cena == "gameOver"){
    cena = "titulo";
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
