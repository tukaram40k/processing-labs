class Cell {
  int state;
  int nextState;
  
  Cell() {
    // initial state
    float r = random(1);
    if (r < 0.05) state = 2;
    else if (r < 0.15) state = 1;
    else state = 0;
  }
}

class Ecosystem {
  int cols, rows;
  Cell[][] grid;
  
  Ecosystem(int w, int h) {
    cols = w;
    rows = h;
    grid = new Cell[cols][rows];
    
    // init grid
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        grid[x][y] = new Cell();
      }
    }
  }
  
  void update() {
    // copy to store next states
    Cell[][] nextGrid = new Cell[cols][rows];
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        nextGrid[x][y] = new Cell();
        nextGrid[x][y].state = grid[x][y].state;
      }
    }
    
    // update cells
    for (int x = 1; x < cols-1; x++) {
      for (int y = 1; y < rows-1; y++) {
        int[] neighborCounts = countNeighbors(x, y);
        
        // system rules
        switch(grid[x][y].state) {
          case 0:
            if (random(1) < 0.001) {
              nextGrid[x][y].state = 1;
            }
            break;
            
          case 1: // prey
            if (neighborCounts[1] > 2 && neighborCounts[1] < 5) {
              int[] emptyCell = findEmptyNeighbor(x, y);
              if (emptyCell != null) {
                nextGrid[emptyCell[0]][emptyCell[1]].state = 1;
              }
            }

            if (neighborCounts[2] > 0) {
              nextGrid[x][y].state = 2;
            }
            
            if (neighborCounts[1] > 5 || neighborCounts[1] == 0) {
              nextGrid[x][y].state = 0;
            }
            break;
            
          case 2: // predator
            if (neighborCounts[2] > 1 && neighborCounts[2] < 4) {
              int[] emptyCell = findEmptyNeighbor(x, y);
              if (emptyCell != null) {
                nextGrid[emptyCell[0]][emptyCell[1]].state = 2;
              }
            }
            
            if (neighborCounts[1] == 0) {
              nextGrid[x][y].state = 0;
            }
            break;
        }
      }
    }
    
    // update grid
    grid = nextGrid;
  }
  
  int[] countNeighbors(int x, int y) {
    int[] counts = new int[3];
    
    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;
        int nx = x + dx;
        int ny = y + dy;
        
        if (nx >= 0 && nx < cols && ny >= 0 && ny < rows) {
          counts[grid[nx][ny].state]++;
        }
      }
    }
    
    return counts;
  }
  
  int[] findEmptyNeighbor(int x, int y) {
    // shuffled directions
    int[][] dirs = {{-1,0}, {1,0}, {0,-1}, {0,1}, {-1,-1}, {-1,1}, {1,-1}, {1,1}};
  
    for (int i = dirs.length - 1; i > 0; i--) {
      int index = int(random(i + 1));
      int[] temp = dirs[index];
      dirs[index] = dirs[i];
      dirs[i] = temp;
    }
    
    // find first empty neighbor
    for (int[] dir : dirs) {
      int nx = x + dir[0];
      int ny = y + dir[1];
      
      if (nx >= 0 && nx < cols && ny >= 0 && ny < rows && grid[nx][ny].state == 0) {
        return new int[]{nx, ny};
      }
    }
    
    return null;
  }
  
  void display() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        
        // color coding
        switch(grid[x][y].state) {
          case 0:
            fill(#C7EDCE); 
            break;
          case 1:
            fill(#AF7B50);
            break;
          case 2:
            fill(#A450AF);
            break;
        }
        noStroke();
        rect(x*10, y*10, 10, 10);
      }
    }
  }
}

Ecosystem ecosystem;

void setup() {
  size(1500, 1000);
  ecosystem = new Ecosystem(width/10, height/10);
  frameRate(7);
}

void draw() {
  background(#C7EDCE);
  ecosystem.update();
  ecosystem.display();
}
