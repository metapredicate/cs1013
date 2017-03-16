class Toolbar
{
final int EVENT_DROP = 2;
final int MARGIN = 2;
final int TOOLBAR_HEIGHT = 30;
ArrayList widgetList;
final color toolbarColor;
final int TOOLBAR_WIDTH = SCREENX / 20;
 
  Widget backButton, dropDownButton;

Toolbar(color toolbarColor)
{
  this.toolbarColor = toolbarColor;
  textFont(myFont);
  backButton = new Widget(MARGIN, MARGIN, TOOLBAR_WIDTH, TOOLBAR_HEIGHT - (2 * MARGIN), "", 100, myFont, EVENT_BACK_BUTTON );
  dropDownButton = new Widget(SCREENX - (MARGIN +  TOOLBAR_WIDTH), 2,TOOLBAR_WIDTH, TOOLBAR_HEIGHT - (2 * MARGIN), "", 100, myFont, EVENT_DROP );    

  
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