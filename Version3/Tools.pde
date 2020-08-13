int findSum(int index,int lReduce, int rReduce, boolean actual) {
  int sum = 0;
  for(int i=lReduce; i<values[index].length-rReduce; i++)
    sum += values[index][i];
  if(actual)    
    return sum;
  else    
    return sum + values[index].length-(lReduce+rReduce)-1;
}

int findActualSum(int index) {
  int sum = 0;
  for(int i=0; i<values[index].length; i++)
    sum += values[index][i];
  return sum;
}

void checkComplete(int index) {
  if(count(index)[1] == findActualSum(index)) {
    for(int i=0; i<gridSize; i++) {
      if(index < gridSize && grid.cell[i][index].state == 0)
        grid.setState(i, index, -1);
      else if(index >= gridSize && grid.cell[index%gridSize][i].state == 0) 
        grid.setState(index%gridSize,i,-1);
    }
    isComplete[index] = true;
  } else {
    isComplete[index] = false;
  }
}

int[] count(int index) {
  int count0 = 0;
  int count1 = 0;
  for(int i=0; i<gridSize; i++) {
    if(index < gridSize) {
      if(grid.cell[i][index].state == 0) count0++;
      else if(grid.cell[i][index].state == 1) count1++;
    } else {
      if(grid.cell[index%gridSize][i].state == 0) count0++;
      else if(grid.cell[index%gridSize][i].state == 1) count1++;
    }
  }
  int count[] = {count0, count1};
  return count;
}

void printLimits(int index, int limits[]) {
  print(index+": ");
  for(int i=0;i<limits.length;i++) {
    if(i%2 == 0) print("["+limits[i]+" ");
    else print(limits[i]+"] ");
  }
  println();
}

void check() {
  for(int i=0; i<isComplete.length; i++) {
    checkComplete(i);
  }
}

void F1() {
  println("F1", frameCount);
  for (int index=0; index<2*gridSize; index++) {
    if(!isComplete[index]) {
      function1(index, getLimits(index));
      checkComplete(index);
    }
  }
  check();
}

void F2() {
  println("F2", frameCount);
  for (int index=0; index<2*gridSize; index++) {
    if(!isComplete[index]) {
      function2(index, getLimits(index));
      checkComplete(index);
    }
  }
  check();
}

//void F3() {
//  println("F3", frameCount);
//  for (int index=0; index<2*gridSize; index++) {
//    if(!isComplete[index]) {
//      function3(index, getLimits(index));
//      checkComplete(index);
//    }
//  }
//  check();
//}
