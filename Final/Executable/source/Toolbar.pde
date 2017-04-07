
class Toolbar
{
  final int MARGIN = 2;
  final int TOOLBAR_HEIGHT = 30;
  ArrayList widgetList, queryList;
  final color toolbarColor;
  final int BUTTON_WIDTH = SCREENX / 20;
  final int BUTTON_HEIGHT = TOOLBAR_HEIGHT - (2 * MARGIN);
  final int QUERY_WIDGET_WIDTH = SCREENX / 5;
  Widget backButton, homeButton, dropDownButton, query1, query2, query3;

  PImage backArrowImage, menuImage, homeImage;
  int backButtonX, backButtonY, dropDownButtonX, dropDownButtonY, homeButtonX, homeButtonY;
 
  Toolbar(color toolbarColor, PImage backArrowImage, PImage menuImage, PImage homeImage)
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

  void draw()
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

  void mouseMoved()
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

  int getEvent()
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