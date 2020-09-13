final int X = 180;
final int Y= 120;
final int boxSize = 10;

final color redBoxColor = color(180, 0, 0);
final color blueBoxColor = color(0, 0, 180);
final color boxColor = color(50);

boolean paused = false;

int colorExpiration = 400; // how many turns box keeps color without being visited
//int spawnCount = 100;
//int expirationCount = 30;
int [][]turnsSinceVisited = new int[X][Y];

int time;
int updateTimeInterwal = 1;

int [][] boxes = new int [X][Y];
color [][] boxesColor = new color [X][Y];

int colorChangeTreshhold = 20;

class Ant {
  int x_pos;
  int y_pos;

  color antColor;

  //int otherColorEncountered = 0;

  //int spawnCounter = 1; // if and passes over spawnCOunt same color boxes
  //int expirationCounter = 1; // if and touches a nin friendly tile

  int x_direction = 0;
  int y_direction = -1;

  Ant(int _x, int _y, color _antColor) {
    x_pos = _x;
    y_pos = _y;
    antColor = _antColor;
    DoRandomTurn();
  }
  Ant(int _x, int _y, color _antColor, int x_dir, int y_dir) {
    x_pos = _x;
    y_pos = _y;
    x_direction = x_dir;
    y_direction = y_dir;
    TurnAround();
    antColor = _antColor;
  }

  void DoRandomTurn() {
    float r = random(0, 1);
    if (r < 0.5) {
      TurnClockwise();
    } else {
      TurnCounterClockwise();
    }
  }

  void AdvanceATurn()
  {
    // move in the current direction we are facing
    x_pos = x_pos+x_direction;
    y_pos = y_pos+y_direction;

    // check if we left the screen and wrap around
    if (y_pos > Y-1) {
      y_pos = 0;
    } else if (y_pos < 0) {
      y_pos = Y-1;
    }

    if (x_pos > X-1) {
      x_pos = 0;
    } else if (x_pos < 0) {
      x_pos = X-1;
    }

    // check which color box we landed on
    color currentBox = boxesColor[x_pos][y_pos];

    // this box has been visited this trun
    turnsSinceVisited[x_pos][y_pos] = 0;

    // if box is off, turn it our color and turn clockwise
    if (currentBox == boxColor) {
      boxesColor[x_pos][y_pos] = antColor;
      //expirationCounter = expirationCounter+2;
      //DoRandomTurn();
      TurnClockwise();
      //TurnAround();
    }
    // if box has our color, keep the color, decrement one otherColorEncoutered count, turn counter
    else if (currentBox == antColor) {
      //spawnCounter++;
      //expirationCounter--;
      //if (spawnCounter == spawnCount) {
      //  spawnCounter = 0;
      //}
      //otherColorEncountered--; 
      //TurnCounterClockwise();
    }
    // if we encouter the other color, keep moving in same direction, increment other color counter, flop current color to neutral
    else if (currentBox != antColor) {
      //otherColorEncountered++;
      //expirationCounter = expirationCounter+3;
      boxesColor[x_pos][y_pos] = boxColor;
      //DoRandomTurn();
      TurnCounterClockwise();
    }

    // if the other color encountered counter is past threshold, the and will flip to the other side
    //if (otherColorEncountered > colorChangeTreshhold) {
    //  otherColorEncountered = 0;
    //  if (antColor == redBoxColor) {
    //    antColor = blueBoxColor;
    //  } else {
    //    antColor = redBoxColor;
    //  }
    //}
  }

  void TurnClockwise()
  {
    if (x_direction == 0 && y_direction == -1) {
      x_direction = 1;
      y_direction = 0;
    } else if (x_direction == 1 && y_direction == 0) {
      x_direction = 0;
      y_direction = 1;
    } else if (x_direction == 0 && y_direction == 1) {
      x_direction = -1;
      y_direction = 0;
    } else if (x_direction == -1 && y_direction == 0) {
      x_direction = 0;
      y_direction = -1;
    }
  }

  void TurnCounterClockwise()
  {
    if (x_direction == 0 && y_direction == -1) {
      x_direction = -1;
      y_direction = 0;
    } else if (x_direction == 1 && y_direction == 0) {
      x_direction = 0;
      y_direction = -1;
    } else if (x_direction == 0 && y_direction == 1) {
      x_direction = 1;
      y_direction = 0;
    } else if (x_direction == -1 && y_direction == 0) {
      x_direction = 0;
      y_direction = 1;
    }
  }

