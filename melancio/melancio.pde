import gifAnimation.*;

//variaveis de classes 
Player p1;
ArrayList<Enemy> enemyList;
ArrayList<Bullet> bulletList;
PowerUp powerUp;
ArrayList<PowerUp> powerUpList;
String[] powerUpTypes;

//variaveis de imagens
PImage playerSprites[];
PImage enemySprites[];
PImage powerUpSprites[];
int playerFrames; 
int enemyFrames;
int powerUpFrames;

PImage titleBG,altBG,lunaticBG;
Gif spaceBG;
PImage easyButton,mediumButton,hardButton,lunaticButton;

//variaveis de gameplay
String cena;
int pontos,multiplicador,pontuacao;
boolean bombUsed;
int bombAnimation, bombDuration;
String dificuldade;
boolean lunatic;

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


void setup(){
  size(480,640);
  
  font = createFont("PixelOperator.ttf",64);
  fontBold = createFont("PixelOperator-Bold.ttf",64);
  
 
  loadAssets();
  loadSprites();
  
  //inicializa timers
  spawnTimer = millis();
  spawnInterval = 500;
  
  powerTimer = millis();
  powerInterval = 30000;
  
  bombAnimation = millis();
  bombDuration = 800;
  
  p1 = new Player(width/2,550);
  bulletList = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();
  powerUpList = new ArrayList<PowerUp>();
  powerUpTypes = new String[]{"health","bomb"};
  
  //inicializa highscore
  highscore = 0;
  multiplicador = 1;
  bombUsed = false;
  
  cena = "titulo";
}


