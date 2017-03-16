class Toolbar
{
PFont stdFont;
final int EVENT_BACK = 1;
final int EVENT_DROP = 2;
final int MARGIN = 2;
final int TOOLBAR_HEIGHT = 30;
ArrayList widgetList;
final color toolbarColor;

 
  Widget backButton, dropDownButton;

Toolbar(color toolbarColor)
{
  this.toolbarColor = toolbarColor;
  stdFont=loadFont("CharterBT-Roman-48.vlw");
  textFont(stdFont);
  backButton = new Widget(MARGIN, MARGIN, SCREENX / 20, TOOLBAR_HEIGHT - (2 * MARGIN), "", 100, stdFont, EVENT_BACK );
  dropDownButton = new Widget(SCREENX - (MARGIN +  SCREENX / 20), 2, SCREENX / 15, TOOLBAR_HEIGHT - (2 * MARGIN), "", 100, stdFont, EVENT_BACK );    

  
  widgetList = new ArrayList();
  widgetList.add(backButton); 
  widgetList.add(dropDownButton);
 
}

void draw()
{
  noStroke();
  fill(toolbarColor);
  rect(0, 0, SCREENX, TOOLBAR_HEIGHT);
  for(int i = 0; i<widgetList.size(); i++)
  {
    Widget aWidget =  (Widget) widgetList.get(i);
    aWidget.setStrokeColor(toolbarColor);
    aWidget.draw();
  }
  
}

void mousePressed()
{
  int event;
  for(int i = 0; i<widgetList.size(); i++)
  {
  Widget aWidget = (Widget) widgetList.get(i);
       event = aWidget.getEvent(mouseX,mouseY);
       switch(event) 
       {
         case EVENT_BACK:
           
         break;
         case EVENT_DROP:
           
         break;
       }  
    }
  }
}