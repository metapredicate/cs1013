class Bar extends Widget
{
  private float barValue;
  private String type, xValue;
  private int yForText;
  private boolean xValueDisplayed;

  Bar(int x, int y, int width, int height, color barColor, float barValue, String type, int yForText)
  {
    this(x, y, width, height, barColor, barValue, type, yForText, null, false);
  }

  Bar(int x, int y, int width, int height, color barColor, float barValue, String type, int yForText, String xValue, boolean xValueDisplayed)
  {
    super(x, y, width, height, barColor, BAR_EVENT);
    this.barValue = barValue;
    this.type = type;
    this.yForText = yForText;
    this.xValue = xValue;
    this.xValueDisplayed = xValueDisplayed;
  }

  void mouseMoved()
  {
    if (super.getEvent(mouseX, mouseY) == BAR_EVENT)
    { 
      fill(0);
      textSize(20);
      text("" + ((type.equals("BarChart"))? "£" : "") + barValue, x, yForText);
      text("" + ((xValueDisplayed)? xValue : ""), x + 26, yForText + 22);
    }
  }
}