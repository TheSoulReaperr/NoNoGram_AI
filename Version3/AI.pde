void function2(int index, int limits[]) {
  printLimits(index, limits);
  int lLimit = limits[0];
  int uLimit = limits[1];
  int lReduce = limits[2];
  int rReduce = limits[3];
  int lValue = 0;
  int rValue = 0;
  if (values[index].length > lReduce && !isComplete[index])
    lValue = values[index][lReduce]+lLimit;
  if (values[index].length - rReduce > 0 && !isComplete[index])  
    rValue = values[index][values[index].length-(rReduce+1)] + (gridSize-uLimit);
  for (int i=lLimit; i<(gridSize+1)/2 && lValue>i; i++) {
    if (index < gridSize) {
      if (grid.cell[i][index].state == 1) {
        for (int j=i+1; j<lValue; j++) {
          println(j, index, 1);
          grid.setState(j, index, 1);
        }
        check();
        if (i == lLimit && grid.cell[i][index].state == 1 && !isComplete[index]) {
          println(i, index, -1);
          grid.setState(lValue, index, -1);
        }
      } else if (grid.cell[i][index].state == -1) {
        for (int j=lLimit; j<i; j++) {
          println(j, index, -1);
          grid.setState(j, index, -1);
        }
      }
    } else {
      if (grid.cell[index%gridSize][i].state == 1) {
        for (int j=i+1; j<lValue; j++) {
          println(j, index, 1);
          grid.setState(index%gridSize, j, 1);
        }
        check();
        if (i == lLimit && grid.cell[index%gridSize][i].state == 1 && !isComplete[index]) {
          println(i, index, -1);
          grid.setState(index%gridSize, lValue, -1);
        }
      } else if (grid.cell[index%gridSize][i].state == -1) {
        for (int j=lLimit; j<i; j++) {
          println(j, index, -1);
          grid.setState(index%gridSize, j, -1);
        }
      }
    }
  }
  for (int i=uLimit-1; i>=(gridSize+1)/2 && rValue>(uLimit-1)-i; i--) {
    if (index < gridSize) {
      if (grid.cell[i][index].state == 1) {
        for (int j=i; j>(uLimit-1)-rValue; j--) {
          println(j, index, 1);
          grid.setState(j, index, 1);
        }
        check();
        if (i == uLimit-1 && grid.cell[i][index].state == 1 && !isComplete[index]) {
          println(i, index, -1);
          grid.setState((uLimit-1)-rValue, index, -1);
        }
      } else if (grid.cell[i][index].state == -1) {
        for (int j=uLimit-1; j>i; j--) {
          println(j, index, -1);
          grid.setState(j, index, -1);
        }
      }
    } else {
      if (index >= gridSize && grid.cell[index%gridSize][i].state == 1) {
        for (int j=i; j>(uLimit-1)-rValue; j--) {
          println(j, index, 1);
          grid.setState(index%gridSize, j, 1);
        }
        check();
        if (i == uLimit-1 && grid.cell[index%gridSize][i].state == 1 && !isComplete[index]) {
          println(i, index, -1);
          grid.setState(index%gridSize, (uLimit-1)-rValue, -1);
        }
      } else if (grid.cell[index%gridSize][i].state == -1) {
        for (int j=uLimit-1; j>i; j--) {
          println(j, index, -1);
          grid.setState(index%gridSize, j, -1);
        }
      }
    }
  }
}

void function1(int index, int limits[]) {
  printLimits(index, limits);
  int lLimit = limits[0];
  int uLimit = limits[1];
  int lReduce = limits[2];
  int rReduce = limits[3];
  int sum = limits[4];
  int size = uLimit - lLimit; 
  for (int i=lReduce; i<values[index].length-rReduce; i++) {
    int value = values[index][i];
    int bound = size-(sum-value);
    if (bound < value*2 && !isComplete[index]) {
      int padding = bound - value;
      int startPosition = lLimit;
      for (int j=lReduce; j<i; j++) {
        startPosition += values[index][j];
      }
      startPosition += padding + i-(lReduce+rReduce);
      int cellCount = bound - 2*padding;
      if (index<gridSize) {
        for (int k=startPosition; k<startPosition+cellCount; k++) {
          if(grid.cell[k][index].state != 1) {
            grid.setState(k, index, 1);
          }
        }
        checkComplete(index);
      } else {
        for (int k=startPosition; k<startPosition+cellCount; k++) {
          if(grid.cell[index%gridSize][k].state != 1) {
            grid.setState(index%gridSize, k, 1);
          }
        }
        checkComplete(index);
      }
    }
  }
}
