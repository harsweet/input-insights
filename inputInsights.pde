// Setting up the window Sizes as variables
int windowWidth = 1000;
int windowHeight = 700;

PShape star;
PShape drop;

int mouseClickStart, mouseClickEnd;
int keyPressStart, keyPressEnd;
boolean keyPressRecord = true;


void settings() {
  size(windowWidth, windowHeight);
}


void setup(){
  // Setting up the background color
  background(255);

  // Loading the shape
  // star svg from https://iconmonstr.com/star-3-svg/
  star = loadShape("svgs/star.svg");

  // drop svg from https://iconmonstr.com/drop-1-svg/
  drop = loadShape("svgs/drop.svg");

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
// We also use the keyPressRecord flag to avoid re-recording the same key press
// Until it's released
void keyPressed() {
  if(keyPressRecord) {
    keyPressStart = millis();
    keyPressRecord = false;
  }
}


void keyReleased() {
  char keyChar = key;

  keyPressEnd = millis();
  keyPressRecord = true;

  int keyPressDuration = (keyPressEnd - keyPressStart);
  
  // Varying opacity based on duration of key press
  // Intensity values go from 0 to 255
  // We hit the max (255) when a key is pressed for 5 or more seconds
  float opacity = (keyPressDuration/100.0) * 51.0;

  // Selecting random coordinates for the shapes to appear
  int randX = (int)(Math.random() * (windowWidth - 20)) + 10;
  int randY = (int)(Math.random() * (windowHeight -20)) + 10;

  if(Character.isLetter(keyChar)){
    drawDrop(keyChar, randX, randY, opacity);
  }
}


void drawDrop(char letter, int xCoord, int yCoord, float opacity) {
  char upChar = Character.toUpperCase(letter);

  // Now we have drops of orange color for vowels
  // And drops of sky blue color for consonants
  if (upChar == 'A' || upChar == 'E' || upChar == 'I' || upChar == 'O' || upChar == 'U') {
    fill(135, 206, 235, opacity);
  }
  else {
    fill(255, 165, 0, opacity);
  }

  shape(drop, xCoord, yCoord, 20, 20);
}