
//variaveis de classes 
Player p1;
ArrayList<Enemy> enemyList;
ArrayList<Bullet> bulletList;
ArrayList<PowerUp> powerUpList;
String[] powerUpTypes;

//variaveis de imagens
PImage playerSprites[];
PImage enemySprites[];
PImage powerUpSprites[];
int playerFrames; 
int enemyFrames;
int powerUpFrames;

//variaveis de gameplay
String cena;

//timer para spawnar inimigos
int spawnTimer,spawnInterval;
//timer para spawnar power-ups
int powerTimer,powerInterval;
int highscore;
boolean newHighscore;
//array para guardar tipos de power-ups?

//variaveis de customização
PFont font;
PFont fontBold;
int pontos;

void setup(){
  size(480,600);
  
  font = createFont("PixelOperator.ttf",64);
  fontBold = createFont("PixelOperator-Bold.ttf",64);
  
  loadSprites();
  
  //inicializa timers
  spawnTimer = millis();
  spawnInterval = 500;
  
  powerTimer = millis();
  powerInterval = 30000;
  
  p1 = new Player(width/2,550);
  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();
  powerUpList = new ArrayList<PowerUp>();
  powerUpTypes = new String[]{"health","bomb"};
  
  //inicializa highscore
  highscore = 0;

  
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
  
  powerUpFrames = 2;
  powerUpSprites = new PImage[powerUpFrames];
  for(int i = 0; i<powerUpFrames; i++){
    powerUpSprites[i] = loadImage("data/Power-Ups/sprite_"+i+".png");
  }
}

void gameLoop(){
  background(0,0,14);
  textFont(font);
  
  textSize(24);
  textAlign(LEFT);
  fill(255);
  text("pontuação: "+nf(pontos,4),5,20);
  
  textSize(24);
  textAlign(RIGHT);
  fill(255);
  text("vida:"+nf(p1.health,2),470,20);
  
  p1.render();
  p1.move();
  
  bulletLogic();
  enemyLogic();
  powerUpLogic();
  
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
  p1.resetStats();
  newHighscore = false;
}

void gameOverScreen(){
  background(0,0,14);
  getHighscore(pontos);
  
  
  textFont(fontBold);
  textSize(64);
  textAlign(CENTER);
  fill(237,41,57);
  text("GAME OVER",width/2,100);
  
  textFont(font);
  textSize(32);
  fill(255,255,49);
  text("Highscore: "+ nf(highscore,4), width/2,270);
  
  fill(255);
  text("Sua pontuação: "+ nf(pontos,4), width/2,height/2);
  
  if(newHighscore == true){
    textSize(32);
    fill(255,67,164);
    text("Novo recorde!!!", width/2,400);
  }
  
  
  
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
    anEnemy.hitPlayer(p1);
  }
  
  //loop que remove inimigos
  for(int i = enemyList.size()-1; i>=0; i--){
    Enemy anEnemy = enemyList.get(i);
    
    //adiciona pontos caso o jogador acerte o inimigo e não adiciona caso o inimigo só saia da tela
    if(anEnemy.isDead == true){
      enemyList.remove(anEnemy);
      pontos++;
    }
    if(anEnemy.remove == true){
      enemyList.remove(anEnemy);
    }
  }
    
  //logica de spawn de inimigos
  int randX = round(random(40,440));
  if(enemyList.size() < 5 && millis() > spawnTimer + spawnInterval){
    Enemy anEnemy = new Enemy(randX,0);
    enemyList.add(anEnemy);
    spawnTimer = millis();
  }
  
  //remove todos os inimigos quando acaba o jogo
  if(p1.isDead == true){
   for(int i = enemyList.size()-1; i >= 0; i--){
     Enemy anEnemy = enemyList.get(i);
     enemyList.remove(anEnemy);
   }
  }
}

void powerUpLogic(){
  //loop que armazerna upgrades na tela
  for(PowerUp power : powerUpList){
    power.render();
    power.move();
    
    power.checkPlayer(p1);
  }
  
  for(int i = powerUpList.size()-1; i >= 0; i--){
    PowerUp power = powerUpList.get(i);
    
    if(power.taken == true){
      powerUpList.remove(power);
    }
  }
  
  //randomiza o tipo de power up
  int randType = round(random(0,1));
  String chosenType = powerUpTypes[randType];
  //spawna um upgrade a cada 30 segundos
  int randX = round(random(40,440));
  if(powerUpList.size() < 1 && millis() > powerTimer + powerInterval){
    PowerUp power = new PowerUp(randX,0,chosenType);
    powerUpList.add(power);
    powerTimer = millis();
  }
}

void getHighscore(int score){
  if(highscore < score){
    highscore = score;
    newHighscore = true;    
  }
  else{
    return;
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
