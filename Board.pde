
//An empty position at time t will contain a bacterium at time t + 1 if and only if at time t it had exactly three neighbor bacteria.
//An occupied position at time t will contain a bacterium at time t + 1 if and only if at time t it had two or three neighbor bacteria.

class Board{
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
        else board[i][j] = false;
      }
    }
  }
  
  void reset(){
    board = new boolean[rows][cols];
    generate();
  }
  
  void show(){
    
    int w = width/cols;
    int h = height/rows;
    col = color(r,255,0);
    for(int i = 0; i<rows; ++i){
      for(int j = 0; j<cols; ++j){
        if(board[i][j] == true){
          fill(col);
          noStroke();
          rect(i*h, j*w, w,h);
        }
      }
    }
    fill(255,0,0);
    stroke(255);
    textSize(18);
    text("Population: " + population,20,height-25);
    
  }
  
  boolean checkPosition(int i, int j){
    
    boolean upper = i==0;
    boolean lower = i==(rows-1);
    boolean right = j==(cols-1);
    boolean left = j==0;

    int bact = 0;

    if(!upper && board[i-1][j])bact = bact+1;
    if(!left && board[i][j-1])bact = bact+1;
    if(!lower && board[i+1][j])bact = bact+1;
    if(!right && board[i][j+1])bact = bact+1;
    if(!upper && !left && board[i-1][j-1])bact = bact+1;
    if(!lower && !right && board[i+1][j+1])bact = bact+1;
    if(!upper && !right && board[i-1][j+1])bact = bact+1;
    if(!lower && !left && board[i+1][j-1])bact = bact+1;
    
    if(board[i][j] && (bact == 2 || bact == 3))return true;
    if(!board[i][j] && bact == 3)return true;
    
    return false;
  }
  
  void evolve(){
    int total = 0;
     for(int i = 0; i<rows; ++i){
      for(int j = 0; j<cols; ++j){
        boolean alive = checkPosition(i,j);
        if(alive)total++;
        board[i][j] = alive;
        
      }
    
  }  
  
  if(pressed){    //PAINTING ON THE BOARD
    //int w = width/cols;
    //int h = height/rows;
    int x = (cols*mouseX)/width;
    int y = (rows*mouseY)/height;
    board[x][y] = true;
  }
  
  //println("total bateries: " + total);

  r =  int(map(total, 0,40000, 0,255));
  population = total;

  }
}
