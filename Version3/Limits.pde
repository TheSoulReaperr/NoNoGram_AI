int[] getLimits(int index) {
  int state = 0;
  int sum = 0;
  int actualSum = 0;
  int lLimit = 0;
  int uLimit = gridSize;
  int leftReduceValue = 0;
  int rightReduceValue = 0;
  boolean reduceValue = false;
  for(int i=0; i<gridSize-1; i++) {
    if(index < gridSize)  
      state = grid.cell[i][index].state;
    else 
      state = grid.cell[index%gridSize][i].state;
    if(state == 1) {
      reduceValue = true;
    } else if(state == -1) {
      if(reduceValue) {
        leftReduceValue++;
        reduceValue = false;
      }
      lLimit = i+1;
    } else {
      reduceValue = false;
      break;
    }
  }
  for(int i=gridSize-1; i>0; i--) {
    if(index < gridSize)  
      state = grid.cell[i][index].state;
    else 
      state = grid.cell[index%gridSize][i].state;
    if (state == 1) {
      reduceValue = true;
    } else if (state == -1) {
      if (reduceValue) {
        rightReduceValue++;
        reduceValue = false;
      }
      uLimit = i;
    } else {
      reduceValue = false;
      break;
    }
  }
  sum = findSum(index, leftReduceValue, rightReduceValue, false);
  actualSum = findSum(index, leftReduceValue, rightReduceValue, true);
  int returnValue[] = {lLimit, uLimit, leftReduceValue, rightReduceValue, sum, actualSum};
  return returnValue;
}
