// Setting up the window Sizes as variables
int windowWidth = 1000;
int windowHeight = 700;

PShape star;
PShape drop;
PShape snowflake;
PShape keyShape;
PShape cross;

int mouseClickStart, mouseClickEnd;
int keyPressStart, keyPressEnd;
boolean keyPressRecord = true;


// For keeping track of info about the letters typed
ArrayList<LetterInfo> letterInfoList;


void settings() {
  size(windowWidth, windowHeight);
}


void setup(){
  // Setting up the background color
  background(70, 70, 70);

  // Initializing the list
  letterInfoList = new ArrayList<>();

  // Loading the shapes
  // star svg from https://iconmonstr.com/star-3-svg/
  star = loadShape("svgs/star.svg");

  // drop svg from https://iconmonstr.com/drop-1-svg/
  drop = loadShape("svgs/drop.svg");

  // snowflake svg from https://svgsilh.com/image/38114.html
  snowflake = loadShape("svgs/snowflake.svg");

  // key svg from https://www.svgrepo.com/svg/4326/house-key
  keyShape = loadShape("svgs/key.svg");

  // cross svg from https://www.svgrepo.com/svg/178323/cross-close
  cross = loadShape("svgs/cross.svg");

  // Disabling styling so that we can apply our own styling
  star.disableStyle();
  drop.disableStyle();
  snowflake.disableStyle();
  keyShape.disableStyle();
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

  if (keyChar == '\b' || keyChar == '\u007F') {
    int listSize = letterInfoList.size();

    if(listSize != 0) {
      // This means they are one or more typed letters that haven't been erased

      LetterInfo lastLetterInfo = letterInfoList.get(listSize - 1);

      // Decolorizing the shape for that letter
      // To symbolize its deletion
      fill(255, 255, 255);
      shape(lastLetterInfo.shape, lastLetterInfo.xCoord, lastLetterInfo.yCoord, lastLetterInfo.sizeValue, lastLetterInfo.sizeValue);

      // Now removing it from the list as it has been deleted
      letterInfoList.remove(listSize - 1);
    }
  }
  else if(Character.isLetter(keyChar)) {
    drawDrop(keyChar, randX, randY, opacity);
  }
  else if(Character.isDigit(keyChar)) {
    drawSnowflake(keyChar, randX, randY, opacity);
  }
  else {
    drawKey(randX, randY, opacity);
  }
}


void drawDrop(char letter, int xCoord, int yCoord, float opacity) {
  char upChar = Character.toUpperCase(letter);

  // Now we have drops of green color for vowels
  // And drops of sky blue color for consonants
  if (upChar == 'A' || upChar == 'E' || upChar == 'I' || upChar == 'O' || upChar == 'U') {
    fill(0, 255, 64, opacity);
  }
  else {
    fill(135, 206, 235, opacity);
  }

  shape(drop, xCoord, yCoord, 20, 20);

  letterInfoList.add(new LetterInfo(drop, xCoord, yCoord, 20));
}


void drawSnowflake(char letter, int xCoord, int yCoord, float opacity) {
  int integerValue = Character.getNumericValue(letter);

  // The size of the svg is based upon the numerical value of the digit typed
  // 5.6 is the minimum size (when 0 is typed) and 20 is the maximum size (when 9 is typed)
  float svgSize = 5.6 + (1.6 * integerValue);

  // Choosing a grey color for the fill
  fill(105,105,105, opacity);

  shape(snowflake, xCoord, yCoord, svgSize, svgSize);

  letterInfoList.add(new LetterInfo(snowflake, xCoord, yCoord, svgSize));
}


void drawKey(int xCoord, int yCoord, float opacity) {
  // Choosing a black color for the fill
  fill(0, 0, 0, opacity);

  shape(keyShape, xCoord, yCoord, 20, 20);

  letterInfoList.add(new LetterInfo(keyShape, xCoord, yCoord, 20));
}


class LetterInfo {
  PShape shape;
  float xCoord;
  float yCoord;
  float sizeValue;

  public LetterInfo(PShape s, float x, float y, float size) {
    this.shape = s;
    this.xCoord = x;
    this.yCoord = y;
    this.sizeValue = size;
  }
}