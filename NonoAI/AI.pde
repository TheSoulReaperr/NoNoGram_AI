void AI() {
  if(!completed) {
    println("F1", frameCount);
    F1();
    println("F2", frameCount);
    F2();
    println("F3", frameCount);
    F3();
    println("F4", frameCount);
    F4();
  }
}

void function4(int index) {
  int count[] = count(index);
  println(index, count[0],findActualSum(index)-count[1]);
  if(count[0] == findActualSum(index)-count[1] && !isComplete[index]) {
    for(int i=0; i<gridSize; i++) {
      if(index < gridSize && grid.cell[i][index].state == 0)  
        grid.setState(i, index, 1);
      else if (index > gridSize && grid.cell[index%gridSize][i].state == 0)  
        grid.setState(index%gridSize, i, 1);
    }
  }
}

void function3(int index, int limits[]) {
  //printLimits(index, limits);
  int lLimit = limits[0];
  int uLimit = gridSize - limits[1];
  int lReduce = limits[2];
  int rReduce = limits[3];
  int lValue = 0;
  int rValue = 0;
  if(values[index].length > lReduce)
    lValue = values[index][lReduce]+lLimit;
  if(values[index].length - rReduce > 0)  
    rValue = values[index][values[index].length-(rReduce+1)]+uLimit;
  if(index < gridSize && !isComplete[index]) {
    for(int i=lLimit; i<(gridSize+1)/2; i++) {
      if(grid.cell[i][index].state == -1 && lValue > i) {
        for(int j=lLimit; j<i; j++) {
          grid.setState(j, index, -1);
        }
      }
    }
    for(int i=(gridSize-1)-uLimit; i>=(gridSize+1)/2; i--) {
      if(grid.cell[i][index].state == -1 && rValue > gridSize-i) {
        for(int j=(gridSize-1)-uLimit; j>i; j--) {
          grid.setState(j, index, -1);
        }
      }
    }
  } else {
    index = index%gridSize;
    for(int i=lLimit; i<(gridSize+1)/2; i++) {
      if(grid.cell[index][i].state == -1 && lValue > i) {
        for(int j=lLimit; j<i; j++) {
          grid.setState(index, j, -1);
        }
      }
    }
    for(int i=(gridSize-1)-uLimit; i>=(gridSize+1)/2; i--) {
      if(grid.cell[index][i].state == -1 && rValue > gridSize-i) {
        for(int j=(gridSize-1)-uLimit; j>i; j--) {
          grid.setState(index, j, -1);
        }
      }
    }
  }
}

void function2(int index, int limits[]) {
  printLimits(index, limits);
  int lLimit = limits[0];
  int uLimit = limits[1];
  int lReduce = limits[2];
  int rReduce = limits[3];
  int lValue = 0;
  int rValue = 0;
  if(values[index].length > lReduce && !isComplete[index])
    lValue = values[index][lReduce]+lLimit;
  if(values[index].length - rReduce > 0 && !isComplete[index])  
    rValue = values[index][values[index].length-(rReduce+1)] + (gridSize-uLimit);
  for(int i=lLimit; i<(gridSize+1)/2; i++) {
    if(index < gridSize && grid.cell[i][index].state == 1 && lValue > i+1) {
      for(int j=i+1; j<lValue; j++) {
        grid.setState(j, index, 1);
      }
      check();
      if(i == lLimit && grid.cell[i][index].state == 1 && !isComplete[index])
        grid.setState(lValue, index, -1);
    } else if(index >= gridSize && grid.cell[index%gridSize][i].state == 1 && lValue > i+1) {
      for (int j=i+1; j<lValue; j++) {
        grid.setState(index%gridSize, j, 1);
      }
      check();
      if(i == lLimit && grid.cell[index%gridSize][i].state == 1 && !isComplete[index]) 
        grid.setState(index%gridSize, lValue, -1);
    }
  }
  for(int i=(gridSize-1)-uLimit; i>(gridSize+1)/2; i--) {
    if(values[index].length - rReduce > 0) {
      if(index < gridSize && grid.cell[i][index].state == 1 && rValue > (gridSize-1)-i) {
        for(int j=i; j>gridSize-rValue; j--) {
          grid.setState(j,index,1);
        }
        check();
        if(i == (gridSize-1)-uLimit && grid.cell[i][index].state == 1 && !isComplete[index]) 
          grid.setState((gridSize-1)-rValue, index, -1);
      } else if(index >= gridSize && grid.cell[index%gridSize][i].state == 1 && rValue > (gridSize-1)-i) {
        for(int j=i; j>gridSize-rValue; j--) {
          grid.setState(index%gridSize, j, 1);
        }
        check();
        if(i == (gridSize-1)-uLimit && grid.cell[index%gridSize][i].state == 1 && !isComplete[index])
          grid.setState(index%gridSize, (gridSize-1)-rValue, -1);
      }
    }
  }
}

void function1(int index, int limits[]) {
  printLimits(index,limits);
  int lLimit = limits[0];
  int uLimit = limits[1];
  //if(uLimit == gridSize-1) uLimit--;
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
          grid.setState(k, index, 1);
        }
        checkComplete(index, findActualSum(index));
      } else {
        for (int k=startPosition; k<startPosition+cellCount; k++) {
          grid.setState(index%gridSize, k, 1);
        }
        checkComplete(index, findActualSum(index));
      }
    }
  }
}
