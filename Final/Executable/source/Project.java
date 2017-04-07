import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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
import java.util.Scanner; 
import de.bezier.data.sql.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Project extends PApplet {

 //<>// //<>// //<>// //<>//










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


// CAUTION WITH GLOBAL VARIABLE: IS ONLY WAY POSSIBLE TO HAVE SEARCHBAR APPEAR AND DISAPPEAR
public boolean searchbarIsDisplayed = false;
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
public boolean districtSBisDisplayed = false;
public void settings() 
{
  size(SCREENX, SCREENY);
}

public void loadingScreen()
{
  background(0);
  textSize(50);
  text("loading...", 10, SCREENY - 30);
}

public void setup() 
{ 
  loadingScreen();
  minim = new Minim(this);
  db = new SQLite( this, "landdata.db" );  
  backList = new ArrayList();
  int toolbarColor = color(150, 150, 150); 
  myFont = loadFont("Serif.plain-15.vlw");
  baskerville = loadFont("Baskerville-Bold-48.vlw");
  toolbar = new Toolbar(toolbarColor, loadImage("backArrow.png"), loadImage("menu.png"), loadImage("homeButton.png"));
  homeBG = loadImage("homebackground.png");
  homeBG.resize(SCREENX, SCREENY);
  townBG = loadImage("townSelectBackground.png");
  townBG.resize(SCREENX, SCREENY);
  countyBG = loadImage("UnionFlag.png");
  countyBG.resize(SCREENX, SCREENY);
  aboutUsBG = loadImage("AboutUs.png");
  aboutUsBG.resize(SCREENX, SCREENY);
  gstq = minim.loadFile("gstq.mp3", 2048);
  search = "MIDDLESBROUGH";
  type = "Town";


  homeScreen = new Screen(homeBG);
  contactScreen = new Screen(PROCESS_YELLOW);
  townSelectScreen = new Screen(townBG);
  countySelectScreen = new Screen(this, countyBG);
  regionSelectScreen = new Screen(townBG);
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
  homeScreen.addWidget(SCREENX/2, SCREENY / 2 - HOME_WIDGET_DROP, SCREENX/4, 62, "District", AMERICAN_RED, myFont, EVENT_REGION_BUTTON);
  homeScreen.addWidget(SCREENX-SCREENX/4, SCREENY / 2 - HOME_WIDGET_DROP, SCREENX/4, 62, "Whole U.K.", UNION_JACK_BLUE, myFont, EVENT_UK_BUTTON); 

  // TOWN SELECT SCREEN
  townQueryScreen.addWidget(0, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Highest Priced", WOOD_BROWN, myFont, EVENT_TOP10_BUTTON);
  townQueryScreen.addWidget(SCREENX / 4, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Lowest Priced", WOOD_BROWN, myFont, EVENT_BOT10_BUTTON);
  townQueryScreen.addWidget(SCREENX / 2, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Average Prices Over Time", AMERICAN_RED, myFont, EVENT_AVG_BUTTON);
  townQueryScreen.addWidget(SCREENX * 3 / 4, SCREENY / 2 - QUERY_WIDGET_DROP, SCREENX/4, 62, "Area Statistics", AMERICAN_RED, myFont, EVENT_STAT_BUTTON);
  //}

  currentScreen = homeScreen;
  backList.add(currentScreen);

  Query test = new Query("94 , clough close");
  test.getPropertyEntry();
}

//
public void draw() 
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
   if( (currentScreen != regionSelectScreen) && districtSBisDisplayed )
   {
     districtSBisDisplayed = false;
     regionSelectScreen.hideSearchBar();
   }
  if (currentScreen == townQueryScreen)
  {
    currentQuery.draw();
    textSize(24);
    fill(0);
    if(type.equals("All"))
    {
      text("Viewing Results for the UK", 10, 60);
    } else
    {
      text("Viewing results for " + search + " " , 10, 60); 
    }
  }
}

public void mousePressed()
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
  case EVENT_SEARCH:
  
    if ( currentScreen == townSelectScreen )
    {
      String output = townSelectScreen.searchbar.getValue();
      type = "Town";
      search = output;
      currentQuery = new Query(search, type);
      currentScreen = townQueryScreen;
      
    }
    else if ( currentScreen == regionSelectScreen )
    {
      String output = regionSelectScreen.searchbar.getValue();
      currentScreen = townQueryScreen;
       type = "District";
      search = output;
      currentQuery = new Query(search, type);
      currentScreen = townQueryScreen;
    }
    else
  
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
    regionSelectScreen.showSearchBar();
    districtSBisDisplayed = true;
    break;
  case EVENT_UK_BUTTON:
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
    currentQuery.setChartToNull();
    currentQuery.displayHouseType();
    break;
  }
  switch(toolbar.getEvent())
  {
  case EVENT_BACK_BUTTON: 
    if (backList.size() != 1)
    {
      backList.remove(currentScreen);
      currentScreen = (Screen) backList.get(backList.size() - 1);
      if ( currentScreen == townSelectScreen)
      {
        townSelectScreen.showSearchBar();
        searchbarIsDisplayed = true;
      }
    }
    break;
  case EVENT_HOME_BUTTON:
    if (currentScreen == townSelectScreen)
    {
      searchbarIsDisplayed = false;
      townSelectScreen.hideSearchBar();
    }
    if ( currentScreen == regionSelectScreen)
    {
      districtSBisDisplayed = false;
      regionSelectScreen.hideSearchBar();
    }
    currentScreen = homeScreen;
    backList.add(currentScreen);
    currentQuery = defaultQuery;
    break;
  case EVENT_QUERY1:
    currentScreen = aboutUsScreen;
    backList.add(currentScreen);
    break;
  case EVENT_QUERY2:
    link("https://subversion.scss.tcd.ie/cs1013-1617-26/");
    break;
  case EVENT_QUERY3:
    gstq.play();
    break;
  }
}

public void mouseMoved()
{
  toolbar.mouseMoved();
}
class Bar extends Widget
{
  private float barValue;
  private String type, xValue;
  private int yForText;
  private boolean xValueDisplayed;

  Bar(int x, int y, int width, int height, int barColor, float barValue, String type, int yForText)
  {
    this(x, y, width, height, barColor, barValue, type, yForText, null, false);
  }

  Bar(int x, int y, int width, int height, int barColor, float barValue, String type, int yForText, String xValue, boolean xValueDisplayed)
  {
    super(x, y, width, height, barColor, BAR_EVENT);
    this.barValue = barValue;
    this.type = type;
    this.yForText = yForText;
    this.xValue = xValue;
    this.xValueDisplayed = xValueDisplayed;
  }

  public void mouseMoved()
  {
    if (super.getEvent(mouseX, mouseY) == BAR_EVENT)
    { 
      fill(0);
      textSize(20);
      text("" + ((type.equals("BarChart"))? "\u00a3" : "") + barValue, x, yForText);
      text("" + ((xValueDisplayed)? xValue : ""), x + 26, yForText + 22);
    }
  }
}
class BarChart
{
  private static final int BARCHART_MARGIN = 6;
  private static final int MIN_BAR_HEIGHT = 20;
  private int x, y, width, height, barWidth, heightForBars;
  private float minY, maxY, quarterValue;
  private float[]  yValues;
  private String[] xValues;
  private int[] barHeights;
  private boolean xAxisVisible;
  private String label;

  private ArrayList barList;

  BarChart(int x, int y, int width, int height, String[] xValues, float[] yValues, boolean xAxisVisible)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.xValues = xValues;
    this.yValues = yValues;
    
    this.xAxisVisible = xAxisVisible;

    if (xValues != null && xValues.length != yValues.length)
      throw new IllegalArgumentException();

    barList = new ArrayList();

    int numberOfSpaces = yValues.length - 2;
    barWidth = ((width - (BARCHART_MARGIN * numberOfSpaces)) / yValues.length);

    calculateBarHeights();
    createBars();
  }
  
  BarChart(int x, int y, int width, int height, String[] xValues, float[] yValues, boolean xAxisVisible, String label)
  {
    this(x, y, width, height, xValues, yValues, xAxisVisible);
    this.label = label;
  }

  BarChart(int x, int y, int width, int height, float[] yValues)
  {
    this(x, y, width, height, null, yValues, false);
  }
  
    BarChart(int x, int y, int width, int height, float[] yValues, String label)
  {
    this(x, y, width, height, null, yValues, false, label);
  }
  
  public void calculateBarHeights()
  {
    barHeights = new int[yValues.length];

    maxY = 0;
    minY = Float.MAX_VALUE;
    for (int i = 0; (i < yValues.length); i++)
    {
      if (yValues[i] > maxY)
        maxY = yValues[i];
      if (yValues[i] < minY)
        minY = yValues[i];
    }

    this.heightForBars = ((minY == 0)? height : height - MIN_BAR_HEIGHT);
    System.out.println("" + heightForBars);
  
    float diffMaxMin = maxY - minY;
    for (int i = 0; (i < yValues.length); i++)
    {
      barHeights[i] = (int) ((((yValues[i] - minY) * heightForBars) / diffMaxMin) + ((minY == 0)? 0 : MIN_BAR_HEIGHT));
    }
    
    quarterValue = (diffMaxMin /4);
  }

  public void createBars()
  {
    for (int i = 0; (i < yValues.length); i++)
    {
      int barX = x + ((barWidth + BARCHART_MARGIN) * i);
      int barY = y + (height - (int) barHeights[i]);
      float r = map(yValues[i], minY, maxY, 100, 220);
      int barColor = color(r, 0, 0);
      if(xAxisVisible)
      {
        barList.add(new Bar(barX, barY, barWidth, (int) barHeights[i], barColor, yValues[i], "BarChart", y + height + 20, xValues[i], true));
      }
      else
      {
        barList.add(new Bar(barX, barY, barWidth, (int) barHeights[i], barColor, yValues[i], "BarChart", y + height + 20));
      }
    }
  }

  public void draw()
  {
    fill(0);
    stroke(0);
    line(x, y, x, y + height);
    line(x, y + height, x + width, y + height);
    
    textSize(13);
    
    for(int quarter = 0;(quarter < 5); quarter++)
    {
      int lineY = y + ((heightForBars / 4) * quarter);
      line(x, lineY, x - 6, lineY);
      float value = maxY - (quarterValue * quarter); 
      text("\u00a3" + value, x - 88, lineY);
    }
    
    if(label != null)
    {
      fill(0);
      textSize(20);
      if(xAxisVisible)
        text(label, x + (width / 2) - 170, y + height + 65);
      else
        text(label, x + (width / 2) - 90, y + height + 40);
    }
    
    for (int i = 0; (i < barList.size()); i++)
    {
      Bar tmpBar = (Bar) barList.get(i);
      tmpBar.draw();
      tmpBar.mouseMoved();
    }
  }
}
// COLOURS
//HOME
public int WIDGET_RED         = color(200, 50, 50);
public int BABY_BLUE          = color(137, 207, 240);
public int UNION_JACK_BLUE    = color(0,51,153);
public int BLACK              = color(0);
public int ATOMIC_TANGERINE   = color(255, 153, 102);

