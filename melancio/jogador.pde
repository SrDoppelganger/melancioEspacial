//colisão do jogador
float tamJogador = 32;
float jogadorX = 250;
float jogadorY = 550;

//posição inicial do jogador
float x_inicial = jogadorX;
float y_inicial = jogadorY;

//var de velocidade do jogador
float velJogador = 10;
float jogadorXV = 0;
float jogadorYV = 0;

//var de estados
boolean atirando = false;
boolean morto = false;

//var de sprites
PImage sprites[];
int framesJogador;
int frameAtual = 0;

public class jogador{
  
  //carrega os sprites no setup para evitar problemas de performance
  void carregarSprites(){
    framesJogador = 4;
    sprites= new PImage[framesJogador];
    for(int i = 0; i<framesJogador;i++){
      sprites[i]=loadImage("Player/sprite_"+i+".png");
    }
    
 
  }
  
  void inputJogador(){
    if(!morto){
      if(keys[LEFT] && jogadorX > 1){
        jogadorXV = -velJogador;
      }
      else if(keys[RIGHT] && jogadorX < 400){
        jogadorXV = +velJogador;
      }
      else{
        jogadorXV = 0;
        atirando = false;
      }
    }//if de inputs
    
     if(keys[90]){
        atirando = true;
      }
  }
  
  void drawJogador(){
    jogadorX += jogadorXV;
    jogadorY += jogadorYV;
 
    //rect(jogadorX, jogadorY, tamJogador,tamJogador);
    if(atirando){
      frameAtual = (frameAtual+1) % framesJogador;
      image(sprites[frameAtual], jogadorX,jogadorY);
    }
    image(sprites[0], jogadorX,jogadorY);
  }

}
