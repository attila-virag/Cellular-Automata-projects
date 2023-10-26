final int WIDTH = 1600; //pixels
final int HEIGHT = 900; // pixels
int boxSize =2;

int BoxCountX = WIDTH/boxSize;
int BoxCountY = HEIGHT/boxSize;

int CurrentViewMinX = 0;
int CurrentViewMaxX = BoxCountX;
int CurrentViewMinY = 0;
int CurrentViewMaxY = BoxCountY;

int startX;
int startY;
int endX;
int endY;
//int centerY = BoxCountY/2;


final color onBoxColor = color(255,100,0);
final color offBoxColor = color(0,0,0);
//final color dyingBoxColor = color(0,0,255);

boolean paused = false;

int [][] boxesCurrentState = new int [BoxCountX][BoxCountY];
int [][] boxesNextState = new int [BoxCountX][BoxCountY];
int [][] boxesChanged = new int [BoxCountX][BoxCountY];
 //<>// //<>//

void settings() {
  //this should be here
  size(WIDTH, HEIGHT);
}

void setup() {
  for (int i = 0; i< BoxCountX; i++) {
    for (int j = 0; j < BoxCountY; j++) {
      int r = (int) random(0, 100);
      if(r < 98) {
        boxesCurrentState[i][j] = 0;
      }
      else {
        boxesCurrentState[i][j] = 1;
      }
      boxesChanged[i][j] = 1; // mark everything as changed when first drawing
    }
  }
}



void UpdateBoxState(int i, int j) {

  int currentBoxSate = boxesCurrentState[i][j];

  int neighborBoxesOn = 0;
  //int neighborBoxesOff = 0;

  int x_pos, y_pos;
  // check the surrounding 9 boxes, wrap around if needed
  for (int x = i-1; x <= i+1; x++) {
    // check for wrap around
    if (x < 0) {
      x_pos = BoxCountX-1;
    } else if (x > BoxCountX-1) {
      x_pos = 0;
    } else {
      x_pos = x;
    }
    for (int y = j-1; y <= j+1; y++) {
      // check for wrap around
      if (y < 0) {
        y_pos = BoxCountY-1;
      } else if (y > BoxCountY-1) {
        y_pos = 0;
      } else {
        y_pos = y;
      }

      if (x_pos == i && y_pos == j ) {
        continue;
      }

      // now we can check the state of box at x_pos,y_pos
      int current = boxesCurrentState[x_pos][y_pos];

      if (current == 1) {
        neighborBoxesOn++;
      } else if (current == 0) {
        //neighborBoxesOff++;
      }
    }
  }

  if (currentBoxSate == 1) {
    // if it has 2 or three neighbors it stays on else goes off
    if (neighborBoxesOn > 1 && neighborBoxesOn < 4) {
      boxesNextState[i][j] = 1;
      return;
    }
    // else goes off
    boxesNextState[i][j] = 0;
    boxesChanged[i][j] = 1;
    return;
  } else if (currentBoxSate == 0) {
    // it goes on if it has exactly 3 live neighbors
    if (neighborBoxesOn == 3) {
      boxesNextState[i][j] = 1;
      boxesChanged[i][j] = 1;
      return;
    } else {
      boxesNextState[i][j] = 0;
    }
  }
}

void UpdateBoxes() {
  for (int i = 0; i< BoxCountX; i++) {
    for (int j = 0; j < BoxCountY; j++) {
      //boxesCurrentState[i][j] = boxesNextState[i][j];
      UpdateBoxState(i, j);
      //int c = (int)random(0, 100);
      //if(c < 99) {
      //  if(boxesCurrentState[i][j] == 0) {
      //    boxesNextState[i][j] = 1;
      //  }
      //  else if (boxesCurrentState[i][j] == 1){
      //    boxesNextState[i][j] = 0;
      //  }
      //  boxesChanged[i][j] =1;
      //}
      //boxesCurrentState[i][j] = boxesNextState[i][j];
    }
  }
  //
  for (int i = 0; i< BoxCountX; i++) {
    for (int j = 0; j < BoxCountY; j++) {
        boxesCurrentState[i][j] = boxesNextState[i][j];
      }
    }
}

