class Screen
{
  private String graphLabel;
  private int labelX, labelY;
  private ArrayList widgetList;
  color backgroundColor = CONDITION;
  PImage backgroundImage;
  Boolean imageUsed = false;
  GUIController gui = new GUIController(main);
  IFTextField searchbar;
  IFLabel label;
  Map myMap;
  String searchText;
  
  Screen(color backgroundColor)
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
  Screen(PApplet thisApplet, color backgroundColor) {
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
    
  void draw()
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

  
  int getEvent()
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
  
  void addWidget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event)
  {
    widgetList.add(new Widget(x, y, width, height, label, widgetColor, widgetFont, event));
  }
  void showSearchBar()
  {
    int x = SCREENX/2-180;
    int y = SCREENY/2;
    int barWidth = 360;
    int barHeight = 40;
    IFTextField searchbar = new IFTextField("Search", x, y);
    //IFLabel label = new IFLabel( "Search", x+barWidth/2 -15, y-15);
    searchbar.setSize(barWidth, barHeight);
    this.searchbar = searchbar;
    //this.label = label;
    gui.add(this.searchbar);
    //gui.add(this.label);
  }
  void hideSearchBar()
  {
    gui.remove(this.searchbar);
    //gui.remove(this.label);
    
  }

  void addText(int x, int y, String title)
  {
    graphLabel = title;
    labelX = x;
    labelY = y;
  }
  void mouseMoved()
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
  void mousePressed() {
    if(myMap!=null){
      myMap.mousePressed();
    }
  }
}