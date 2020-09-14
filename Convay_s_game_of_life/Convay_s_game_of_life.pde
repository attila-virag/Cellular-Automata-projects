final int X = 200;
final int Y = 140;
final int boxSize = 8;

final color onBoxColor = color(255);
final color offBoxColor = color(50);
//final color dyingBoxColor = color(0,0,255);

boolean paused = false;

int [][] boxes = new int [X][Y];
color [][] boxesColor = new color [X][Y];
color [][] nextColors = new color [X][Y];

void MakeB_Heptaplet(int x, int y) {
  boxesColor[x][y+2] = onBoxColor;
  
  boxesColor[x+1][y] = onBoxColor;
  boxesColor[x+1][y+1] = onBoxColor;
  
  boxesColor[x+2][y] = onBoxColor;
  
  boxesColor[x+3][y] = onBoxColor;
  
  boxesColor[x+4][y+1] = onBoxColor;
}

void MakeLightSpaceship(int x, int y) {
  boxesColor[x][y+1] = onBoxColor;
  
  boxesColor[x+1][y] = onBoxColor;
  
  boxesColor[x+2][y] = onBoxColor;
  boxesColor[x+2][y+4] = onBoxColor;
  
  boxesColor[x+3][y] = onBoxColor;
  boxesColor[x+3][y+1] = onBoxColor;
  boxesColor[x+3][y+2] = onBoxColor;
  boxesColor[x+3][y+3] = onBoxColor;
}

void MakePuffer2(int x, int y) {
  MakeLightSpaceship(x, y);
  MakeLightSpaceship(x+14, y);
  
  MakeB_Heptaplet(x+7, y+2);
}

void MakeMissle(int x, int y) {
  boxesColor[x][y] = onBoxColor;
  boxesColor[x][y+1] = onBoxColor;
  
  boxesColor[x+1][y] = onBoxColor; 
  boxesColor[x+1][y+2] = onBoxColor;
  
  boxesColor[x+2][y] = onBoxColor;
}

void MakeSpaceship(int x, int y) {
  boxesColor[x][y+2] = onBoxColor;
  boxesColor[x][y+3] = onBoxColor;
  
  boxesColor[x+1][y+1] = onBoxColor;
  boxesColor[x+1][y+3] = onBoxColor;
  
  boxesColor[x+2][y] = onBoxColor;
  boxesColor[x+2][y+1] = onBoxColor;
  boxesColor[x+2][y+2] = onBoxColor;
  boxesColor[x+2][y+5] = onBoxColor;
  boxesColor[x+2][y+8] = onBoxColor;
  
  boxesColor[x+3][y] = onBoxColor;
  boxesColor[x+3][y+1] = onBoxColor;
  boxesColor[x+3][y+2] = onBoxColor;
  boxesColor[x+3][y+5] = onBoxColor;
  boxesColor[x+3][y+9] = onBoxColor;
  
  boxesColor[x+4][y] = onBoxColor;
  boxesColor[x+4][y+1] = onBoxColor;
  boxesColor[x+4][y+2] = onBoxColor;
  boxesColor[x+4][y+9] = onBoxColor;
  
  boxesColor[x+5][y] = onBoxColor; //<>//
  boxesColor[x+5][y+1] = onBoxColor;
  boxesColor[x+5][y+3] = onBoxColor;
  boxesColor[x+5][y+6] = onBoxColor;
  boxesColor[x+5][y+9] = onBoxColor;
  
  boxesColor[x+6][y+1] = onBoxColor; //<>//
  boxesColor[x+6][y+2] = onBoxColor;
  boxesColor[x+6][y+3] = onBoxColor;
  boxesColor[x+6][y+7] = onBoxColor;
  boxesColor[x+6][y+8] = onBoxColor;
  boxesColor[x+6][y+9] = onBoxColor;
  
  boxesColor[x+7][y+2] = onBoxColor;
}

void MakeGliderGun(int x, int y) {
  boxesColor[x][y+5] = onBoxColor;
  boxesColor[x][y+6] = onBoxColor;
  boxesColor[x+1][y+5] = onBoxColor;
  boxesColor[x+1][y+6] = onBoxColor;
  
  boxesColor[x+10][y+5] = onBoxColor;
  boxesColor[x+10][y+6] = onBoxColor;
  boxesColor[x+10][y+7] = onBoxColor;
  
  boxesColor[x+11][y+4] = onBoxColor;
  boxesColor[x+11][y+8] = onBoxColor;
  
  boxesColor[x+12][y+3] = onBoxColor;
  boxesColor[x+12][y+9] = onBoxColor;
  
  boxesColor[x+13][y+3] = onBoxColor;
  boxesColor[x+13][y+9] = onBoxColor;
  
  boxesColor[x+14][y+6] = onBoxColor;
  
  boxesColor[x+15][y+4] = onBoxColor;
  boxesColor[x+15][y+8] = onBoxColor;
  
  boxesColor[x+16][y+5] = onBoxColor;
  boxesColor[x+16][y+6] = onBoxColor;
  boxesColor[x+16][y+7] = onBoxColor;
  
  boxesColor[x+17][y+6] = onBoxColor;
  
  boxesColor[x+20][y+3] = onBoxColor;
  boxesColor[x+20][y+4] = onBoxColor;
  boxesColor[x+20][y+5] = onBoxColor;
  
  boxesColor[x+21][y+3] = onBoxColor;
  boxesColor[x+21][y+4] = onBoxColor;
  boxesColor[x+21][y+5] = onBoxColor;
  
  boxesColor[x+22][y+2] = onBoxColor;
  boxesColor[x+22][y+6] = onBoxColor;

  boxesColor[x+24][y+1] = onBoxColor;
  boxesColor[x+24][y+2] = onBoxColor;
  boxesColor[x+24][y+6] = onBoxColor;
  boxesColor[x+24][y+7] = onBoxColor;
  
  boxesColor[x+34][y+3] = onBoxColor;
  boxesColor[x+34][y+4] = onBoxColor;
  boxesColor[x+35][y+3] = onBoxColor;
  boxesColor[x+35][y+4] = onBoxColor;
}

