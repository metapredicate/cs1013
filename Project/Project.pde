import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;

ArrayList backList;

PFont myFont;
PFont baskerville;
PropertyEntry[] propertyArray;
SQLite db;
BarChart barChart;
Toolbar toolbar;

public boolean dropped = false;
public Screen homeScreen, graphScreen, currentScreen, contactScreen;

void settings() 
{
  size(SCREENX, SCREENY);
}
void setup() 
{ 
  
  backList = new ArrayList();
  color toolbarColor = color(150, 150, 150); 
  myFont = loadFont("Serif.plain-15.vlw");
  baskerville = loadFont("Baskerville-Bold-48.vlw");
  toolbar = new Toolbar(toolbarColor, loadImage("backArrow.png"), loadImage("menu.png"), loadImage("homeButton.png"));

  createGraphScreen();
  
  
  homeScreen = new Screen(BABY_BLUE);
  
  
  
  
  contactScreen = new Screen(PROCESS_YELLOW);
  contactScreen.addText(SCREENX/2, SCREENY/2, "Credits: ", 32, baskerville, 0);

  homeScreen.addWidget(SCREENX / 2 - 50, SCREENY / 2 - 15, 100, 30, "Graph", WIDGET_RED, myFont, EVENT_GRAPH_BUTTON);
  homeScreen.addWidget(SCREENX / 2 - 50, SCREENY / 2 - 45, 100, 30, "Contact Us!", PROCESS_YELLOW, myFont, EVENT_CONTACT_BUTTON);
  
  
  currentScreen = homeScreen;
  backList.add(currentScreen);
}

void draw() 
{
  currentScreen.draw();
  toolbar.draw();
}

void mousePressed()
{
  switch(currentScreen.getEvent())
  {
  case EVENT_GRAPH_BUTTON:
  case EVENT_QUERY1:
    currentScreen = graphScreen;
    backList.add(currentScreen);
    break;
  case EVENT_CONTACT_BUTTON:
    currentScreen = contactScreen;
    backList.add(currentScreen);
    break;
   case EVENT_HOME_BUTTON:
    currentScreen = homeScreen;
    backList.add(currentScreen);
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
  }
}

void mouseMoved()
{
  toolbar.mouseMoved();
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



/*

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
  */
}