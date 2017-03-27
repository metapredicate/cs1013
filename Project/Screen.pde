
class Screen
{
  
  private String graphLabel;
  private int labelX, labelY;

  private ArrayList widgetList, barChartList;
  color backgroundColor;

  Screen(color backgroundColor)
  {
    this.backgroundColor = backgroundColor;

    widgetList = new ArrayList();
    barChartList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }

  void draw()
  {
    background(backgroundColor);
    for (int i = 0; (i < widgetList.size()); i++)
    {
      Widget aWidget = (Widget) widgetList.get(i);
      aWidget.draw();
    }

    for (int i = 0; (i < barChartList.size()); i++)
    {
      BarChart aBarChart = (BarChart) barChartList.get(i);
      aBarChart.draw(SCREENX / 2 - 360, SCREENY / 2 - 240, 720, 480);
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

  void addBarChart(BarChart barChart)
  {
    barChartList.add(barChart);
  }

  void addText(int x, int y, String title)
  {
    graphLabel = title;
    labelX = x;
    labelY = y;
  }
  void addText(float x, float y, String text, int fontSize, PFont font, color fontColour)
  {
    fill(fontColour);
    textFont(font);
    textSize(fontSize);
    text(text, x, y);
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