public int PROCESS_YELLOW     = color(255, 255, 153);
//TOWN
public int WOOD_BROWN         = color(193, 154, 107);
public int BEIGE              = color(245, 245, 220);
//COUNTY
public int SHAMROCK_GREEN     = color(0, 158, 96);
public int LIGHT_GREEN        = color(144, 238, 144);
//REGION
public int AMERICAN_RED       = color(220, 20, 60);
public int PIGGY_PINK         = color(253, 221, 230);
//OPTION
public int RASPBERRY_RED      = color(227, 11, 92);
public int LIBERTY_BLUE       = color(84, 90, 167);
public int MALACHITE          = color(11, 218, 81);

//MAP
public int OCEAN_BLUE      = color(202, 226, 245);


//CONDITION COLOR - DO NOT USE THIS COLOR
public int CONDITION          = color(1,1,1);
final int SCREENX = 1152;
final int SCREENY = 648;
final int NUMBER_OF_ENTRIES = 1000;
final int HOME_WIDGET_DROP = 100;
final int QUERY_WIDGET_DROP = 200;
final int EVENT_NULL = -1;

//This duplicate should not effect the functionality of any class. It is soley used in the Bar class
final int BAR_EVENT = 1;

final int EVENT_TOWN_BUTTON = 1;
final int EVENT_COUNTY_BUTTON = 2;
final int EVENT_REGION_BUTTON = 3;
final int EVENT_UK_BUTTON = 7;
final int EVENT_DROP = 8;
final int EVENT_BACK_BUTTON = 9;
final int EVENT_HOME_BUTTON    = 10;

