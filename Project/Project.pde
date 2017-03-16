import org.gicentre.utils.stat.*;
import de.bezier.data.sql.*;
PFont myFont;
PropertyEntry[] propertyArray;
SQLite db;
BarChart barChart;
void settings() 
{
  size(SCREENX, SCREENY);
}
void setup() 
{
  myFont = loadFont("Serif.plain-15.vlw");
  barChart = new BarChart(this);
  db = new SQLite(this, "landdata.db");
  if (db.connect())
  {
    db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
  }
  while (db.next())
  {
    println( db.getString("Name") );
  }
  db.query( "SELECT * FROM test" );
  float [] temp = new float[NUMBER_OF_ENTRIES];
  for (int i=0; i<NUMBER_OF_ENTRIES; i++)
  {
    if (db.next()) {
      temp[i] = parseFloat(db.getString("price"));
    }
  }
  barChart.setBarColour(color(200,80,80,150));
  barChart.setData(temp);
  
}

void draw() 
{
  background(255);
  barChart.draw(15, 15, width-30, height-30);
}