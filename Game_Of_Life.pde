Board board;
int s = 800;
int rate = 10;
void setup(){
  board = new Board(s);
  board.generate();
  size(800,800);
  //fullScreen();
  background(0);
}

void keyPressed(){
  if(key == ' ')board.reset();
}

void mousePressed(){
  board.pressed = true;
}

void mouseReleased(){
   board.pressed = false;
}

void mouseWheel(){
  
}

void draw(){
  board.initialPopulation = int(map(mouseY, height, 0, 5, 50));
  rate = int(map(mouseX, 0, width, 0, 60));
  frameRate(2+rate);
  background(0);
  board.evolve();
  board.show();
  
}
