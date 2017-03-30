class Widget
{
  int x, y, width, height;
  String label; 
  int event, fontSize;
  color widgetColor, labelColor, strokeColor;
  PFont widgetFont;

  Widget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event)
  {
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    this.fontSize = 15;

    strokeColor = color(0);
    labelColor= color(255);
  }
  
  Widget(int x, int y, int width, int height, color widgetColor, int event)
  {
    this(x, y, width, height, null, widgetColor, null, event);
  }
  
  void draw()
  {
    stroke(strokeColor);
    fill(widgetColor);
    rect(x, y, width, height);
    
    if(label != null)
    {
      fill(labelColor);
      textFont(widgetFont);
      textSize(fontSize);
      text(label, x+10, y+height-10);
    }
  }
  int getEvent(int mX, int mY)
  {
    if (mX>=x && mX <=x+width && mY >=y && mY <=y+height)
    {
      return event;
    }
    return EVENT_NULL;
  }

  void setStrokeColor(color strokeColor)
  {
    this.strokeColor = strokeColor;
  }
  
  void setFontColor(color labelColor)
  {
    this.labelColor = labelColor;
  }
  
  
  int getX()
  {
     return x; 
  }
  
  int getY()
  {
     return y; 
  }
  
  void setFontSize(int fontSize)
  {
    this.fontSize = fontSize;
  }
}