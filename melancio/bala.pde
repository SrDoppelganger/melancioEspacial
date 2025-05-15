//var de projéteis
float balaX;
float balaY;
int tamanho;
float velocidade;

boolean foraDeTela;

class bala{
  //constructor (define como novas balas devem ser instanciadas)
  bala(float x_inicial, float y_inicial){
    balaX = x_inicial;
    balaY = y_inicial;
    tamanho = 8;
    velocidade = 15;
    
    foraDeTela = false;
  }
  
  void renderizar(){
    circle(balaX,balaY,tamanho);
  }

  void mover(){
    balaY -= velocidade;
    println(velocidade);
  }
  
  //remove a bala do jogo caso ela saia da tela
  void checarTela(){}
}
