import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;

PFont myFont;
PropertyEntry[] propertyArray;
SQLite db;
BarChart barChart;
Toolbar toolbar;

Screen mainScreen, graphScreen, currentScreen;

void settings() 
{
  size(SCREENX, SCREENY);
}
void setup() 
{
  color toolbarColor = color(150, 150, 150); 
  myFont = loadFont("Serif.plain-15.vlw");
  toolbar = new Toolbar(toolbarColor);
  barChart = new BarChart(this);
  db = new SQLite(this, "landdata.db");
  if (db.connect())
  {
    db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
  }
  while (db.next())
  {
    println( db.getString("Name") );
  }
  db.query( "SELECT * FROM test" );
  int maxValue=0;
  float [] temp = new float[NUMBER_OF_ENTRIES];
  for (int i=0; i<NUMBER_OF_ENTRIES; i++)
  {
    if (db.next()) {
      temp[i] = parseFloat(db.getString("price"));
      if(temp[i]>maxValue) 
      {
        maxValue = int(temp[i]);
      }
    }
  }
  barChart.setBarColour(color(200,80,80,150));
  barChart.setData(temp);
  
  mainScreen = new Screen(255);
  graphScreen = new Screen(255);
  
  BarChart barChart = new BarChart(this);
  barChart.setData(temp);
  
  graphScreen.addBarChart(barChart);
  barChart.setMinValue(0);
  barChart.setMaxValue(maxValue);
  barChart.showValueAxis(true);
  barChart.setBarColour(color(200,0,200));
  color widgetColor = color(200, 50, 50);
  
  graphScreen.addText( SCREENX / 2 - 50, SCREENY - 90, "Prices over time");
  
  mainScreen.addWidget(SCREENX / 2 - 50, SCREENY / 2 - 15, 100, 30, "Graph", widgetColor, myFont, EVENT_GRAPH_BUTTON);
  
  currentScreen = mainScreen;
}

void draw() 
{
  background(255);
  currentScreen.draw();
  toolbar.draw();
}

void mousePressed()
{
 switch(currentScreen.getEvent())
  {
  case EVENT_GRAPH_BUTTON:
    currentScreen = graphScreen;
    break;
  }
  switch(toolbar.getEvent())
  {
   case EVENT_BACK_BUTTON:  
     currentScreen = mainScreen;
  }
}