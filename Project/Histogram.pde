class Histogram
{
  private int x, y, width, height, numberOfBars, barWidth;
  private float increment, maxValue, minValue;
  private float[] values;
  private int[] yValues;
  private String[] xRanges;
  private ArrayList barList;

  Histogram(int x, int y, int width, int height, float[] values, int increment)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.values = values;
    this.increment = increment;

    barList = new ArrayList();

    calculateNumberOfBars();
    calculateWidthOfBars();
    createBars();
  }

  Histogram(int x, int y, float[] values, int increment)
  {
    this(x, y, 600, 360, values, increment);
  }

  void calculateNumberOfBars()
  {
    maxValue = 0;
    minValue = Float.MAX_VALUE;
    for (int i = 0; (i < values.length); i++)
    {
      if (values[i] > maxValue)
        maxValue = values[i];
      if (values[i] < minValue)
        minValue = values[i];
    }

    if ((maxValue - minValue) % increment != 0)
      this.numberOfBars = (int) (Math.floor((maxValue - minValue) / increment) + 1);
    else
      this.numberOfBars = (int) ((maxValue - minValue) / increment);
  }

  void calculateWidthOfBars()
  {
    this.barWidth = (int) Math.floor(width / this.numberOfBars);
  }

  void createBars()
  {
    xRanges = new String[numberOfBars];
    yValues = new int[numberOfBars];
    int maxY = 0;
    for (int i = 0; (i < numberOfBars); i++)
    {
      float low = minValue +  (i * increment);
      float high = low + increment - 1;

      xRanges[i] = ("" + low + "\n to \n" + high);

      int numberInRange = 0;
      for (int j = 0; (j < values.length); j++)
      {
        if (values[j] >= low && values[j] <= high)
          numberInRange++;
      }

      yValues[i] = numberInRange;
      if (numberInRange > maxY)
        maxY = numberInRange;
    }

    for (int i = 0; (i < yValues.length); i++)
    {
      float barHeight =  ((yValues[i] * height) / maxY);
      int barX = x + (barWidth * i);
      int barY = y + (height - (int) barHeight);
      
      float r = map(yValues[i], 0, maxY, 100, 220);
      color barColor = color(r, 0, 0);
      
      barList.add(new Bar(barX, barY, barWidth, (int) barHeight, barColor, yValues[i], "Histogram"));
    }
  }

  void draw()
  {
    for (int i = 0; (i < barList.size()); i++)
    {
      Bar tmpBar = (Bar) barList.get(i);
      tmpBar.draw();

      fill(0);
      textSize(15);
      text("" + yValues[i] + "-", x - 16, tmpBar.getY() + 4);

      if (barWidth >= 20)
      {
        int textSize = (barWidth/6);
        textSize(textSize);
        text("" + xRanges[i], tmpBar.getX() + (textSize / 2), y + height + 20);
      }
    }
    line(x, y, x, y + height);
  }
}