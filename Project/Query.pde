import de.bezier.data.sql.*;
class Query
{
  String search;
  String type;
  String text;
  PropertyEntry entry;
  SQLite db;
  BarChart chart;
  Query(String search, String type, SQLite data)
  {
    if (!type.equals("All")) {
      search.toUpperCase();
      this.search = "'"+search+"'";
      this.type = type;
    }
    else {
      this.search = "1";
      this.type = "1";
      println(000);
    }

    this.db=data;

    if (db.connect())
    {
      db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
    }
    while (db.next())
    {
      println( db.getString("Name") );
    }
  }
  void draw() {
    if (chart!=null) 
    {
      chart.draw();
    }
    if (text != null)
    {
      text(text, SCREENX / 2, SCREENY / 4); 
    }
  }
  PropertyEntry getPropertyEntry(String input) {
    
    return entry;
  }
   
  void displayTop(int numberToReturn) {
    db.query( "SELECT * FROM registry WHERE "+type+" = "+search+" ORDER BY Price DESC LIMIT "+numberToReturn );
    float [] temp = new float[numberToReturn];
    for (int i=0; i<numberToReturn; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
      }
    }
    chart = new BarChart(200, 200, 600, 360, temp);
  }
  void displayBottom(int numberToReturn) {
    db.query( "SELECT * FROM registry WHERE "+type+" = "+search+" ORDER BY Price ASC LIMIT "+numberToReturn );
    float [] temp = new float[numberToReturn];
    for (int i=0; i<numberToReturn; i++)
    {
      if (db.next()) {
        temp[i] = parseFloat(db.getInt("Price"));
      }
    }
    chart = new BarChart(200, 200, 600, 360, temp);
  }
  void displayAverageOverTime() {
    float[] average = new float[20];
    for (int i=0; i<20; i++) {
      db.query("SELECT AVG(Price) From registry WHERE "+type+" = "+search+" AND Date>='"+(1995+i)+"-01-01' and Date< '"+(1996+i)+"-01-01'");
      if (db.next()) {
        average[i] = db.getFloat(1);
        println(average+" "+(1995+i));
      }
    }
    String[] xAxis = new String[20];
    for(int i = 0;(i < 20);i++)
    {
      int year = 1995 + i;
      xAxis[i] = ("" + year);
    }
    chart = new BarChart(200, 200, 600, 360, xAxis, average, true);
  }
  void displayStats() {
    float average = getAverage();
    float min = getMin();
    float max = getMax();
    float range = getRange();
    float[] stats = {min, max, range, average};
    float[] xAxix = {1, 2, 3, 4};
    //chart = new BarChart(200, 200, 600, 360, xAxix, stats);
    String text = "" + search + "\nAverage Price (All Time): " + average
      + "\nLowest Priced Transaction: " + min + "\nHighest Priced Transaction: " + max 
      + "\nPrice Range: " + range;
  }
  float getAverage() {
    int average=0;
    db.query("SELECT AVG(Price) From registry WHERE "+type+" = "+search+"");
    if (db.next())
      average = db.getInt(1);
    return float(average);
  }
  float getMin() {
    float min =0;
    db.query("SELECT MIN(Price) From registry WHERE "+type+" = "+search+"");
    if (db.next())
      min = db.getInt(1);
    return min;
  }
  float getMax() {
    float max =0;
    db.query("SELECT MAX(Price) From registry WHERE "+type+" = "+search+"");
    if (db.next())
      max = db.getInt(1);
    return max;
  }

  float getRange() {
    float range = getMax()-getMin();
    println(range+" range");
    return range;
  }
}