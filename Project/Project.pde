import interfascia.*;
import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;

ArrayList backList;


public GUIController c;

PFont myFont;
PFont baskerville;
PropertyEntry[] propertyArray;
SQLite db;
BarChart barChart;
Toolbar toolbar;
PImage homeBG;

public boolean dropped = false;
public Screen homeScreen, townSelectScreen, countySelectScreen, regionSelectScreen, optionScreen, currentScreen, contactScreen, graphScreen;

void settings() 
{
  size(SCREENX, SCREENY);
}
void setup() 
{ 
  c = new GUIController(this);
  backList = new ArrayList();
  color toolbarColor = color(150, 150, 150); 
  myFont = loadFont("Serif.plain-15.vlw");
  baskerville = loadFont("Baskerville-Bold-48.vlw");
  toolbar = new Toolbar(toolbarColor, loadImage("backArrow.png"), loadImage("menu.png"), loadImage("homeButton.png"));
  homeBG = loadImage("background1.png");
  homeBG.resize(SCREENX,SCREENY);
  createGraphScreen();

  homeScreen = new Screen(homeBG);
  contactScreen = new Screen(PROCESS_YELLOW);
  townSelectScreen = new Screen(BEIGE);
  countySelectScreen = new Screen(LIGHT_GREEN);
  regionSelectScreen = new Screen(RASPBERRY_RED);
  optionScreen = new Screen(UNION_JACK_BLUE);
  
  
  
  
  
  
  // HOME SCREEN
  
  homeScreen.addWidget(0, SCREENY / 2 - 200, SCREENX/4, 62, "Town", WOOD_BROWN, myFont, EVENT_TOWN_BUTTON);
  homeScreen.addWidget(SCREENX / 4, SCREENY / 2 - 200, SCREENX/4, 62, "County", SHAMROCK_GREEN, myFont, EVENT_COUNTY_BUTTON);
  homeScreen.addWidget(SCREENX/2, SCREENY / 2 - 200, SCREENX/4, 62, "Region", AMERICAN_RED, myFont, EVENT_REGION_BUTTON);
  homeScreen.addWidget(SCREENX-SCREENX/4, SCREENY / 2 - 200, SCREENX/4, 62, "Whole U.K.", UNION_JACK_BLUE, myFont, EVENT_UK_BUTTON); 

  // TOWN SELECT SCREEN
  
  //if(currentScreen==townSelectScreen)
  //{
    townSelectScreen.addIFTextField("Search", SCREENX/2, SCREENY/2);
  //}
  
  currentScreen = homeScreen;
  backList.add(currentScreen);

  db = new SQLite(this, "landdata.db");
  if (db.connect())
  {
    db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
  }
  while (db.next())
  {
    println( db.getString("Name") );
  }

  int numberToReturn=10;
  String search = "TYNE AND WEAR";
  String type = "County";
  //db.query( "SELECT * FROM registry WHERE "+type+" = '"+search+"' ORDER BY Price DESC LIMIT "+numberToReturn );
  //float [] temp = new float[numberToReturn];
  //for (int i=0; i<numberToReturn; i++)
  //{
  //  if (db.next()) {
  //    temp[i] = parseFloat(db.getInt("Price"));
  //    println(temp[i]);
  //  } else 
  //  println("not working");
  //}
  //int[] average = new int[20];
  //for (int i=0; i<20; i++) {
  //  db.query("SELECT AVG(Price) From registry WHERE "+type+" = '"+search+"' AND Date>='"+(1995+i)+"-01-01' and Date< '"+(1996+i)+"-01-01'");
  //  if (db.next()) {
  //    average[i] = db.getInt(1);
  //    println(average[i]+" "+(1995+i));
  //  }
  //}
  //float min =0;
  //db.query("SELECT MIN(Price) From registry WHERE "+type+" = '"+search+"'");
  //if (db.next())
  //  min = db.getInt(1);
  //println(min);
  //float max =0;
  //db.query("SELECT MAX(Price) From registry WHERE "+type+" = '"+search+"'");
  //if (db.next())
  //  max = db.getInt(1);
  //println(max);
  
}
//
void draw() 
{
  currentScreen.draw();
  toolbar.draw();
}

void mousePressed()
{
  switch(currentScreen.getEvent())
  {
  case EVENT_TOWN_BUTTON:
  case EVENT_QUERY1:
    currentScreen = townSelectScreen;
    backList.add(currentScreen);
    break;
  case EVENT_COUNTY_BUTTON:
    currentScreen = countySelectScreen;
    backList.add(currentScreen);
    break;
  case EVENT_REGION_BUTTON:
    currentScreen = regionSelectScreen;
    backList.add(currentScreen);
    break;
  case EVENT_UK_BUTTON:
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
    }
    break;
  case EVENT_HOME_BUTTON:
    currentScreen = homeScreen;
    backList.add(currentScreen);
    break;
  }
}

void mouseMoved()
{
  toolbar.mouseMoved();
}

void createGraphScreen()
{
  graphScreen = new Screen(WIDGET_RED);
  barChart = new BarChart(this);

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