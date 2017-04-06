class PieChart
{
  private int x, y, radius;
  private float[] data, angles;
  private String[] key;

  PieChart(int x, int y, int radius, float[] data)
  {
    this(x, y, radius, data, null);
  }
  
  PieChart(int x, int y, int radius, float[] data, String[] key)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;  
    this.data = data;
    this.key = key;

    calculateAngles();
    if(key != null)
      calculateKey();
  }

  void calculateAngles()
  {
    float total = 0;
    angles = new float[data.length];
    for (int i = 0; (i < data.length); i++)
    {
      total += data[i];
    }

    for (int i = 0; (i < angles.length); i++)
    {
      angles[i] = ((data[i] * 360) / total);
    }
  }
  
  void calculateKey()
  {
    if(key.length == angles.length)
    {
      for(int i = 0;(i < key.length);i++)
      {
        float percentage =  ((angles[i] / 360) * 100);
        percentage = (((float) (Math.round(percentage * 100))) / 100);
        key[i] = (key[i] + ": " + percentage + "%");
      }
    }
  }

  void draw()
  {
    //noStroke();
    float lastAngle = 0;
    for (int i = 0; i < data.length; i++) 
    {
      float r = map(i, 0, data.length, 0, 255);
      float g = map(i, 0, data.length, 255, 0);
      float b = map(i, 0, data.length, 255, 0);
      fill(color(r, g, b));
      arc(x, y, radius * 2, radius * 2, lastAngle, lastAngle + radians(angles[i]));
      lastAngle += radians(angles[i]);
      
      if(key != null)
      {
        fill(0);
        textSize(20);
        int textX = x + radius + 60;
        int textY =  y - (radius - 50)+ (i * 30);
        text(key[i], textX, textY);
        
        fill(color(r,g,b));
        rect(textX - 35, textY - 20, 20, 20);
      }
    }
  }
}