void settings() {
  //this should be here
  size(X * boxSize, Y * boxSize);
}

void setup() {
  for (int i = 0; i< boxes.length; i++) {
    for (int j = 0; j < boxes[i].length; j++) {
      boxes[i][j] = j;
      boxesColor[i][j] = offBoxColor;
      nextColors[i][j] = offBoxColor;
    }
  }
  //MakeGliderGun(10,10);
  //MakeGliderGun(10,50);
}



void UpdateBoxState(int i, int j) {

  color currentBoxColor = boxesColor[i][j];

  int neighborBoxesOn = 0;
  //int neighborBoxesOff = 0;

  int x_pos, y_pos;
  // check the surrounding 9 boxes, wrap around if needed
  for (int x = i-1; x <= i+1; x++) {
    // check for wrap around
    if (x < 0) {
      x_pos = X-1;
    } else if (x > X-1) {
      x_pos = 0;
    } else {
      x_pos = x;
    }
    for (int y = j-1; y <= j+1; y++) {
      // check for wrap around
      if (y < 0) {
        y_pos = Y-1;
      } else if (y > Y-1) {
        y_pos = 0;
      } else {
        y_pos = y;
      }

      if (x_pos == i && y_pos == j ) {
        continue;
      }

      // now we can check the state of box at x_pos,y_pos
      color current = boxesColor[x_pos][y_pos];

      if (current == onBoxColor) {
        neighborBoxesOn++;
      } else if (current == offBoxColor) {
        //neighborBoxesOff++;
      }
    }
  }

  if (currentBoxColor == onBoxColor) {
    // if it has 2 or three neighbors it stays on else goes off
    if (neighborBoxesOn > 1 && neighborBoxesOn < 4) {
      nextColors[i][j] = onBoxColor;
      return;
    }
    // else goes off
    nextColors[i][j] = offBoxColor;
    return;
  } else if (currentBoxColor == offBoxColor) {
    // it goes on if it has exactly 3 live neighbors
    if (neighborBoxesOn == 3) {
      nextColors[i][j] = onBoxColor;
      return;
    } else {
      nextColors[i][j] = offBoxColor;
    }
  }
}

void UpdateBoxes() {
  for (int i = 0; i< boxes.length; i++) {
    for (int j = 0; j < boxes[i].length; j++) {

      UpdateBoxState(i, j);
    }
  }
}

void draw() {
  for (int i = 0; i< boxes.length; i++) {
    for (int j = 0; j < boxes[i].length; j++) {
      int x = i * boxSize;
      int y = j * boxSize;

      fill(boxesColor[i][j]);
      stroke(0);
      rect (x, y, boxSize, boxSize);
    }
  }

  if (!paused) {
    UpdateBoxes();
    for (int i = 0; i< boxes.length; i++) {
      for (int j = 0; j < boxes[i].length; j++) {
        boxesColor[i][j] = nextColors[i][j];
      }
    }
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    boxesColor[mouseX / boxSize][mouseY / boxSize] = onBoxColor;
    //color current = boxesColor[mouseX / boxSize][mouseY / boxSize];
    //if(current == onBoxColor) {
    //  boxesColor[mouseX / boxSize][mouseY / boxSize] = offBoxColor;
    //}
    //else if (current == offBoxColor) {
    //  boxesColor[mouseX / boxSize][mouseY / boxSize] = onBoxColor;
    //}
  } else if (mouseButton == RIGHT) {
    paused = !paused;
  }
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    if(mouseX > 0 && mouseX < X*boxSize && mouseY > 0 && mouseY < Y*boxSize) {
    boxesColor[mouseX / boxSize][mouseY / boxSize] = onBoxColor;
    }
  }
}


void keyPressed() {
  if (key == BACKSPACE) {
    // restart

    for (int i = 0; i< boxes.length; i++) {
      for (int j = 0; j < boxes[i].length; j++) {
        boxes[i][j] = j;
        boxesColor[i][j] = offBoxColor;
      }
    }
  }
  if (key == ENTER) {
    if(mouseX > 0 && mouseX < X*boxSize-40 && mouseY > 0 && mouseY < Y*boxSize-40) {
      MakeGliderGun(mouseX / boxSize,mouseY / boxSize);
    }
  }
  if(key == 'a' || key == 'A') {
    MakeB_Heptaplet(mouseX / boxSize,mouseY / boxSize);
  }
  if(key == 's' || key == 'S') {
    MakeLightSpaceship(mouseX / boxSize,mouseY / boxSize);
  }
  if(key == 'p' || key == 'P') {
   MakePuffer2( mouseX / boxSize,mouseY / boxSize);
  }
  if(key == 'm' || key == 'M') {
   MakeMissle(mouseX / boxSize,mouseY / boxSize); 
  }
  if(key == 'w' || key == 'W') {
   MakeSpaceship(mouseX / boxSize,mouseY / boxSize); 
  }
}
