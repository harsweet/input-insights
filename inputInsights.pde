// Setting up the window Sizes as variables
int windowWidth = 1000;
int windowHeight = 700;

PShape star;
int mouseClickStart, mouseClickEnd;


void settings() {
  size(windowWidth, windowHeight);
}


void setup(){
  // Setting up the background color
  background(255);

  // Loading the shape
  // star svg from https://iconmonstr.com/star-3-svg/
  star = loadShape("star.svg");
  star.disableStyle();
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


// Now 