void TranslateBoxesX(int diffX) {
 
  for (int i = 0; i< BoxCountX; i++) {
    for (int j = 0; j < BoxCountY; j++) {
      
      // if we have points that went off the grid we must wrap them
      int i_new = i+diffX;
      if(i_new < 0) {
       // how much below zero?
       i_new = BoxCountX-(-1*i_new);
      }
      else if (i_new >= BoxCountX) {
       i_new = i_new - BoxCountX; 
      }
      
      boxesNextState[i_new][j] = boxesCurrentState[i][j];
      boxesChanged[i_new][j] = 1;
    }
  }
  
}

void TranslateBoxesY(int diffY) {
 
  for (int i = 0; i< BoxCountX; i++) {
    for (int j = 0; j < BoxCountY; j++) {
      
      // if we have points that went off the grid we must wrap them
      int j_new = j+diffY;
      if(j_new < 0) {
       // how much below zero?
       j_new = BoxCountY-(-1*j_new);
      }
      else if (j_new >= BoxCountY) {
       j_new = j_new - BoxCountY; 
      }
      
      boxesNextState[i][j_new] = boxesCurrentState[i][j];
      boxesChanged[i][j_new] = 1;
    }
  }
  
}


color GetRandomColor() {
  int r = (int)random(255, 255);
  int g = (int)random(55, 255);
  int b = (int)random(55, 255);
  //int r = 100;
  //int g = 100;
  //int b = 100;
  return color(r,g,b);
}

void drawCurrentView() {
   
  for (int i = CurrentViewMinX; i < CurrentViewMaxX; i++) {
    for (int j = CurrentViewMinY; j < CurrentViewMaxY; j++) {
      if(boxesChanged[i][j] == 1) {
        int x = (i-CurrentViewMinX) * boxSize;
        int y = (j-CurrentViewMinY) * boxSize;
        if(boxesCurrentState[i][j] == 1) {
          fill(GetRandomColor());
        }
        else {
          fill(offBoxColor);
        }
        stroke(0);
        rect (x, y, boxSize, boxSize);
        boxesChanged[i][j] = 0;
      }
    }
  }
  
}

void draw() {
 
  drawCurrentView();
  //for (int i = 0; i< BoxCountX; i++) {
  //  for (int j = 0; j < BoxCountY; j++) {
  //    if(boxesChanged[i][j] == 1) {
  //      int x = i * boxSize;
  //      int y = j * boxSize;
  //      if(boxesCurrentState[i][j] == 1) {
  //        fill(GetRandomColor());
  //      }
  //      else {
  //        fill(offBoxColor);
  //      }
  //      stroke(0);
  //      rect (x, y, boxSize, boxSize);
  //      boxesChanged[i][j] = 0;
  //    }
  //  }
  //}

if (!paused) {
    UpdateBoxes();
    //for (int i = 0; i< BoxCountX; i++) {
    //  for (int j = 0; j < BoxCountY; j++) {
    //    if(boxesCurrentState[i][j] != boxesNextState[i][j]) {
    //      boxesChanged[i][j] = 1;
    //    }
    //    else {
    //      boxesChanged[i][j] = 0;
    //    }
    //    boxesCurrentState[i][j] = boxesNextState[i][j];

    //  }
    //}
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    
    startX = mouseX;
    startY = mouseY;
    //boxesCurrentState[ / boxSize][mouseY / boxSize] = 1;
    //boxesChanged[mouseX / boxSize][mouseY / boxSize] = 1;
    //color current = boxesColor[mouseX / boxSize][mouseY / boxSize];
    //if(current == onBoxColor) {
    //  boxesColor[mouseX / boxSize][mouseY / boxSize] = offBoxColor;
    //}
    //else if (current == offBoxColor) {
    //  boxesColor[mouseX / boxSize][mouseY / boxSize] = onBoxColor;
    //}
  } else if (mouseButton == LEFT) {
    if(boxesCurrentState[CurrentViewMinX+(mouseX / boxSize)][CurrentViewMinY+(mouseY / boxSize)] == 0) {
      boxesCurrentState[CurrentViewMinX+(mouseX / boxSize)][CurrentViewMinY+(mouseY / boxSize)] = 1;
    }
    else {
      boxesCurrentState[CurrentViewMinX+(mouseX / boxSize)][CurrentViewMinY+(mouseY / boxSize)] = 0;
    }
    boxesChanged[CurrentViewMinX+(mouseX / boxSize)][CurrentViewMinY+(mouseY / boxSize)] = 1;
  }
}


