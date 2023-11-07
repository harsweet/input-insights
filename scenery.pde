// Setting up the window Sizes as variables
int windowWidth = 1000;
int windowHeight = 700;

// Setting up the sizes for various categories of areas
float starHeight = (windowHeight / 10) * 2.3; 
float cloudHeight = (windowHeight / 10) * 1.7;
float rainHeight = (windowHeight / 10) * 6;

float starStartY = 0;
float starEndY = starHeight;

float cloudStartY = starHeight;
float cloudEndY = starHeight + cloudHeight;

float rainStartY = starHeight + cloudHeight;
float rainEndY = windowHeight;

color color1, color2, color3; // Declare color variables

PShape cloud;

void settings() {
  size(windowWidth, windowHeight);
}

void setup(){
  // Define colors for the rectangles
  color1 = color(255, 0, 0);       // Red
  color2 = color(0, 255, 0);       // Green
  color3 = color(0, 0, 255);       // Blue
  
  
  cloud = loadShape("cloud.svg");
  
  // Filling in the different areas with different colors
  //fill(color1);
  //rect(0, 0, windowWidth, starHeight);
  //fill(color2);
  shape(cloud, 0, cloudStartY, 200, cloudHeight);
  shape(cloud, 175, cloudStartY, 200, cloudHeight);
  //rect(0, starHeight, windowWidth, cloudHeight);
  //fill(color3);
  //rect(0, starHeight + cloudHeight, windowWidth, rainHeight);

}
