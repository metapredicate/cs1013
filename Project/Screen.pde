
class Screen
{
  private ArrayList widgetList;
  color backgroundColor;

  Screen(color backgroundColor)
  {
    this.backgroundColor = backgroundColor;

    widgetList = new ArrayList();
  }

  void draw()
  {
    background(backgroundColor);
    for (int i = 0; (i < widgetList.size()); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      aWidget.draw();
    }
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

  void mouseMoved()
  {
    int event;

    for (int i = 0; i < widgetList.size(); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      event = aWidget.getEvent(mouseX, mouseY);
     

  
    }
  }
}