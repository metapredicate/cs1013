class Map {
  GeoMap geoMap;
  Map(PApplet thisApplet)
  {
    geoMap = new GeoMap(0,0,height,height,thisApplet);
    geoMap.readFile("GBR_adm2");

    textAlign(LEFT, BOTTOM);
    textSize(18);
  }

  void draw()
  {
    background(OCEAN_BLUE);  
    stroke(0, 40);             

    fill(SHAMROCK_GREEN);        
    geoMap.draw();              

    int id = geoMap.getID(mouseX, mouseY);
    if ((id != -1)&&((id<113)||(id>170)))
    {
      fill(180, 120, 120);
      geoMap.draw(id);
      String name = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME_2");    
      fill(0);
      text(name, mouseX+5, mouseY-5);
    }

  }
  void mousePressed() {
    int id = geoMap.getID(mouseX, mouseY);
    if ((id != -1)&&((id<113)||(id>170)))
    {
      String isLondon = geoMap.getAttributeTable().findRow(str(id), 0).getString("TYPE_2");
      String name;
      if(isLondon.equals("London Borough")){
        name = "GREATER LONDON";
      }
      else{ 
        name = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME_2");  
      }
      println(name);
      search = name;
      type = "County";
      currentQuery = new Query(search, type);
      currentScreen = townQueryScreen;
    }
  }

}