void draw(){
  if(cena == "titulo"){
    titleScreen();
  }
  if(cena == "dificuldades"){
    selectionScreen();
  }
  if(cena == "jogo"){
    gameLoop();
  }
  if(cena == "gameOver"){
    gameOverScreen();
  }
  if(cena == " "){
    secretScreen();
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

void loadAssets(){
   titleBG = loadImage("data/Assets/pde_title.png");
   altBG = loadImage("data/Assets/pde_altScreen.png");
   lunaticBG = loadImage("data/Assets/pde_lunaticScreen.png");
   spaceBG = new Gif(this,"Assets/pde_mainBg.gif");
   spaceBG.play();
   
   easyButton = loadImage("data/Assets/pde_easy.png");
   mediumButton = loadImage("data/Assets/pde_medium.png");
   hardButton = loadImage("data/Assets/pde_hard.png");
   lunaticButton = loadImage("data/Assets/pde_lunatic.png");
}

void gameLoop(){
  pontuacao = pontos * multiplicador;
  
  background(0,0,14);
  imageMode(CENTER);
  image(spaceBG,width/2,height/2);
  
  
  p1.render();
  p1.move();
  
  bulletLogic();
  enemyLogic();
  powerUpLogic();
  
  //HUD
  textFont(font);
  textSize(24);
  textAlign(LEFT);
  fill(255);
  text("pontuação: "+nf(pontuacao,4),5,20);
  
  rectMode(CENTER);
  fill(0);
  rect(width/2,615,width,50);
  
  textSize(24);
  textAlign(LEFT);
  fill(255,8,0);
  text("vida:"+nf(p1.health,2),10,620);
  
  textSize(24);
  textAlign(RIGHT);
  fill(76,187,23);
  text("bombas:"+nf(p1.bombs,2),470,620);
  
  textSize(24);
  textAlign(CENTER);
  fill(255);
  text(dificuldade,width/2,620);
  
  
  if(p1.isDead == true){
    cena = "gameOver";
  }
  
  //faz a tela piscar quando o jogador usa uma bomba
  if(bombUsed == true){
    
    fill(255);
    rectMode(RIGHT);
    rect(0,0,width,height);
    if(millis() > bombAnimation + bombDuration){
      bombUsed = false;
    }
  }
}

void titleScreen(){
  background(0,0,14);
  imageMode(CENTER);
  image(titleBG,width/2,height/2);
  
  textFont(fontBold);
  textSize(48);
  textAlign(CENTER);
  fill(255);
  text("Melâncio no Espaço:",width/2,100);
  
  textFont(font);
  textSize(32);
  fill(255,165,0);
  text("pressione espaço para jogar",width/2,575);
  
  textFont(fontBold);
  textAlign(CENTER);
  textSize(32);
  fill(255);
  text("Prelúdio Da Esperança",width/2,140);
  
  //achar um jeito melhor de fazer isso
  //lembrar de resetar o timer de power-ups em gameLoop()
  p1.resetStats();
  newHighscore = false;
}

void gameOverScreen(){
  background(0,0,14);
  imageMode(CENTER);
  image(altBG,width/2,height/2);
  
  getHighscore(pontuacao);
  lunatic = false;
  
  textFont(fontBold);
  textSize(64);
  textAlign(CENTER);
  fill(237,41,57);
  text("GAME OVER",width/2,100);
  
  textFont(font);
  textSize(32);
  fill(255,255,49);
  text("Highscore: "+ nf(highscore,4), width/2,280);
  
  fill(255);
  text("Sua pontuação: "+ nf(pontuacao,4), width/2,height/2);
  
  fill(255,165,0);
  text("pressione espaço para continuar",width/2,550);
  
  if(pontuacao >= 100 && dificuldade == "difícil"){
   textSize(24);
   fill(255,0,0);
   text("cuidado com a tecla 4 na tela de dificuldade", width/2,620);
  }
  
  if(newHighscore == true){
    textFont(fontBold);
    textSize(32);
    fill(255,67,164);
    text("Novo recorde!!!", width/2,400);
  }
  
  
}

void selectionScreen(){
  background(0,0,14);
  imageMode(CENTER);
  image(altBG,width/2,height/2);
  
  textFont(fontBold);
  textSize(48);
  textAlign(CENTER);
  fill(255);
  text("Escolha a Dificuldade",width/2,50);
  
  strokeWeight(2);
  imageMode(CORNER);
  
  image(easyButton,30,150,300,100);
  image(mediumButton,80,275,300,100);
  image(hardButton,130,400,300,100);

  textFont(font);
  textAlign(LEFT);
  textSize(24);
  fill(255);
  
  fill(1,68,33);
  text("1-Fácil\n     5 vidas\n     3 bombas",40,175);
  fill(28,40,65);
  text("2-Médio\n     3 vidas\n     1 bombas",90,300);
  fill(20,0,0);
  text("3-Difícil\n     2 vidas\n     0 bombas",140,425);
  
  
  textAlign(RIGHT);
  fill(1,68,33);
  text("pontuação x1",320,240);
  fill(28,40,65);
  text("pontuação x2",370,365);
  fill(20,0,0);
  text("pontuação x3",420,490);
  
  textAlign(CENTER);
  fill(255,165,0);
  text("Pressione as teclas númericas para escolher", width/2, 100);
}

void secretScreen(){
  background(0,0,14);
  imageMode(CENTER);
  image(lunaticBG,width/2,height/2);
  
  textFont(fontBold);
  textSize(48);
  textAlign(CENTER);
  fill(255);
  text("Dificuldade Secreta",width/2,50);
  

  image(lunaticButton,width/2,height/2,300,100);
 
  textFont(font);
  textSize(24);
  textAlign(LEFT);
  fill(230,230,250);
  text("4-Lunático\n     1 vidas\n     0 bombas",100,290);
  
  textAlign(RIGHT);
  text("pontuação x4",380,360);
  
  textAlign(CENTER);
  fill(255);
  text("pressione Z para selecionar",width/2,600);
  text("pressione X para retornar",width/2,620);
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
  
   //remove todas as balas quando acaba o jogo
  if(p1.isDead == true){
   for(int i = bulletList.size()-1; i >= 0; i--){
     Bullet aBullet = bulletList.get(i);
     bulletList.remove(aBullet);
   }
  }
}

void bombLogic(){
  p1.bombs -= 1;
  bombUsed = true;
  bombAnimation = millis();
  
  //remove todos os inimigos da tela e aumenta o tempo de spawn de mais inimigos para melhor efeito
  spawnTimer = millis() + 1500;
  for(int i = enemyList.size()-1; i>=0; i--){
    Enemy anEnemy = enemyList.get(i);
    enemyList.remove(anEnemy);
    pontos++;
  }
}

void enemyLogic(){
  for(Enemy anEnemy : enemyList){
    anEnemy.render();
    anEnemy.move();
    anEnemy.lunacy(lunatic);
    
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
    power.lunacy(lunatic);
    
    power.checkPlayer(p1);
  }
  
  for(int i = powerUpList.size()-1; i >= 0; i--){
    PowerUp power = powerUpList.get(i);
    
    if(power.taken == true){
      powerUpList.remove(power);
    }
  }
  
  
  //spawna um upgrade a cada 30 segundos
  int randX = round(random(40,440));
  if(powerUpList.size() < 1 && millis() > powerTimer + powerInterval){
    //randomiza o tipo de power up
    int randType = round(random(0,1));
    String chosenType = powerUpTypes[randType];
    
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
    cena = "dificuldades";
  }
  if(key == '1' && cena == "dificuldades"){
    dificuldade = "fácil";
    p1.updateStats(dificuldade);
    multiplicador = 1;
    cena = "jogo";
  }
  if(key == '2' && cena == "dificuldades"){
    dificuldade = "médio";
    p1.updateStats(dificuldade);
    multiplicador = 2;
    cena = "jogo";
  }
  if(key == '3' && cena == "dificuldades"){
    dificuldade = "difícil";
    p1.updateStats(dificuldade);
    multiplicador = 3;
    cena = "jogo";
  }
  if(key == '4' && cena == "dificuldades"){
    cena = " ";
  }
  if(key == 'z' && cena == " "){
    dificuldade = "lunático";
    p1.updateStats(" ");
    multiplicador = 4;
    lunatic = true;
    cena = "jogo";
  }
  if(key == 'x' && cena == " "){
    cena = "dificuldades";
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
  if(key == 'x' && p1.bombs > 0){
    bombLogic();
  }
}
