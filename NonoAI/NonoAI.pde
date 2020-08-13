int gridSize = 10;
int cellSize = 550/gridSize;
color black = color(35,40,45);
boolean completed = false;
boolean isComplete[];
Matrix grid;

void setup() {
  fullScreen();
  textAlign(CENTER,CENTER);
  frameRate(400);
  gridSize = values.length/2;
  cellSize = 550/gridSize;
  grid = new Matrix();
  isComplete = new boolean[2*gridSize];
  F1();
  //F2();
}

void draw() {
  background(255);
  grid.show();
  AI();
  displayNumbers();
  completed = isFinished();
}

void displayNumbers() {
  float x = grid.cell[0][0].x + cellSize/2;
  float y = grid.cell[0][0].y - cellSize/2;
  fill(black);
  textSize(15);
  for(int i=0;i<values.length/2;i++) {
    for(int j=values[i].length-1;j>=0;j--) {
      if(isComplete[i]) fill(black,125);
      else fill(0);
      text(values[i][j],x,y);
      y -= 20;
    }
    y = grid.cell[0][0].y - cellSize/2;
    x += cellSize;
  }
  x = grid.cell[0][0].x - cellSize/3;
  y = grid.cell[0][0].y + cellSize/2;
  for(int i=values.length/2;i<values.length;i++) {
    for(int j=values[i].length-1;j>=0;j--) {
      if(isComplete[i]) fill(black,125);
      else fill(black);
      text(values[i][j],x,y);
      x -= 25;
    }
    x = grid.cell[0][0].x - cellSize/3;
    y += cellSize;
  }
}

boolean isFinished() {
  for(int i=0; i<isComplete.length; i++) {
    if(!isComplete[i]) {
      return false;
    }
  }
  return true;
}
