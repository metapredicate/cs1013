class Bar extends Widget
{
  private float barValue;
  private String type;
  
  Bar(int x, int y, int width, int height, color barColor, float barValue, String type)
  {
    super(x, y, width, height, barColor, BAR_EVENT);
    this.barValue = barValue;
    this.type = type;
  }
  
  void mouseMoved()
  {
    if(super.getEvent(mouseX, mouseY) == BAR_EVENT)
    {
      fill(0);
      textSize(20);
      text("" + ((type.equals("BarChart"))? "£" : "") + barValue, x, y - 10);
    }
  }
}