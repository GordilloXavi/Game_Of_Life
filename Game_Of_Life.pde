//TODO: toggle LOOPING to reset the simulation when the number of particles is really big in proportion to size of the board

Board board;
int s = 400;
int rate = 40;
void setup(){
  
  size(800,800);
  //fullScreen();
  background(0);
  board = new Board(s);
  board.generate();
}

void keyPressed(){
  if(key == ' ')board.reset();
  if(key == 'r' || key == 'R')board.running = !board.running;
}

void mousePressed(){
  board.pressed = true;
}

void mouseReleased(){
   board.pressed = false;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0 && rate < 60)rate++;
  else if(e<0 && rate > 0)rate--;
}

void draw(){
  board.initialPopulation = int(map(mouseY, height, 0, 2, 50));
  //rate = int(map(mouseX, 0, width, 0, 60));
  frameRate(2+rate);
  background(0);
  board.evolve();
  board.show();
  
}
