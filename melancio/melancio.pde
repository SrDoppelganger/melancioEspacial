PFont font, boldFont;
String cena;
int[] bg = {0,0,17};
jogador player;

//armazena as balas instanciadas
ArrayList<bala> listaBalas;

void setup(){
  size(500,650);
  frameRate(30);
    
  player = new jogador();
  player.carregarSprites();
  
  listaBalas = new ArrayList<bala>();
  
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
       player.inputJogador();
       player.drawJogador();
       atirar();
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

void atirar(){
  for(bala aBullet : listaBalas){
    aBullet.renderizar();
    aBullet.mover(); 
  }
}

//vetor que verifica se uma tecla está sendo pressionada
boolean[] keys = new boolean[256];

void keyPressed(){
  keys[keyCode] = true;
  verificarCena(keys);
  
  if(keys[90] && cena == "jogo"){
    listaBalas.add(new bala(player.getX(), player.getY()));
  }
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