final int EVENT_TOP10_BUTTON = 11;
final int EVENT_BOT10_BUTTON = 12;
final int EVENT_AVG_BUTTON = 13;
final int EVENT_STAT_BUTTON = 14;

final int EVENT_SEARCH = 15;
//final int = 16;
//final int = 17;
//final int = 18;
//final int = 19;
//final int = 20;
//final int = 21;

final int EVENT_QUERY1 = 4;
final int EVENT_QUERY2 = 5;
final int EVENT_QUERY3 = 6;

class DateOfSale
{
  int year;
  int month;
  String monthName;
  int day;

  DateOfSale(String entry)
  {
    String dateString;  
    int date;
    String monthString; 
    int month;
    String yearString;  
    int year;
    Scanner entryScanner = new Scanner(entry);
    entryScanner.useDelimiter("/");


    dateString = entryScanner.next();
    day = (int) Integer.parseInt(dateString);
    //System.out.println(date);
    monthString = entryScanner.next();
    month = Integer.parseInt(monthString);

    yearString = "20"+entryScanner.next();
    year = Integer.parseInt(yearString);
  }
}
class Histogram
{
  private int x, y, width, height, numberOfBars, barWidth;
  private float increment, maxValue, minValue;
  private float[] values;
  private int[] yValues;
  private String[] xRanges;
  private ArrayList barList;

  Histogram(int x, int y, int width, int height, float[] values, int increment)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.values = values;
    this.increment = increment;

    barList = new ArrayList();

