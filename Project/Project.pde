import interfascia.*;
import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;

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
public Screen homeScreen, townSelectScreen, countySelectScreen,
regionSelectScreen, optionScreen, currentScreen, contactScreen, graphScreen,
top10Screen, bot10Screen, avgScreen, statScreen;

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
  //createGraphScreen();

  homeScreen = new Screen(homeBG);
  contactScreen = new Screen(PROCESS_YELLOW);
  townSelectScreen = new Screen(BEIGE);
  countySelectScreen = new Screen(LIGHT_GREEN);
  regionSelectScreen = new Screen(PIGGY_PINK);
  optionScreen = new Screen(BABY_BLUE);
  top10Screen = new Screen(BLACK);
  bot10Screen = new Screen(150);
  avgScreen = new Screen(150);
  statScreen = new Screen(150);
  
  
  
  
  
  
  // HOME SCREEN
  
  homeScreen.addWidget(0, SCREENY / 2 - 200, SCREENX/4, 62, "Town", WOOD_BROWN, myFont, EVENT_TOWN_BUTTON);
  homeScreen.addWidget(SCREENX / 4, SCREENY / 2 - 200, SCREENX/4, 62, "County", SHAMROCK_GREEN, myFont, EVENT_COUNTY_BUTTON);
  homeScreen.addWidget(SCREENX/2, SCREENY / 2 - 200, SCREENX/4, 62, "Region", AMERICAN_RED, myFont, EVENT_REGION_BUTTON);
  homeScreen.addWidget(SCREENX-SCREENX/4, SCREENY / 2 - 200, SCREENX/4, 62, "Whole U.K.", UNION_JACK_BLUE, myFont, EVENT_UK_BUTTON); 

  // TOWN SELECT SCREEN
  
  //if(currentScreen==townSelectScreen)
  //{
    townSelectScreen.addIFTextField("Search", SCREENX/2-180, SCREENY/2, 360, 40);
  //}
  
  
  // OPTION SCREEN
  optionScreen.addWidget(0, SCREENY / 2 - 200, SCREENX/4, 62, "Top 10", ATOMIC_TANGERINE, myFont, EVENT_TOP10_BUTTON);
  optionScreen.addWidget(SCREENX / 4, SCREENY / 2 - 200, SCREENX/4, 62, "Bottom 10", RASPBERRY_RED, myFont, EVENT_BOT10_BUTTON);
  optionScreen.addWidget(SCREENX/2, SCREENY / 2 - 200, SCREENX/4, 62, "Average Over Time", LIBERTY_BLUE, myFont, EVENT_AVG_BUTTON);
  optionScreen.addWidget(SCREENX-SCREENX/4, SCREENY / 2 - 200, SCREENX/4, 62, "Statistical Analysis", MALACHITE, myFont, EVENT_STAT_BUTTON); 
  
  
  
  currentScreen = homeScreen;
  backList.add(currentScreen);

  db = new SQLite( this, "landdata.db" );  

  int numberToReturn=10;
  String search = "CARDIFF";
  String type = "All";
  testing = new Query(search,type,db);
  testing.displayAverageOverTime();

}
//
void draw() 
{
  currentScreen.draw();
  toolbar.draw();
  if(testing!=null)
    testing.draw();
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
    currentScreen = optionScreen;
    backList.add(currentScreen);
    break;
  case EVENT_TOP10_BUTTON:
    currentScreen = top10Screen;
    backList.add(currentScreen);
    break;
  case EVENT_BOT10_BUTTON:
    currentScreen = bot10Screen;
    backList.add(currentScreen);
    break;
  case EVENT_AVG_BUTTON:
    currentScreen = avgScreen;
    backList.add(currentScreen);
    break;
  case EVENT_STAT_BUTTON:
    currentScreen = statScreen;
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

//<<<<<<< .mine
//=======

//>>>>>>> .r80
  //void createGraphScreen()
  //{
  //  graphScreen = new Screen(WIDGET_RED);
  //  barChart = new BarChart(this);
  //<<<<<<< .mine
  //void createGraphScreen()
  //{
  //  graphScreen = new Screen(WIDGET_RED);
  //  //barChart = new BarChart(this);
  //=======
  void createGraphScreen()
  {
    graphScreen = new Screen(WIDGET_RED);
    //barChart = new BarChart(this);
  //>>>>>>> .r80
  
  ////  /*
  
  ////   barChart.setBarColour(color(200, 80, 80, 150));
  ////   barChart.setData(temp);
     
  ////   graphScreen = new Screen(255);
     
  //   BarChart barChart = new BarChart(this);
  //   barChart.setData(temp);
     
  //   graphScreen.addBarChart(barChart);
  //   barChart.setMinValue(0);
  //   barChart.setMaxValue(maxValue);
  //   barChart.showValueAxis(true);
  //   barChart.setBarColour(color(200, 0, 200));
     
  //   graphScreen.addText( SCREENX / 2 - 50, SCREENY - 90, "Prices over time");
  //
  }