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

  private ArrayList barList;

  BarChart(int x, int y, int width, int height, String[] xValues, float[] yValues)
  { 
    this(x, y, width, height, xValues, yValues, false);
  }

  BarChart(int x, int y, int width, int height, float[] yValues)
  {
    this(x, y, width, height, null, yValues);
  }
  
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
  
  void calculateBarHeights()
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

  void createBars()
  {
    for (int i = 0; (i < yValues.length); i++)
    {
      int barX = x + ((barWidth + BARCHART_MARGIN) * i);
      int barY = y + (height - (int) barHeights[i]);
      float r = map(yValues[i], minY, maxY, 100, 220);
      color barColor = color(r, 0, 0);
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

  void draw()
  {
    for (int i = 0; (i < barList.size()); i++)
    {
      Bar tmpBar = (Bar) barList.get(i);
      tmpBar.draw();
      tmpBar.mouseMoved();
    }
    fill(0);
    line(x, y, x, y + height);
    line(x, y + height, x + width, y + height);
    
    textSize(13);
    
    for(int quarter = 0;(quarter < 5); quarter++)
    {
      int lineY = y + ((heightForBars / 4) * quarter);
      line(x, lineY, x - 6, lineY);
      float value = maxY - (quarterValue * quarter); 
      text("£" + value, x - 88, lineY);
    }
  }
}