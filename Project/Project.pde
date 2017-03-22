import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;

ArrayList backList;

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
  backList = new ArrayList();
  color toolbarColor = color(150, 150, 150); 
  myFont = loadFont("Serif.plain-15.vlw");
  toolbar = new Toolbar(toolbarColor);

  createGraphScreen();

  mainScreen = new Screen(255);
  color widgetColor = color(200, 50, 50);

  mainScreen.addWidget(SCREENX / 2 - 50, SCREENY / 2 - 15, 100, 30, "Graph", widgetColor, myFont, EVENT_GRAPH_BUTTON);

  currentScreen = mainScreen;
  backList.add(currentScreen);
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
    backList.add(currentScreen);
    break;
  }
  switch(toolbar.getEvent())
  {
  case EVENT_BACK_BUTTON: 
    if (backList.size() != 1)
    {
      backList.remove(currentScreen);
      currentScreen = (Screen) backList.get(backList.size() - 1);
      break;
    }
  case EVENT_DROP:
    
  }
}

void createGraphScreen()
{
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
  //db.query( "SELECT * FROM registry" );
  //int maxValue=0;
  //float [] temp = new float[NUMBER_OF_ENTRIES];
  //for (int i=0; i<NUMBER_OF_ENTRIES; i++)
  //{
  //  if (db.next()) {
  //    temp[i] = parseFloat(db.getString("Price"));
  //    if (temp[i]>maxValue) 
  //    {
  //      maxValue = int(temp[i]);
  //    }
  //  }
  //}
  
  //db.query( "SELECT * FROM registry ORDER BY Price DESC LIMIT 10" );
  //int maxValue=0;
  //float [] temp = new float[10];
  //for (int i=0; i<10; i++)
  //{
  //  if (db.next()) {
  //    temp[i] = parseFloat(db.getInt("Price"));
  //    if (temp[i]>maxValue) 
  //    {
  //      maxValue = int(temp[i]);
  //    }
  //  }
  //}
  
  
  
  
  
  barChart.setBarColour(color(200, 80, 80, 150));
  barChart.setData(temp);

  graphScreen = new Screen(255);

  BarChart barChart = new BarChart(this);
  barChart.setData(temp);

  graphScreen.addBarChart(barChart);
  barChart.setMinValue(0);
  barChart.setMaxValue(maxValue);
  barChart.showValueAxis(true);
  barChart.setBarColour(color(200, 0, 200));

  graphScreen.addText( SCREENX / 2 - 50, SCREENY - 90, "Prices over time");
}