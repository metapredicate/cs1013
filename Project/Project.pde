import interfascia.*;
import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;
import org.gicentre.geomap.*;

ArrayList backList;
Query testing;

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
public Query currentQuery, defaultQuery, top10Query, bot10Query, averageQuery, statQuery;
public String search, type;


void settings() 
{
  size(SCREENX, SCREENY);
}
void setup() 
{ 
  db = new SQLite( this, "landdata.db" );   //<>// //<>//
  c = new GUIController(this); //<>// //<>// //<>//
  backList = new ArrayList();
  color toolbarColor = color(150, 150, 150); 
  myFont = loadFont("Serif.plain-15.vlw");
  baskerville = loadFont("Baskerville-Bold-48.vlw");
  toolbar = new Toolbar(toolbarColor, loadImage("backArrow.png"), loadImage("menu.png"), loadImage("homeButton.png"));
  homeBG = loadImage("background1.png");
  homeBG.resize(SCREENX, SCREENY);
  //createGraphScreen();

  search = "MIDDLESBROUGH";
  type = "Town";


  homeScreen = new Screen(homeBG);
  contactScreen = new Screen(PROCESS_YELLOW);
  townSelectScreen = new Screen(BEIGE);
  countySelectScreen = new Screen(this);
  regionSelectScreen = new Screen(RASPBERRY_RED);
  optionScreen = new Screen(BABY_BLUE);

  //if(currentScreen == townSelectScreen)
  //{ 
  //}
  this.defaultQuery = new Query(search, type, db);
  currentQuery = defaultQuery;


  // HOME SCREEN

  homeScreen.addWidget(0, SCREENY / 2 - 200, SCREENX/4, 62, "Town", WOOD_BROWN, myFont, EVENT_TOWN_BUTTON);
  homeScreen.addWidget(SCREENX / 4, SCREENY / 2 - 200, SCREENX/4, 62, "County", SHAMROCK_GREEN, myFont, EVENT_COUNTY_BUTTON);
  homeScreen.addWidget(SCREENX/2, SCREENY / 2 - 200, SCREENX/4, 62, "Region", AMERICAN_RED, myFont, EVENT_REGION_BUTTON);
  homeScreen.addWidget(SCREENX-SCREENX/4, SCREENY / 2 - 200, SCREENX/4, 62, "Whole U.K.", UNION_JACK_BLUE, myFont, EVENT_UK_BUTTON); 

  // TOWN SELECT SCREEN

  //if(currentScreen==townSelectScreen)
  //{
  townSelectScreen.addIFTextField("Search", SCREENX/2-180, SCREENY - 100, 360, 40);
  townSelectScreen.addWidget(0, SCREENY / 2 - 300, SCREENX/4, 62, "Highest Priced", WOOD_BROWN, myFont, EVENT_TOP10_BUTTON);
  townSelectScreen.addWidget(SCREENX / 4, SCREENY / 2 - 300, SCREENX/4, 62, "Lowest Priced", WOOD_BROWN, myFont, EVENT_BOT10_BUTTON);
  townSelectScreen.addWidget(SCREENX / 2, SCREENY / 2 - 300, SCREENX/4, 62, "Average Prices Over Time", AMERICAN_RED, myFont, EVENT_AVG_BUTTON);
  townSelectScreen.addWidget(SCREENX * 3 / 4, SCREENY / 2 - 300, SCREENX/4, 62, "Area Statistics", AMERICAN_RED, myFont, EVENT_STAT_BUTTON);
  //}

  currentScreen = homeScreen;
  backList.add(currentScreen);
}

//
void draw() 
{
  currentScreen.draw();
  toolbar.draw();

  if (testing!=null)
    testing.draw();

  if (currentScreen == townSelectScreen)
    currentQuery.draw();
}

void mousePressed()
{
  if (currentScreen == countySelectScreen) {
    currentScreen.mousePressed();
  }
  switch(currentScreen.getEvent())
  {
  case EVENT_TOWN_BUTTON:
    currentScreen = townSelectScreen;
    backList.add(currentScreen);
    type = "Town";
    currentQuery.displayTop(10);
    break;
  case EVENT_COUNTY_BUTTON:
    currentScreen = countySelectScreen;
    backList.add(currentScreen);
    type = "County";
    break;
  case EVENT_REGION_BUTTON:
    currentScreen = regionSelectScreen;
    backList.add(currentScreen);
    break;
  case EVENT_UK_BUTTON:
    currentScreen = optionScreen;
    backList.add(currentScreen);
    type = "All";
    currentQuery = new Query(search, type, db);
    currentScreen = townSelectScreen;
    break;
  case EVENT_AVG_BUTTON:
    currentQuery.displayAverageOverTime();
    break;
  case EVENT_TOP10_BUTTON:
    currentQuery.displayTop(10);
    break;
  case EVENT_BOT10_BUTTON:
    currentQuery.displayBottom(10);
    break;
  case EVENT_STAT_BUTTON:
    currentQuery.displayStats();
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
    currentQuery = defaultQuery;
    break;
  }
}

void mouseMoved()
{
  toolbar.mouseMoved();
}