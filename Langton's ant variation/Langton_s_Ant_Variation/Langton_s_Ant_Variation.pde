
final int X = 200;
final int Y= 140;
final int boxSize = 8;

final color selectedBoxColor = color(255);
final color boxColor = color(50);

boolean paused = false;

int time;
int updateTimeInterwal = 20;

int [][] boxes = new int [X][Y];
color [][] boxesColor = new color [X][Y];

class Ant {
  int x_pos;
  int y_pos;

  int x_direction = 0;
  int y_direction = -1;

  Ant(int _x, int _y) {
    x_pos = _x;
    y_pos = _y;
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
    } //<>//

    // determine which way to turn, change cox color
    color current = boxesColor[x_pos][y_pos];

    if (current == boxColor) {
      boxesColor[x_pos][y_pos] = selectedBoxColor; //<>//
      TurnClockwise();
    } else if (current == selectedBoxColor) {
      boxesColor[x_pos][y_pos] = boxColor;
      TurnCounterClockwise();
    }
    // apply turn
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

      fill(boxesColor[i][j]);
      stroke(0);
      rect (x, y, boxSize, boxSize);
    }
  }
  if (!paused) {
    // see if we want to move the ants along
    if (millis()-updateTimeInterwal > time) {
      time = millis();
      for (Ant ant : ants) {
        ant.AdvanceATurn();
      }
    }
  }
}

void mousePressed() {
if (mouseButton == LEFT) {
  Ant newAnt = new Ant(mouseX / boxSize, mouseY / boxSize);
  ants.add(newAnt);
  boxesColor[mouseX / boxSize][mouseY / boxSize] = selectedBoxColor;
}
else if (mouseButton == RIGHT) {
  paused = !paused;
}
}
