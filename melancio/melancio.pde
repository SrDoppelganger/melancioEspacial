PFont font, boldFont;
String cena;
int[] bg = {0,0,17};

void setup(){
  size(500,650);
  
  font = createFont("PixelOperator.ttf", 128);
  boldFont = createFont("PixelOperator-Bold.ttf", 128);
  
  telaTitulo();
}

void draw(){
  switch(cena){
    case "titulo":
      telaTitulo();
      break;
     case "jogo":
       telaJogo();
       break;
     case "fim":
       telaFim();
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
}

void keyReleased(){
  println(key);
  
  //verifica qual a cena do jogo
  if(cena=="titulo"){
    //começa o jogo quando a tecla de espaço é apertada
    if(key == 32){
      cena = "jogo";
    }
  }
  else if(cena=="jogo"){
    //apenas para teste
    if(key == 32){
      cena = "fim";
    }
  }
  else if(cena=="fim"){
     if(key == 32){
      cena = "titulo";
    }
  }
  
}
