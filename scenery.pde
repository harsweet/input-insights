// Setting up the window Sizes as variables
int windowWidth = 1000;
int windowHeight = 700;

// Setting up the sizes for various categories of areas
float starHeight = (windowHeight / 10) * 2.3; 
float cloudHeight = (windowHeight / 10) * 1.7;
float rainHeight = (windowHeight / 10) * 6;

color color1, color2, color3; // Declare color variables

void settings() {
  size(windowWidth, windowHeight);
}

void setup(){
  // Define colors for the rectangles
  color1 = color(255, 0, 0);       // Red
  color2 = color(0, 255, 0);       // Green
  color3 = color(0, 0, 255);       // Blue
  
  
  // Filling in the different areas with different colors
  fill(color1);
  rect(0, 0, windowWidth, starHeight);
  fill(color2);
  rect(0, starHeight, windowWidth, cloudHeight);
  fill(color3);
  rect(0, starHeight + cloudHeight, windowWidth, rainHeight);

}
