
PFont myFont;
String[] lines;
PropertyEntry[] propertyArray;
void settings() 
{
  size(SCREENX, SCREENY);
}
void setup() 
{
  propertyArray = new PropertyEntry[1000];
  myFont = loadFont("Serif.plain-15.vlw");
  lines = loadStrings("pp-1k.csv");

  for (int i = 0; i < lines.length; i++) 
  {
    String [] s = lines[i].split("\\s*,\\s*");
    propertyArray[i] = new PropertyEntry(s[0], s[1], s[2], s[3], 
       s[4], s[5], s[6], s[7], 
       s[8], s[9], s[10] );
  }
}

void draw() 
{
  textFont(myFont);
  text("" + propertyArray[100].getNumName() + propertyArray[100].getStreet());
}
