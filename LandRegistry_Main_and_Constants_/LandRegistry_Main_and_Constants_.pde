
PFont myFont;
String[] lines;
PropertyEntry[] propertyArray;
void settings() {
  size(SCREENX, SCREENY);
}
void setup() {
  propertyArray = new PropertyEntry[1000];
  myFont = loadFont("Serif.plain-15.vlw");
  lines = loadStrings("pp-1k.csv");

  for (int i = 0; i < lines.length; i++) {
    String [] s = lines.split("\\s*,\\s*");
    propertyArray[i] = new PropertyEntry(String lines[0], String lines[0], String lines[0], String lines[0], 
      String lines[0], String lines[0], String lines[0], String lines[0], 
      String lines[0], String lines[0], String lines[0] );
  }
}

void draw() {
}