    calculateNumberOfBars();
    calculateWidthOfBars();
    createBars();
  }

  Histogram(int x, int y, float[] values, int increment)
  {
    this(x, y, 600, 360, values, increment);
  }

  public void calculateNumberOfBars()
  {
    maxValue = 0;
    minValue = Float.MAX_VALUE;
    for (int i = 0; (i < values.length); i++)
    {
      if (values[i] > maxValue)
        maxValue = values[i];
      if (values[i] < minValue)
        minValue = values[i];
    }

    if ((maxValue - minValue) % increment != 0)
      this.numberOfBars = (int) (Math.floor((maxValue - minValue) / increment) + 1);
    else
      this.numberOfBars = (int) ((maxValue - minValue) / increment);
  }

  public void calculateWidthOfBars()
  {
    this.barWidth = (int) Math.floor(width / this.numberOfBars);
  }

  public void createBars()
  {
    xRanges = new String[numberOfBars];
    yValues = new int[numberOfBars];
    int maxY = 0;
    for (int i = 0; (i < numberOfBars); i++)
    {
      float low = minValue +  (i * increment);
      float high = low + increment - 1;

      xRanges[i] = ("" + low + "\n to \n" + high);

      int numberInRange = 0;
      for (int j = 0; (j < values.length); j++)
      {
        if (values[j] >= low && values[j] <= high)
          numberInRange++;
      }

      yValues[i] = numberInRange;
      if (numberInRange > maxY)
        maxY = numberInRange;
    }

    for (int i = 0; (i < yValues.length); i++)
    {
      float barHeight =  ((yValues[i] * height) / maxY);
      int barX = x + (barWidth * i);
      int barY = y + (height - (int) barHeight);
      
      float r = map(yValues[i], 0, maxY, 100, 220);
      int barColor = color(r, 0, 0);
      
      barList.add(new Bar(barX, barY, barWidth, (int) barHeight, barColor, yValues[i], "Histogram", y + height + 30));
    }
  }

  public void draw()
  {
    for (int i = 0; (i < barList.size()); i++)
    {
      Bar tmpBar = (Bar) barList.get(i);
      tmpBar.draw();

      fill(0);
      textSize(15);
      text("" + yValues[i] + "-", x - 16, tmpBar.getY() + 4);

      if (barWidth >= 20)
      {
        int textSize = (barWidth/6);
        textSize(textSize);
        text("" + xRanges[i], tmpBar.getX() + (textSize / 2), y + height + 20);
      }
    }
    line(x, y, x, y + height);
  }
}
class Map {
  GeoMap geoMap;
  Map(PApplet thisApplet)
  {
    geoMap = new GeoMap(150,0,height,height,thisApplet);
    geoMap.readFile("GBR_adm2");

    textAlign(LEFT, BOTTOM);
    textSize(18);
  }

  public void draw()
  {
    background(OCEAN_BLUE);  
    stroke(0, 40);             

    fill(SHAMROCK_GREEN);        
    geoMap.draw();              

    int id = geoMap.getID(mouseX, mouseY);
    if ((id != -1)&&((id<113)||(id>170)))
    {
      fill(180, 120, 120);
      geoMap.draw(id);
      String name = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME_2");    
      fill(0);
      text(name, mouseX+5, mouseY-5);
    }

  }
  public void mousePressed() {
    int id = geoMap.getID(mouseX, mouseY);
    if ((id != -1)&&((id<113)||(id>170)))
    {
      String isLondon = geoMap.getAttributeTable().findRow(str(id), 0).getString("TYPE_2");
      String name;
      if(isLondon.equals("London Borough")){
        name = "GREATER LONDON";
      }
      else{ 
        name = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME_2");  
      }
      println(name);
      search = name;
      type = "County";
      currentQuery = new Query(search, type);
      currentScreen = townQueryScreen;
    }
  }

}
class PieChart
{
  private int x, y, radius;
  private float[] data, angles;
  private String[] key;

  PieChart(int x, int y, int radius, float[] data)
  {
    this(x, y, radius, data, null);
  }
  
  PieChart(int x, int y, int radius, float[] data, String[] key)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;  
    this.data = data;
    this.key = key;

    calculateAngles();
    if(key != null)
      calculateKey();
  }

  public void calculateAngles()
  {
    float total = 0;
    angles = new float[data.length];
    for (int i = 0; (i < data.length); i++)
    {
      total += data[i];
    }

    for (int i = 0; (i < angles.length); i++)
    {
      angles[i] = ((data[i] * 360) / total);
    }
  }
  
  public void calculateKey()
  {
    if(key.length == angles.length)
    {
      for(int i = 0;(i < key.length);i++)
      {
        float percentage =  ((angles[i] / 360) * 100);
        percentage = (((float) (Math.round(percentage * 100))) / 100);
        key[i] = (key[i] + ": " + percentage + "%");
      }
    }
  }

  public void draw()
  {
    stroke(0);
    float lastAngle = 0;
    for (int i = 0; i < data.length; i++) 
    {
      float r = map(i, 0, data.length, 0, 255);
      float g = map(i, 0, data.length, 255, 0);
      float b = map(i, 0, data.length, 255, 0);
      fill(color(r, g, b));
      arc(x, y, radius * 2, radius * 2, lastAngle, lastAngle + radians(angles[i]));
      lastAngle += radians(angles[i]);
      
      if(key != null)
      {
        fill(0);
        textSize(20);
        int textX = x + radius + 60;
        int textY =  y - (radius - 50)+ (i * 30);
        text(key[i], textX, textY);
        
        fill(color(r,g,b));
        rect(textX - 35, textY - 20, 20, 20);
      }
    }
  }
}
class PropertyEntry
{
  int price;
  String postcode, dateOfSale, street, locality, town, district, county, propertyType, oldOrNew, numName;


