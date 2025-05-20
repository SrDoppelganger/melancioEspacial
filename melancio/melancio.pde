
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
 println(bulletList.size());
}

void gameLoop(){
  background(16,12,8);
  
  p1.render();
  p1.move();
  
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
    bulletList.add(new Bullet(p1.x + 20,p1.y));
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
