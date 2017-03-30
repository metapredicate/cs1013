class BarChart
{
  private static final int BARCHART_MARGIN = 6;
  private int x, y, width, height, barWidth;
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

    float maxY = 0;
    float minY = Float.MAX_VALUE;
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
      barHeights[i] = (int) (((yValues[i] - minY) * height) / diffMaxMin);
    }
  }

  void createBars()
  {
    for (int i = 0; (i < xValues.length); i++)
    {
      int barX = x + ((barWidth + BARCHART_MARGIN) * i);
      int barY = y + (height - (int) barHeights[i]);
      barList.add(new Bar(barX, barY, barWidth, (int) barHeights[i], color(255, 0, 0), 0));
    }
  }

  void draw()
  {
    for (int i = 0; (i < barList.size()); i++)
    {
      Bar tmpBar = (Bar) barList.get(i);
      tmpBar.draw();

      fill(0);
      textSize(12);
      text("" + yValues[i] + "-", x - 58, tmpBar.getY() + 4);
    }
    line(x, y, x, y + height);
    line(x, y + height, x + width, y + height);
  }
}