  PropertyEntry(String price, String dateOfSale, String postcode, String propertyType, 
    String oldOrNew, String numName, String street, 
    String locality, String town, String district, String county)
  {
    this.price = Integer.parseInt((price == null)? "" : price);
    this.dateOfSale = ((dateOfSale == null)? "" : dateOfSale);
    this.postcode = ((postcode == null)? "" : postcode);
    this.propertyType = ((propertyType == null)? "" : propertyType);
    this.oldOrNew = ((oldOrNew == null)? "" : oldOrNew);
    this.numName = ((numName == null)? "" : numName);
    this.street = ((street == null)? "" : street);
    this.locality = ((locality == null)? "" : locality);
    this.town = ((town == null)? "" : town);
    this.district = ((district == null)? "" : district);
    this.county = ((county == null)? "" : county);
  }
  public void draw(){
    
  }

  public String getNumName()
  {
    return numName;
  }

  public String getStreet()
  {
    return street;
  }

  public String toString()
  {
    return (" \u00a3" + price + " " + dateOfSale + " " + postcode + " " + propertyType + " " + oldOrNew + " " + numName + " " + street + " " + locality + " " + town + " " + district + " " + county);
  }
}

class Query
{
  String search;
  String type;
  String text, pieChartWords;
  PropertyEntry entry;
  BarChart chart;
  PieChart pChart;
  
  Query(String search, String type)
  {
    if (!type.equals("All")) {
      search = search.toUpperCase();
      this.search = "'"+search+"'";
      this.type = type;
    } else {
      this.search = "1";
      this.type = "1";
      println(000);
    }
    if (db.connect())
    {
      db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
    }
  }
  Query(String search)
  {
    this.search = search;
    this.search = this.search.toUpperCase();
    if (db.connect())
    {
      db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
    }
  }
  
  public void draw() {
    if (chart!=null) 
    {
      chart.draw();
    }
    else if (pChart!=null)
    {
      pChart.draw();
    } 
    else if(entry!=null) {
      entry.draw();
    }
  }
  public PropertyEntry getPropertyEntry() {
    String [] s = search.split("\\s*,\\s*");
    String [] tempArray = s[0].split(" ");
    if ((tempArray.length>1)&&(isStringInteger(tempArray[0]))) {
      db.query( "SELECT * FROM registry WHERE NumName = '"+ tempArray[1]+", "+ tempArray[0] +"' AND Street = '"+s[1]+"'");
    } else {
      db.query( "SELECT * FROM registry WHERE NumName = '" +s[0] +"' AND Street = '"+s[1]+"'");
    }
    String[] temp = new String[11];
    if (db.next()) {
      temp[0] = ""+db.getInt("Price");
      textSize(20);
      text(temp[0], 30,30);
      temp[1] = db.getString("Date");
      text(temp[1], 50,30);
      temp[2] = db.getString("Postcode");
      text(temp[2], 70,30);
      temp[3] = db.getString("Type");
      text(temp[3], 90,30);
      temp[4] = db.getString("OldNew");
      text(temp[4], 110,30);
      temp[5] = db.getString("NumName");
      text(temp[5], 130,30);
      temp[6] = db.getString("Street");
      text(temp[6], 150,30);
      temp[7] = db.getString("Locality");
      text(temp[7], 170,30);
      temp[8] = db.getString("Town");
      text(temp[8], 190,30);
      temp[9] = db.getString("District");
      text(temp[9], 210,30);
      temp[10] = db.getString("County");
      text(temp[10], 230,30);
      entry = new PropertyEntry(temp[0], temp[1], temp[2], temp[3], temp[4], temp[5], temp[6], temp[7], temp[8], temp[9], temp[10]);
      String test = entry.toString();
      println(test);
    }
    return entry;
  }
  public ArrayList<PropertyEntry> getStreetEntries() {
    ArrayList<PropertyEntry> tempList = new ArrayList<PropertyEntry>(); 
    db.query( "SELECT * FROM registry WHERE Street = '"+search+"'");
    while (db.next()) {
      String [] temp = new String[11];
      temp[0] = ""+db.getInt("Price");
      temp[1] = db.getString("Date");
      temp[2] = db.getString("Postcode");
      temp[3] = db.getString("Type");
      temp[4] = db.getString("OldNew");
      temp[5] = db.getString("NumName");
      temp[6] = db.getString("Street");
      temp[7] = db.getString("Locality");
      temp[8] = db.getString("Town");
      temp[9] = db.getString("District");
      temp[10] = db.getString("County");
      entry = new PropertyEntry(temp[0], temp[1], temp[2], temp[3], temp[4], temp[5], temp[6], temp[7], temp[8], temp[9], temp[10]);
      String test = entry.toString();
      tempList.add(entry);
      println(test);
    }
    return tempList;
  }

