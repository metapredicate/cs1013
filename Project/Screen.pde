
class Screen
{
  private ArrayList widgetList, barChartList;
  color backgroundColor;

  Screen(color backgroundColor)
  {
    this.backgroundColor = backgroundColor;

    widgetList = new ArrayList();
    barChartList = new ArrayList();
  }

  void draw()
  {
    background(backgroundColor);
    for (int i = 0; (i < widgetList.size()); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      aWidget.draw();
    }
    
    for(int i = 0;(i < barChartList.size());i++)
    {
      BarChart aBarChart = (BarChart) barChartList.get(i);
      aBarChart.draw(SCREENX - 100, SCREENY - 100, 50, 50);
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
  
  void addBarChart(BarChart barChart)
  {
    barChartList.add(barChart);
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
}