  void TurnAround() {
    if (x_direction == 0 && y_direction == -1) {
      x_direction = 0;
      y_direction = 1;
    } else if (x_direction == 1 && y_direction == 0) {
      x_direction = -1;
      y_direction = 0;
    } else if (x_direction == 0 && y_direction == 1) {
      x_direction = 0;
      y_direction = -1;
    } else if (x_direction == -1 && y_direction == 0) {
      x_direction =1;
      y_direction = 0;
    }
  }
}

// list of ants

ArrayList<Ant> ants = new ArrayList<Ant>();

void settings() {
  //this should be here
  size(X * boxSize, Y * boxSize);
}

void setup() {
  for (int i = 0; i< boxes.length; i++) {
    for (int j = 0; j < boxes[i].length; j++) {
      boxes[i][j] = j;
      boxesColor[i][j] = boxColor;
    }
  }
  time = millis();
}

void draw() {
  for (int i = 0; i< boxes.length; i++) {
    for (int j = 0; j < boxes[i].length; j++) {
      int x = i * boxSize;
      int y = j * boxSize;

      turnsSinceVisited[i][j]++;

      // if ant is on this, fill with different clor
      for (Ant ant : ants) {
        if (i == ant.x_pos && j == ant.y_pos) {
          if (ant.antColor == blueBoxColor) {
            fill(0, 0, 250);
          } else {
            fill(550, 0, 0);
          }

          break;
        } else {
          if (turnsSinceVisited[i][j] > colorExpiration) {
            boxesColor[i][j] = boxColor;
          }
          fill(boxesColor[i][j]);
        }
      }
      stroke(0);
      rect (x, y, boxSize, boxSize);
    }
  }
  if (!paused) {
    // see if we want to move the ants along
    //if (millis()-updateTimeInterwal > time) {
      time = millis();
      ArrayList<Ant> newAnts = new ArrayList<Ant>();
      for (Ant ant : ants) {
        ant.AdvanceATurn();

        //if (ant.spawnCounter == 0) {
        //  //Ant newAnt = new Ant(ant.x_pos, ant.y_pos, ant.antColor, ant.y_direction, ant.x_direction);
        //  Ant newAnt = new Ant(ant.x_pos, ant.y_pos, ant.antColor);
        //  newAnts.add(newAnt);
        //}

        //// show ant positions
        //if(ant.antColor == blueBoxColor) {
        //  boxesColor[ant.x_pos][ant.y_pos] = color(0, 0, 150);
        //}
        //else {
        //  boxesColor[ant.x_pos][ant.y_pos] = color(150, 0, 0);
        //}
      }
      // add new ants
      for (Ant newAnt : newAnts) {
        ants.add(newAnt);
      }

      //// remove spent ants
      //for (int i = ants.size()-1; i >= 0; i--) { 
      //  Ant ant = ants.get(i);
      //  if (ant.expirationCounter == expirationCount) {
      //    ants.remove(i);
      //  }
      //}
    //}
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    Ant newAnt = new Ant(mouseX / boxSize, mouseY / boxSize, blueBoxColor, -1,0);
    ants.add(newAnt);
    boxesColor[mouseX / boxSize][mouseY / boxSize] = blueBoxColor;
    newAnt = new Ant(mouseX / boxSize, mouseY / boxSize, redBoxColor,1,0);
    ants.add(newAnt);
    boxesColor[mouseX / boxSize][mouseY / boxSize] = redBoxColor;
  } else if (mouseButton == RIGHT) {
    //Ant newAnt = new Ant(mouseX / boxSize, mouseY / boxSize, redBoxColor);
    //ants.add(newAnt);
    //boxesColor[mouseX / boxSize][mouseY / boxSize] = redBoxColor;
    paused = !paused;
  }
}

void keyPressed() {
  if (key == BACKSPACE) {
    // restart

    ants.clear();

    for (int i = 0; i< boxes.length; i++) {
      for (int j = 0; j < boxes[i].length; j++) {
        boxes[i][j] = j;
        boxesColor[i][j] = boxColor;
      }
    }
    time = millis();
  }
}
