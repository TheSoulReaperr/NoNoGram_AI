class Matrix {
  int startLocationX = width/2 - (cellSize*gridSize)/2;
  int startLocationY = height/2 - (cellSize*gridSize)/2;
  float x = startLocationX;
  float y = startLocationY;
  Cell cell[][];
  
  Matrix() {
    cell = new Cell[gridSize][gridSize];
    for(int i=0;i<cell.length;i++) {
      for(int j=0;j<cell[i].length;j++) {
        cell[i][j] = new Cell(x,y);
        x+=cellSize;
      }
      x = startLocationX;
      y+=cellSize;
    }
  }
  
  void setState(int i, int j, int state) {
    boolean flag = false;
    for(int index=0; index<insert.length; index++) {
      if(insert[index][0] == i && insert[index][1] == j && insert[index][2] == state) {
      } else {
        flag = true;
        break;
      }
    }
    if(flag) insertInto(i, j, state);
    //cell[i][j].state = state;
  }
  
  void show() {
    for(Cell[] r: cell) {
      for(Cell c: r) {
        c.show();
      }
    }
  }
}

class Cell {
  float x,y,s;
  int state = 0;
  
  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    s = cellSize;
  }
  
  void show() {
    stroke(45);
    strokeWeight(2);
    if(state == -1) {
      fill(255);
      rect(x,y,s,s);
      fill(black,200);
      textSize(700/values.length);
      text("X",x+s/2,y+s/2);
    } else if(state == 1) {
      fill(black);
      rect(x,y,s,s);
    } else {
      fill(255);
      rect(x,y,s,s);
    }
  }
}