  public void displayPriceRange() {
    int increment = (int)(getMax()/10.0f);
    float [] priceRange = new float[10];
    for (int i =0; i<10; i++) {
      int bottomRange = (increment*(i));
      int upperRange = (increment*(i+1/10));
      db.query("SELECT COUNT(Price) FROM registry WHERE "+type+" = "+search+" AND Price> "+bottomRange + " and Price <= "+upperRange);
      if(db.next())
      {
        priceRange[i] = db.getInt(1);
        println(priceRange[i] );
      }
    }
   // histogramQuery = new Histogram(200, 200, 600, 360, priceRange, increment);
  }

  public void displayAge() {
    float[] data = new float[2];
    data[0] = 0;
    data[1] = 0;
    String newlyBuilt = "Y";
    db.query( "SELECT * FROM registry WHERE "+type+" = "+search);
    while (db.next()) {
      if (newlyBuilt.equals(db.getString("OldNew")))
      {
        data[0]++;
      } else
      {
        data[1]++;
      }
    }
    pChart = new PieChart(200, 200, 200, data);
  }
  public void displayHouseType() {
    float[] data = new float[5];
    for (int i=0; i<data.length; i++) {
      data[i]=0;
    }
    String detached = "D";
    String semiDetached = "S";
    String terraced = "T";
    String flats = "F";
    String other = "O";

    db.query( "SELECT * FROM registry WHERE "+type+" = "+search);
    while (db.next()) {
      String houseType = db.getString("Type");
      if (detached.equals(houseType))
      {
        data[0]++;
      } else if (semiDetached.equals(houseType))
      {
        data[1]++;
      } else if (terraced.equals(houseType))
      {
        data[2]++;
      } else if (flats.equals(houseType))
      {
        data[3]++;
      } else if (other.equals(houseType))
      {
        data[4]++;
      }
    }
    String[] key = {"Detached", "Semi-Detached", "Terraced", "Flats", "Other"};
    pChart = new PieChart(400, 400, 200, data, key);
  }

  
  public void displayTop(int numberToReturn) {
    db.query( "SELECT * FROM registry WHERE "+type+" = "+search+" ORDER BY Price DESC LIMIT "+numberToReturn );
    float [] temp = new float[numberToReturn];
    for (int i=0; i<numberToReturn; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
      }
    }
    chart = new BarChart(200, 200, 600, 360, temp, "Top 10 Prices");
  }
  public void displayBottom(int numberToReturn) {
    db.query( "SELECT * FROM registry WHERE "+type+" = "+search+" ORDER BY Price ASC LIMIT "+numberToReturn );
    float [] temp = new float[numberToReturn];
    for (int i=0; i<numberToReturn; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
      }
    }
    chart = new BarChart(200, 200, 600, 360, temp, "Bottom 10 Prices");
  }
  public void displayAverageOverTime() {
    float[] average = new float[20];
    for (int i=0; i<20; i++) {
      db.query("SELECT AVG(Price) From registry WHERE "+type+" = "+search+" AND Date>='"+(1995+i)+"-01-01' and Date< '"+(1996+i)+"-01-01'");
      if (db.next()) {
        average[i] = db.getFloat(1);
        println(average+" "+(1995+i));
      }
    }
    String[] xAxis = new String[20];
    for (int i = 0; (i < 20); i++)
    {
      int year = 1995 + i;
      xAxis[i] = ("" + year);
    }
    chart = new BarChart(200, 200, 600, 360, xAxis, average, true, "Average Over Time (1994-2014)");
  }
  public void displayStats() {
    float average = getAverage();
    float min = getMin();
    float max = getMax();
    float range = getRange();
    float[] stats = {min, max, range, average};
    String text = "" + search + "\nAverage Price (All Time): " + average
      + "\nLowest Priced Transaction: " + min + "\nHighest Priced Transaction: " + max 
      + "\nPrice Range: " + range;
  }
  public float getAverage() {
    int average=0;
    db.query("SELECT AVG(Price) From registry WHERE "+type+" = "+search+"");
    if (db.next())
      average = db.getInt(1);
    return PApplet.parseFloat(average);
  }
  public float getMin() {
    float min =0;
    db.query("SELECT MIN(Price) From registry WHERE "+type+" = "+search+"");
    if (db.next())
      min = db.getInt(1);
    return min;
  }
  public float getMax() {
    float max =0;
    db.query("SELECT MAX(Price) From registry WHERE "+type+" = "+search+"");
    if (db.next())
      max = db.getInt(1);
    return max;
  }

  public float getRange() {
    float range = getMax()-getMin();
    println(range+" range");
    return range;
  }
  public boolean isStringInteger(String number ) {
    try {
      Integer.parseInt(number);
    }
    catch(Exception e ) {
      return false;
    }
    return true;
  }
  
  public void setChartToNull()
  {
   chart = null; 
  }
}
class Screen
{
  private String graphLabel;
  private int labelX, labelY;
  private ArrayList widgetList;
  int backgroundColor = CONDITION;
  PImage backgroundImage;
  Boolean imageUsed = false;
  GUIController gui = new GUIController(main);
  IFTextField searchbar;
  IFLabel label;
  Map myMap;
  String searchText;
  
