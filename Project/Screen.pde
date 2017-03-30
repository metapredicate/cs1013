<<<<<<< .mine
=======
/*
>>>>>>> .r73
class Screen
{
  private String graphLabel;
  private int labelX, labelY;
  private ArrayList widgetList, barChartList;
  color backgroundColor = CONDITION;
  PImage backgroundImage;
  Boolean imageUsed = false;
  IFTextField t;
  IFLabel l;
  
  
  Screen(color backgroundColor)
  {
    this.backgroundColor = backgroundColor;

    widgetList = new ArrayList();
    barChartList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }
  Screen(PImage backgroundImage)
  {
    this.imageUsed = true;
    this.backgroundImage = backgroundImage;
    widgetList = new ArrayList();
    barChartList = new ArrayList();
    graphLabel = "";
    labelX = 0;
    labelY = 0;
  }

  void draw()
  {
    if( imageUsed )
    {
      background(backgroundImage);
    }
    else
    {
      background(backgroundColor);
    }
    
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
  
  void addIFTextField(String string, int x, int y)
  {

    this.t = new IFTextField(string, x, y, 150);
    this.l = new IFLabel("Search", x-10, y-10);
   // t = new IFTextField(string,x,y);
    c.add(t);
    c.add(l);
    
    t.addActionListener(this);
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