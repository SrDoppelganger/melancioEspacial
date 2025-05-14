PFont font, boldFont;
String cena;
int[] bg = {0,0,17};
jogador player;



//imagens/sprites
PImage spritesJogador[];
PImage spritesInimigo[];
int framesJogador;
int frameAtual;


void setup(){
  size(500,650);
  
  framesJogador = 1;
  spritesJogador = new PImage[framesJogador];
  for(int i = 0; i<framesJogador;i++){
    spritesJogador[i]=loadImage("player/sprite_"+i+".png");
  }
  
  player = new jogador();
  
  font = createFont("PixelOperator.ttf", 128);
  boldFont = createFont("PixelOperator-Bold.ttf", 128);
  
  telaTitulo();
}

void draw(){
  switch(cena){
    case "titulo":
      //lógica da tela de inicio
      break;
     case "jogo":
       background(bg[0],bg[1],bg[2]);
       inputJogador();
       drawJogador();
       break;
     case "fim":
       //lógica de Game Over
       break;
  }
}

void telaTitulo(){
  cena = "titulo";
  
  background(bg[0],bg[1],bg[2]);
  textFont(boldFont);
  textSize(80);
  textAlign(CENTER);
  text("Melâncio",250,125);
  text("no Espaço",250,180);
  
  textFont(font);
  textSize(32);
  text("pressione espaço para jogar :3",250,550);
}

void telaJogo(){
  cena = "jogo";
  
  background(bg[0],bg[1],bg[2]);
  textFont(font);
  
  textSize(32);
  text("tela principal",250,50);
  
  
}

void telaFim(){
  cena = "fim";
  
  background(bg[0],bg[1],bg[2]);
  textFont(boldFont);
  
  textSize(64);
  text("GAME OVER",250,250);
  
  textFont(font);
  textSize(32);
  text("pressione espaço para continuar",250,500);
}

//vetor que verifica se uma tecla está sendo pressionada
boolean[] keys = new boolean[256];

void keyPressed(){
  keys[keyCode] = true;
  verificarCena(keys);
}

void keyReleased(){
  keys[keyCode] = false;
  println(keyCode);
}

void verificarCena(boolean[] keys){
    //verifica qual a cena do jogo
  if(cena=="titulo" && keys[32]){
      telaJogo();
  }
  else if(cena=="jogo" && keys[32]){
    //apenas para teste
    telaFim();
    //flag de tiro?
  }
  else if(cena=="fim" && keys[32]){
     telaTitulo();
  }
}

//passar para a classe jogador dps :9
//colisão do jogador
float tamJogador = 32;
float jogadorX = 250;
float jogadorY = 550;

//posição inicial do jogador
float x_inicial = jogadorX;
float y_inicial = jogadorY;

//var de velocidade do jogador
float velJogador = 5;
float jogadorXV = 0;
float jogadorYV = 0;

//var de estados
boolean atirando = false;
boolean morto = false;

void inputJogador(){
  
  if(!morto){
    if(keys[LEFT] && jogadorX > 1){
      jogadorXV = -velJogador;
    }
    else if(keys[RIGHT] && jogadorX < 464){
      jogadorXV = +velJogador;
    }
    else{
      jogadorXV = 0;
    }
    
  }
  
}

void drawJogador(){
  jogadorX += jogadorXV;
  jogadorY += jogadorYV;
  
  //trocar por sprite
  rect(jogadorX, jogadorY, tamJogador,tamJogador);
}