  Screen(int backgroundColor)
  {
    this.backgroundColor = backgroundColor;

    widgetList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }

  Screen(PImage backgroundImage)
  {
    this.imageUsed = true;
    this.backgroundImage = backgroundImage;
    widgetList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }
  Screen(PApplet thisApplet) {
    myMap = new Map(thisApplet);
    widgetList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }
  Screen(PApplet thisApplet, int backgroundColor) {
    this.backgroundColor = backgroundColor;
    myMap = new Map(thisApplet);
    widgetList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }
  Screen(PApplet thisApplet, PImage backgroundImage) {
    this.backgroundImage = backgroundImage;
    this.imageUsed = true;
    myMap = new Map(thisApplet);
    widgetList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }
    
  public void draw()
  {
   if( (currentScreen != townSelectScreen) && searchbarIsDisplayed )
   {
     searchbarIsDisplayed = false;
     townSelectScreen.hideSearchBar();
   }
    if( imageUsed )
    {
      background(backgroundImage);
    }
    else
    {
      background(backgroundColor);
    }

    for (int i =0; (i < widgetList.size()); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      aWidget.draw();
    }

    if(myMap!=null){
      myMap.draw();
    }
    fill(0);
    text(graphLabel, labelX, labelY);
  }

  
  public int getEvent()
  {
    int event;

    for (int i = 0; i < widgetList.size(); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      event = aWidget.getEvent(mouseX, mouseY);

      if (event != EVENT_NULL)
        return event;
    }
    return EVENT_NULL;
  }
  
  public void addWidget(int x, int y, int width, int height, String label, int widgetColor, PFont widgetFont, int event)
  {
    widgetList.add(new Widget(x, y, width, height, label, widgetColor, widgetFont, event));
  }
  public void showSearchBar()
  {
    int x = SCREENX/2-180;
    int y = SCREENY/2;
    int barWidth = 360;
    int barHeight = 40;
    IFTextField searchbar = new IFTextField("Search", x, y);
    //IFLabel label = new IFLabel( "Search", x+barWidth/2 -15, y-15);
    searchbar.setSize(barWidth, barHeight);
    this.addWidget(SCREENX/4, SCREENY/2, 80, 40, "search", SHAMROCK_GREEN, baskerville, EVENT_SEARCH);
    this.searchbar = searchbar;
    //this.label = label;
    gui.add(this.searchbar);
    //gui.add(this.label);
    gui.addActionListener(this);
    
  }
  public void hideSearchBar()
  {
    gui.remove(this.searchbar);
    //gui.remove(this.label);
  }

  public void addText(int x, int y, String title)
  {
    graphLabel = title;
    labelX = x;
    labelY = y;
  }
  public void mouseMoved()
  {
    int event;

    for (int i = 0; i < widgetList.size(); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      event = aWidget.getEvent(mouseX, mouseY);

      if (event != EVENT_NULL)
        aWidget.setStrokeColor(color(255));
      else
        aWidget.setStrokeColor(color(0));
    }
  }
  public void mousePressed() {
    if(myMap!=null){
      myMap.mousePressed();
    }
  }
}

class Toolbar
{
  final int MARGIN = 2;
  final int TOOLBAR_HEIGHT = 30;
  ArrayList widgetList, queryList;
  final int toolbarColor;
  final int BUTTON_WIDTH = SCREENX / 20;
  final int BUTTON_HEIGHT = TOOLBAR_HEIGHT - (2 * MARGIN);
  final int QUERY_WIDGET_WIDTH = SCREENX / 5;
  Widget backButton, homeButton, dropDownButton, query1, query2, query3;

  PImage backArrowImage, menuImage, homeImage;
  int backButtonX, backButtonY, dropDownButtonX, dropDownButtonY, homeButtonX, homeButtonY;
 
