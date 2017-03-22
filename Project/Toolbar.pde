class Toolbar
{
  final int MARGIN = 2;
  final int TOOLBAR_HEIGHT = 30;
  ArrayList widgetList, queryList;
  final color toolbarColor;
  final int TOOLBAR_WIDTH = SCREENX / 20;
  final int QUERY_WIDGET_WIDTH = SCREENX / 5;
  Widget backButton, dropDownButton, query1, query2, query3;
 
  Toolbar(color toolbarColor)
  {
    this.toolbarColor = toolbarColor;
    textFont(myFont);
    backButton = new Widget(MARGIN, MARGIN, TOOLBAR_WIDTH, TOOLBAR_HEIGHT - (2 * MARGIN), "", 100, myFont, EVENT_BACK_BUTTON );
    dropDownButton = new Widget(SCREENX - (MARGIN +  TOOLBAR_WIDTH), 2, TOOLBAR_WIDTH, TOOLBAR_HEIGHT - (2 * MARGIN), "", 100, myFont, EVENT_DROP );    
    query1 = new Widget( dropDownButton.getX() - (QUERY_WIDGET_WIDTH - TOOLBAR_WIDTH), dropDownButton.getY() + (TOOLBAR_HEIGHT - 2 * MARGIN), QUERY_WIDGET_WIDTH, TOOLBAR_HEIGHT,"New Graph Button",
                                 230, myFont, EVENT_QUERY1);
    query2 = new Widget( dropDownButton.getX() - (QUERY_WIDGET_WIDTH - TOOLBAR_WIDTH), query1.getY() + TOOLBAR_HEIGHT, QUERY_WIDGET_WIDTH, TOOLBAR_HEIGHT,"",
                                 230, myFont, EVENT_QUERY2);
    query3 = new Widget( dropDownButton.getX() - (QUERY_WIDGET_WIDTH - TOOLBAR_WIDTH), query2.getY() + TOOLBAR_HEIGHT, QUERY_WIDGET_WIDTH, TOOLBAR_HEIGHT,"",
                                 230, myFont, EVENT_QUERY3);
    widgetList = new ArrayList();
    widgetList.add(backButton); 
    widgetList.add(dropDownButton);
    
    queryList = new ArrayList();
    queryList.add(query1);
    queryList.add(query2);
    queryList.add(query3);
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
        aWidget.draw();
      }
    }
    
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