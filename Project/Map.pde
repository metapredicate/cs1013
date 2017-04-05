class Map {
  GeoMap geoMap;
  Map(PApplet thisApplet)
  {
    geoMap = new GeoMap(thisApplet);
    geoMap.readFile("GBR_adm2");

    // Set up text appearance.
    textAlign(LEFT, BOTTOM);
    textSize(18);

    // Display the first 5 rows of attributes in the console.
    geoMap.writeAttributesAsTable(200);
  }

  void draw()
  {
    background(202, 226, 245);  // Ocean colour
    stroke(0, 40);              // Boundary colour

    // Draw entire world map.
    fill(206, 173, 146);        // Land colour
    geoMap.draw();              // Draw the entire map.

    // Query the country at the mouse position.
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
      String name = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME_2");    
      
      name.toUpperCase();
      println(name);
      search = name;
      type = "County";
      currentQuery = new Query(search, type, db);
      currentScreen = townSelectScreen;
    }
  }
}