void mouseReleased()  {
  if (mouseButton == RIGHT) {
    endX = mouseX;
    endY = mouseY;
    
    int translateX = (endX-startX)/boxSize;
    TranslateBoxesX(translateX);
   
    
    for (int i = 0; i< BoxCountX; i++) {
      for (int j = 0; j < BoxCountY; j++) {
        boxesCurrentState[i][j] = boxesNextState[i][j];
      
      }
    }
    
    int translateY = (endY-startY)/boxSize;
    TranslateBoxesY(translateY);
    
    for (int i = 0; i< BoxCountX; i++) {
      for (int j = 0; j < BoxCountY; j++) {
        boxesCurrentState[i][j] = boxesNextState[i][j];
      
      }
    }
  }
}

void mouseDragged()  {
  if (mouseButton == LEFT) {
    boxesCurrentState[CurrentViewMinX+(mouseX / boxSize)][CurrentViewMinY+(mouseY / boxSize)] = 1;
    boxesChanged[CurrentViewMinX+(mouseX / boxSize)][CurrentViewMinY+(mouseY / boxSize)] = 1;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println(e);
  float r = 1;
  if(e < 0) {
    if(boxSize == 64) {
     return; 
    }
   //zoom in 
   boxSize= boxSize*2;
  }
  else {
   // zoom out 
   if(boxSize == 2) {
     return; 
   }
   boxSize = boxSize/2;
  }
   // reset
   if(boxSize == 2) {
     CurrentViewMinX = 0;
     CurrentViewMaxX = BoxCountX;
      CurrentViewMinY = 0;
     CurrentViewMaxY = BoxCountY;
   }
   if(boxSize == 4) {
     CurrentViewMinX = 200;
     CurrentViewMaxX = 600;
     CurrentViewMinY = 112;
     CurrentViewMaxY = 225+112;
   }
   if(boxSize == 8) {
     CurrentViewMinX = 300;
     CurrentViewMaxX = 500;
     CurrentViewMinY = 112+56;
     CurrentViewMaxY = 225+112-56;
   }
   if(boxSize == 16) {
     CurrentViewMinX = 350;
     CurrentViewMaxX = 450;
     CurrentViewMinY = 112+56+28;
     CurrentViewMaxY = 225+112-56-28;
   }
    if(boxSize == 32) {
     CurrentViewMinX = 375;
     CurrentViewMaxX = 425;
     CurrentViewMinY = 112+56+28+14;
     CurrentViewMaxY = 225+112-56-28-14;
   }
   if(boxSize == 64) {
     CurrentViewMinX = 387;
     CurrentViewMaxX = 413;
     CurrentViewMinY = 112+56+28+14+7;
     CurrentViewMaxY = 225+112-56-28-14-7;
   }
   
   // marke everything redraw
     for (int i = 0; i < BoxCountX; i++) { //<>//
    for (int j = 0; j < BoxCountY; j++) {
      boxesChanged[i][j] = 1;
    }
     }
}


void keyPressed() {
  if (key == BACKSPACE) {
    paused = !paused;

  //  for (int i = 0; i< boxes.length; i++) {
  //    for (int j = 0; j < boxes[i].length; j++) {
  //      boxes[i][j] = j;
  //      boxesColor[i][j] = offBoxColor;
  //    }
  //  }
  }
}
