Board board;
int s = 300;
int rate = 40;
void setup(){
  
  size(900,900);
  //fullScreen();
  background(0);
  board = new Board(s);
  board.generate();
}

void keyPressed(){
  if(key == 'h' || key == 'H')board.half = !board.half; // The population will only spawn in the upper half of the screen
  if(key == ' ')board.reset(); // Resets the simulation
  if(key == 'r' || key == 'R')board.running = !board.running; // Pauses / Resumes the simulation
  if(key == 'x' || key == 'X')board.explode(); // When the simulation reaches a static scenario, press x to create new particles in the same simulation
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
