int gridSize = 10;
int cellSize = 550/gridSize;
int insert[][];
color black = color(35,40,45);
boolean completed = false;
boolean isComplete[];
Matrix grid;

void setup() {
  fullScreen();
  frameRate(40);
  textAlign(CENTER,CENTER);
  gridSize = values.length/2;
  cellSize = 550/gridSize;
  grid = new Matrix();
  isComplete = new boolean[2*gridSize];
  insert = new int[gridSize*gridSize][3];
}

void draw() {
  background(255);
  grid.show();
  displayNumbers();
  completed = isFinished();
  if(!completed && frameCount < 5) {
    printInsert();
    F1();
    F2();
  }
}

void displayNumbers() {
  fill(black);
  textSize(15);
  float x = grid.cell[0][0].x + cellSize/2;
  float y = grid.cell[0][0].y - cellSize/2;
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
  for(int i=0; i<isComplete.length; i++)
    if(!isComplete[i])
      return false;
  return true;
}

void printInsert() {
  for(int i=0; i<insert.length; i++) {
    println("["+insert[i][0]+","+insert[i][1]+"]:",  insert[i][2]);
  }
}

void insertInto(int i, int j, int state) {
  for(int index=0; index<insert.length; index++) {
    if(insert[index][2] == 0) {
      insert[index][0] = i;
      insert[index][1] = j;
      insert[index][2] = state;
      break;
    }
  }
}
