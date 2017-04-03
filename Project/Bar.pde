class Bar extends Widget
{
  private float barValue;
  private String type;
  private int yForText;
  
  Bar(int x, int y, int width, int height, color barColor, float barValue, String type, int yForText)
  {
    super(x, y, width, height, barColor, BAR_EVENT);
    this.barValue = barValue;
    this.type = type;
    this.yForText = yForText;
  }
  
  void mouseMoved()
  {
    if(super.getEvent(mouseX, mouseY) == BAR_EVENT)
    {
      fill(0);
      textSize(20);
      text("" + ((type.equals("BarChart"))? "£" : "") + barValue, x, yForText - 10);
    }
  }
}