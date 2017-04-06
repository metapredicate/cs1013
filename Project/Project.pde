import interfascia.*;
import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;
import org.gicentre.geomap.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

AudioPlayer gstq;
Minim minim;

public PApplet main = this;
ArrayList backList;
Query testing;

PFont myFont;
PFont baskerville;
PropertyEntry[] propertyArray;
SQLite db;
BarChart barChart;
Toolbar toolbar;
PImage homeBG, countyBG, townBG, aboutUsBG;

public boolean dropped = false;
public Screen homeScreen, townQueryScreen, townSelectScreen, countySelectScreen, regionSelectScreen, optionScreen, currentScreen, contactScreen, graphScreen, aboutUsScreen;
public Query currentQuery, defaultQuery, top10Query, bot10Query, averageQuery, statQuery;
public String search, type;
 //<>//
 //<>//

// CAUTION WITH GLOBAL VARIABLE: IS ONLY WAY POSSIBLE TO HAVE SEARCHBAR APPEAR AND DISAPPEAR
public boolean searchbarIsDisplayed = false;
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

void settings() 
{
  size(SCREENX, SCREENY);
}

void loadingScreen()
{ //<>//
 background(0); //<>// //<>//
 textSize(50); //<>//
 text("loading...", 10, SCREENY - 30);
}

void setup() 
{ 
  minim = new Minim(this);
  loadingScreen();
  db = new SQLite( this, "landdata.db" );  
  backList = new ArrayList();
  color toolbarColor = color(150, 150, 150); 
  myFont = loadFont("Serif.plain-15.vlw");
  baskerville = loadFont("Baskerville-Bold-48.vlw");
  toolbar = new Toolbar(toolbarColor, loadImage("backArrow.png"), loadImage("menu.png"), loadImage("homeButton.png"));
  homeBG = loadImage("homebackground.png");
  homeBG.resize(SCREENX, SCREENY);
  townBG = loadImage("townSelectBackground.png");
  townBG.resize(SCREENX, SCREENY);
  countyBG = loadImage("UnionFlag.png");
  countyBG.resize(SCREENX, SCREENY);
  //aboutUsBG = loadImage("AboutUs.png");
 // aboutUsBG.resize(SCREENX,SCREENY);
  gstq = minim.loadFile("gstq.mp3", 2048);
  search = "MIDDLESBROUGH";
  type = "Town";


  homeScreen = new Screen(homeBG);
  contactScreen = new Screen(PROCESS_YELLOW);
  townSelectScreen = new Screen(townBG);
  countySelectScreen = new Screen(this, countyBG);
  regionSelectScreen = new Screen(RASPBERRY_RED);
  optionScreen = new Screen(BABY_BLUE);
  townQueryScreen = new Screen(PIGGY_PINK);
  aboutUsScreen = new Screen(aboutUsBG);
  this.defaultQuery = new Query(search, type);
  currentQuery = defaultQuery;


  // HOME SCREEN
  // let home widget drop = 200;
  homeScreen.addWidget(0, SCREENY / 2 - HOME_WIDGET_DROP, SCREENX/4, 62, 
  "Town", WOOD_BROWN, myFont, EVENT_TOWN_BUTTON);
  homeScreen.addWidget(SCREENX / 4, SCREENY / 2 - HOME_WIDGET_DROP, SCREENX/4, 62, "County", SHAMROCK_GREEN, myFont, EVENT_COUNTY_BUTTON);
  homeScreen.addWidget(SCREENX/2, SCREENY / 2 - HOME_WIDGET_DROP, SCREENX/4, 62, "Region", AMERICAN_RED, myFont, EVENT_REGION_BUTTON);
  homeScreen.addWidget(SCREENX-SCREENX/4, SCREENY / 2 - HOME_WIDGET_DROP, SCREENX/4, 62, "Whole U.K.", UNION_JACK_BLUE, myFont, EVENT_UK_BUTTON); 

  // TOWN SELECT SCREEN
  townQueryScreen.addWidget(0, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Highest Priced", WOOD_BROWN, myFont, EVENT_TOP10_BUTTON);
  townQueryScreen.addWidget(SCREENX / 4, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Lowest Priced", WOOD_BROWN, myFont, EVENT_BOT10_BUTTON);
  townQueryScreen.addWidget(SCREENX / 2, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Average Prices Over Time", AMERICAN_RED, myFont, EVENT_AVG_BUTTON);
  townQueryScreen.addWidget(SCREENX * 3 / 4, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Area Statistics", AMERICAN_RED, myFont, EVENT_STAT_BUTTON);
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
  if( (currentScreen != townSelectScreen) && searchbarIsDisplayed )
   {
     searchbarIsDisplayed = false;
     townSelectScreen.hideSearchBar();
   }
  if (currentScreen == townQueryScreen)
  {
    currentQuery.draw();
    textSize(24);
    fill(0);
    text("Viewing results for " + search + " " + type, 10, 60);
  }
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
    townSelectScreen.showSearchBar();
    searchbarIsDisplayed = true;
    backList.add(currentScreen);
    break;
  case EVENT_APRES_TOWN_BUTTON:
    currentScreen = townQueryScreen;
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
    currentQuery = new Query(search, type);
    currentScreen = townQueryScreen;
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
  case EVENT_QUERY1:
    currentScreen = aboutUsScreen;
    backList.add(currentScreen);
    break;
  case EVENT_QUERY3:
    gstq.play();
    break;
  }
}

void mouseMoved()
{
  toolbar.mouseMoved();
}