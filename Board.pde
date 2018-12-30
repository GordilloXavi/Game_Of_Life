
//An empty position at time t will contain a bacterium at time t + 1 if and only if at time t it had exactly three neighbor bacteria.
//An occupied position at time t will contain a bacterium at time t + 1 if and only if at time t it had two or three neighbor bacteria.

class Board{
  
  boolean half = false;
  boolean running = false;
  int initialPopulation = 15;
  int population = 0;
  boolean pressed = false;
  int r = 0;
  color col = color(r,255,0);
  int rows, cols;
  boolean[][] board;
  
  public Board(int rows, int cols){
    this.rows = rows;
    this.cols = cols;
    board = new boolean[rows][cols];
  }
  public Board(int size){
    this.rows = size;
    this.cols = size;
    board = new boolean[rows][cols];
  }
  
  void generate(){
    for(int i = 0; i<rows; ++i){
      for(int j = 0; j<cols; ++j){

        int r = int(random(0,initialPopulation));    //INCREASE THE SECOND VALUE TO DECREADSE THE STARTING NUMBER OF BACTERIES
        if(r == 0)board[i][j] = true;
        if(half && j > cols/2 || r != 0)board[i][j] = false;
      }
    }
  }
  
  void reset(){
    board = new boolean[rows][cols];
    generate();
  }
  
  void show(){ //TODO: show a pause logo when the simulation is paused.
    
    int w = width/cols;
    int h = height/rows;
    col = color(r,255,0);
    for(int i = 0; i<rows; ++i){
      for(int j = 0; j<cols; ++j){
        if(board[i][j] == true){
          fill(col);
          stroke(0);
          if(w<3)noStroke();
          rect(i*h, j*w, w,h);
        }
      }
    }
    fill(255,0,0);
    stroke(255);
    textSize(20);
    text("Population: " + population,20,height-25);
    fill(150);
    if(running)text("Running" ,width-100,20);
    else text("Paused" ,width-89,20);
  }
  
  boolean checkPosition(int i, int j){
    
    boolean upper = i==0;
    boolean lower = i==(rows-1);
    boolean right = j==(cols-1);
    boolean left = j==0;

    int bact = 0;

    if(!upper && board[i-1][j])bact++;
    if(!left && board[i][j-1])bact++;
    if(!lower && board[i+1][j])bact++;
    if(!right && board[i][j+1])bact++;
    if(!upper && !left && board[i-1][j-1])bact++;
    if(!lower && !right && board[i+1][j+1])bact++;
    if(!upper && !right && board[i-1][j+1])bact++;
    if(!lower && !left && board[i+1][j-1])bact++;
    
    if(board[i][j] && (bact == 2 || bact == 3))return true;
    if(!board[i][j] && bact == 3)return true;
    
    return false;
  }
  
  boolean[][] createBoard(){
    boolean[][] board2 = new boolean[rows][cols];;
    for(int i = 0; i<rows; ++i){
      for(int j = 0; j<cols; ++j)board2[i][j] = board[i][j];
    }
    return board2;
  }
  
  void evolve(){
    boolean[][] board2 = createBoard();
    
    int total = 0;
     for(int i = 0; i<rows; ++i){
      for(int j = 0; j<cols; ++j){
        boolean alive = checkPosition(i,j);
        if(running)board2[i][j] = alive;
        if(board2[i][j])total++;
      }
    
  }  
  
  if(pressed){    //PAINTING ON THE BOARD
    //int w = width/cols;
    //int h = height/rows;
    int x = (cols*mouseX)/width;
    int y = (rows*mouseY)/height;
    if(x>=0 && x<rows && y>=0 && y<cols)board2[x][y] = true;
  }
  
  
  //println("total bateries: " + total);
  board = board2;
  //r =  int(map(total, 0,40000, 0,255));
  population = total;

  }
}
