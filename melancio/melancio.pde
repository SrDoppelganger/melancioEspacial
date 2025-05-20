
//variaveis
Player p1;

ArrayList<Bullet> bulletList;


void setup(){
  size(480,600);
  
  p1 = new Player(220,520);
  
  bulletList = new ArrayList<Bullet>();
}


void draw(){
 gameLoop();
  
}

void gameLoop(){
  background(16,12,8);
  
  p1.render();
  p1.move();
  
  //loop que armazena balas
  for(Bullet aBullet : bulletList){
    aBullet.render();
    aBullet.move();
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
    bulletList.add(new Bullet(p1.x,p1.y));
    println(bulletList.size());
  }
}

void keyReleased(){
  if(keyCode == LEFT){
    p1.movingLeft = false;
  }
  if(keyCode == RIGHT){
    p1.movingRight = false;
  }
}
