class BarChart
{
  private static final int BARCHART_MARGIN = 6;
  private static final int MIN_BAR_HEIGHT = 20;
  private int x, y, width, height, barWidth, heightForBars;
  private float minY, maxY, quarterValue;
  private float[] xValues, yValues;
  private int[] barHeights;

  private ArrayList barList;

  BarChart(int x, int y, int width, int height, float[] xValues, float[] yValues)
  { 
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.xValues = xValues;
    this.yValues = yValues;
    
    this.heightForBars = height - MIN_BAR_HEIGHT;

    if (xValues.length != yValues.length)
      throw new IllegalArgumentException();

    barList = new ArrayList();

    int numberOfSpaces = xValues.length - 2;
    barWidth = ((width - (BARCHART_MARGIN * numberOfSpaces)) / xValues.length);

    calculateBarHeights();
    createBars();
  }

  BarChart(int x, int y, float[] xValues, float[] yValues)
  {
    this(x, y, 600, 360, xValues, yValues);
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

    float diffMaxMin = maxY - minY;
    for (int i = 0; (i < yValues.length); i++)
    {
      barHeights[i] = (int) ((((yValues[i] - minY) * heightForBars) / diffMaxMin) + MIN_BAR_HEIGHT);
    }
    
    quarterValue = (diffMaxMin /4);
  }

  void createBars()
  {
    for (int i = 0; (i < xValues.length); i++)
    {
      int barX = x + ((barWidth + BARCHART_MARGIN) * i);
      int barY = y + (height - (int) barHeights[i]);
      float r = map(yValues[i], minY, maxY, 100, 220);
      color barColor = color(r, 0, 0);
      barList.add(new Bar(barX, barY, barWidth, (int) barHeights[i], barColor, yValues[i], "BarChart"));
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
      text("" + value, x - 80, lineY);
    }
  }
}