// Setting up the window Sizes as variables
int windowWidth = 1000;
int windowHeight = 700;

PShape star;
PShape drop;

int mouseClickStart, mouseClickEnd;
int keyPressStart, keyPressEnd;


void settings() {
  size(windowWidth, windowHeight);
}


void setup(){
  // Setting up the background color
  background(255);

  // Loading the shape
  // star svg from https://iconmonstr.com/star-3-svg/
  star = loadShape("star.svg");

  // drop svg from https://iconmonstr.com/drop-1-svg/
  drop = loadShape("drop.svg");

  star.disableStyle();
  drop.disableStyle();
}

void draw() {
  // Nothing happens in draw()
}


// Whenever a user clicks the mouse we start the timer
// Used in tracking the duration of the click
void mousePressed() {
  mouseClickStart = millis();
}


void mouseReleased() {
  mouseClickEnd = millis();
  int clickDuration = (mouseClickEnd - mouseClickStart);
  
  // Setting a lower so that the shape to be visible on every mouse click
  int finalSize = clickDuration/25 + 10;

  // Deciding on shape fill based on type of click
  // Golden fill for left click
  // Blue fill for right click
  // Black for anything else
  if (mouseButton == LEFT) {
    fill(255, 223, 0);
  } else if (mouseButton == RIGHT) {
    fill(0, 0, 255);
  } else {
    fill(0);
  }

  shape(star, mouseX-(finalSize/2), mouseY-(finalSize/2), finalSize, finalSize);
}


// Whenever a user presses a key we start the timer
// Used in tracking the duration of the keypress
void keyPressed() {
  keyPressStart = millis();
}


void keyReleased() {
  keyPressEnd = millis();
  int keyPressDuration = (keyPressEnd - keyPressStart);
  
  // Varying opacity based on duration of key press
  // Intensity values go from 0 to 255
  // We hit the max (255) when a key is pressed for 5 or more seconds
  float opacity = keyPressDuration/100.0 * 51.0;

  fill(0, 0, 0, opacity);

  int randX = (int)(Math.random() * (windowWidth - 20)) + 10;
  int randY = (int)(Math.random() * (windowHeight -20)) + 10;

  shape(drop, randX, randY, 20, 20);
}