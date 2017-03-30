class PieChart
{
  private int x, y, radius;
  private float[] data, angles;

  PieChart(int x, int y, int radius, float[] data)
  {
    this.x = x;
    this.y = y;
    this.radius = radius;  
    this.data = data;

    calculateAngles();
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

  void draw()
  {
    noStroke();
    float lastAngle = 0;
    for (int i = 0; i < data.length; i++) 
    {
      float r = map(i, 0, data.length, 0, 255);
      float g = map(i, 0, data.length, 255, 0);
      float b = map(i, 0, data.length, 255, 0);
      fill(color(r, g, b));
      arc(x, y, radius * 2, radius * 2, lastAngle, lastAngle + radians(angles[i]));
      lastAngle += radians(angles[i]);
    }
  }
}