  Toolbar(int toolbarColor, PImage backArrowImage, PImage menuImage, PImage homeImage)
  {
    
    this.toolbarColor = toolbarColor;
    textFont(myFont);
    
    backButtonX = MARGIN;
    backButtonY = MARGIN;
    backButton = new Widget(backButtonX, backButtonY, BUTTON_WIDTH, BUTTON_HEIGHT, "", 100, myFont, EVENT_BACK_BUTTON );
    
    homeButtonX = backButtonX + BUTTON_WIDTH + MARGIN;
    homeButtonY = backButtonY;
    homeButton = new Widget(homeButtonX, homeButtonY, BUTTON_WIDTH, BUTTON_HEIGHT, "", 100, myFont, EVENT_HOME_BUTTON);
    
    dropDownButtonX = SCREENX - (MARGIN + BUTTON_WIDTH);
    dropDownButtonY = MARGIN;
    dropDownButton = new Widget(dropDownButtonX, dropDownButtonY, BUTTON_WIDTH, BUTTON_HEIGHT, "", 100, myFont, EVENT_DROP );   
    
    query1 = new Widget( dropDownButton.getX() - (QUERY_WIDGET_WIDTH - BUTTON_WIDTH), dropDownButton.getY() + (TOOLBAR_HEIGHT - 2 * MARGIN), QUERY_WIDGET_WIDTH, TOOLBAR_HEIGHT,"About us",
                                 230, myFont, EVENT_QUERY1);
    query2 = new Widget( dropDownButton.getX() - (QUERY_WIDGET_WIDTH - BUTTON_WIDTH), query1.getY() + TOOLBAR_HEIGHT, QUERY_WIDGET_WIDTH, TOOLBAR_HEIGHT,"Link to Repository",
                                 230, myFont, EVENT_QUERY2);
    query3 = new Widget( dropDownButton.getX() - (QUERY_WIDGET_WIDTH - BUTTON_WIDTH), query2.getY() + TOOLBAR_HEIGHT, QUERY_WIDGET_WIDTH, TOOLBAR_HEIGHT,"Play 'God Save the Queen'",
                                 230, myFont, EVENT_QUERY3);
                                 
    
    widgetList = new ArrayList();
    widgetList.add(backButton); 
    widgetList.add(dropDownButton);
    widgetList.add(homeButton);
    
    queryList = new ArrayList();
    queryList.add(query1);
    queryList.add(query2);
    queryList.add(query3);
    
    this.menuImage = menuImage;
    this.backArrowImage = backArrowImage;
    this.homeImage = homeImage;
    menuImage.resize(BUTTON_WIDTH, BUTTON_HEIGHT);
    backArrowImage.resize(BUTTON_WIDTH, BUTTON_HEIGHT);
    homeImage.resize(BUTTON_HEIGHT, BUTTON_HEIGHT);
  }

  public void draw()
  {
    noStroke();
    fill(toolbarColor);
    rect(0, 0, SCREENX, TOOLBAR_HEIGHT);
    for (int i = 0; i<widgetList.size(); i++)
    {
      Widget aWidget =  (Widget) widgetList.get(i);
      aWidget.setStrokeColor(toolbarColor);
      aWidget.draw();
    }
    
    if(dropped)
    {
      for (int i = 0; i < queryList.size(); i++)
      {
        Widget aWidget =  (Widget) queryList.get(i);
        aWidget.setStrokeColor(toolbarColor);
        aWidget.setFontColor(0);
        aWidget.setFontSize(13);
        aWidget.draw();
      }
    }
    image(backArrowImage, backButtonX, backButtonY);
    image(menuImage, dropDownButtonX, dropDownButtonY);
    image(homeImage, homeButtonX + (BUTTON_WIDTH / 4), homeButtonY);
  }

  public void mouseMoved()
  {
    if (toolbar.getEvent() == EVENT_DROP)
      dropped = true;
    else if (/*dropped &&*/ ( toolbar.getEvent() == EVENT_QUERY1 ))
      query1.setStrokeColor(255);
    else if( toolbar.getEvent() == EVENT_QUERY2 ) 
      query2.setStrokeColor(255);
    else if( toolbar.getEvent() == EVENT_QUERY3 )
      query3.setStrokeColor(255);
    else
      dropped = false;
  }

  public int getEvent()
  {
    int event, eventQ;

    for (int i = 0; i < widgetList.size(); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      event = aWidget.getEvent(mouseX, mouseY);
      if (event != EVENT_NULL)
        return event;
    }
    
    for (int i = 0; i < queryList.size(); i++)
    {
      Widget bWidget = (Widget) queryList.get(i);
      eventQ = bWidget.getEvent(mouseX, mouseY);
      if (eventQ != EVENT_NULL)
        return eventQ;
    }
    return EVENT_NULL;
  }
}
class Widget
{
  int x, y, width, height;
  String label; 
  int event, fontSize;
  int widgetColor, labelColor, strokeColor;
  PFont widgetFont;

  Widget(int x, int y, int width, int height, String label, int widgetColor, PFont widgetFont, int event)
  {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    this.fontSize = 15;

    strokeColor = color(0);
    labelColor= color(255);
  }
  
  Widget(int x, int y, int width, int height, int widgetColor, int event)
  {
    this(x, y, width, height, null, widgetColor, null, event);
  }
  
  public void draw()
  {
    stroke(strokeColor);
    fill(widgetColor);
    rect(x, y, width, height);
    
    if(label != null)
    {
      fill(labelColor);
      textFont(widgetFont);
      textSize(fontSize);
      text(label, x+10, y+height-10);
    }
  }
  public int getEvent(int mX, int mY)
  {
    if (mX>=x && mX <=x+width && mY >=y && mY <=y+height)
    {
      return event;
    }
    return EVENT_NULL;
  }

  public void setStrokeColor(int strokeColor)
  {
    this.strokeColor = strokeColor;
  }
  
  public void setFontColor(int labelColor)
  {
    this.labelColor = labelColor;
  }
  
  
  public int getX()
  {
     return x; 
  }
  
  public int getY()
  {
     return y; 
  }
  
  public void setFontSize(int fontSize)
  {
    this.fontSize = fontSize;

  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Project" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
