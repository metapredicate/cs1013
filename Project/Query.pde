import de.bezier.data.sql.*;
class Query
{
  String search;
  String type;
  String text, pieChartWords;
  PropertyEntry entry;
  BarChart chart;
  PieChart pChart;
  
  Query(String search, String type)
  {
    if (!type.equals("All")) {
      search = search.toUpperCase();
      this.search = "'"+search+"'";
      this.type = type;
    } else {
      this.search = "1";
      this.type = "1";
      println(000);
    }
    if (db.connect())
    {
      db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
    }
  }
  Query(String search)
  {
    this.search = search;
    this.search = this.search.toUpperCase();
    if (db.connect())
    {
      db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
    }
  }
  
  void draw() {
    if (chart!=null) 
    {
      chart.draw();
    }
    if (pChart!=null)
    {
      pChart.draw();
    } 
  }
  PropertyEntry getPropertyEntry() {
    String [] s = search.split("\\s*,\\s*");
    String [] tempArray = s[0].split(" ");
    if ((tempArray.length>1)&&(isStringInteger(tempArray[0]))) {
      db.query( "SELECT * FROM registry WHERE NumName = '"+ tempArray[1]+", "+ tempArray[0] +"' AND Street = '"+s[1]+"'");
    } else {
      db.query( "SELECT * FROM registry WHERE NumName = '" +s[0] +"' AND Street = '"+s[1]+"'");
    }
    String [] temp = new String[11];
    if (db.next()) {
      temp[0] = ""+db.getInt("Price");
      temp[1] = db.getString("Date");
      temp[2] = db.getString("Postcode");
      temp[3] = db.getString("Type");
      temp[4] = db.getString("OldNew");
      temp[5] = db.getString("NumName");
      temp[6] = db.getString("Street");
      temp[7] = db.getString("Locality");
      temp[8] = db.getString("Town");
      temp[9] = db.getString("District");
      temp[10] = db.getString("County");
      entry = new PropertyEntry(temp[0], temp[1], temp[2], temp[3], temp[4], temp[5], temp[6], temp[7], temp[8], temp[9], temp[10]);
      String test = entry.toString();
      println(test);
    }
    return entry;
  }
  ArrayList<PropertyEntry> getStreetEntries() {
    ArrayList<PropertyEntry> tempList = new ArrayList<PropertyEntry>(); 
    db.query( "SELECT * FROM registry WHERE Street = '"+search+"'");
    while (db.next()) {
      String [] temp = new String[11];
      temp[0] = ""+db.getInt("Price");
      temp[1] = db.getString("Date");
      temp[2] = db.getString("Postcode");
      temp[3] = db.getString("Type");
      temp[4] = db.getString("OldNew");
      temp[5] = db.getString("NumName");
      temp[6] = db.getString("Street");
      temp[7] = db.getString("Locality");
      temp[8] = db.getString("Town");
      temp[9] = db.getString("District");
      temp[10] = db.getString("County");
      entry = new PropertyEntry(temp[0], temp[1], temp[2], temp[3], temp[4], temp[5], temp[6], temp[7], temp[8], temp[9], temp[10]);
      String test = entry.toString();
      tempList.add(entry);
      println(test);
    }
    return tempList;
  }

  void displayPriceRange() {
    int increment = (int)(getMax()/10.0);
    float [] priceRange = new float[10];
    for (int i =0; i<10; i++) {
      int bottomRange = (increment*(i));
      int upperRange = (increment*(i+1/10));
      db.query("SELECT COUNT(Price) FROM registry WHERE "+type+" = "+search+" AND Price> "+bottomRange + " and Price <= "+upperRange);
      if(db.next())
      {
        priceRange[i] = db.getInt(1);
        println(priceRange[i] );
      }
    }
    histogramQuery = new Histogram(200, 200, 600, 360, priceRange, increment);
  }

  void displayAge() {
    float[] data = new float[2];
    data[0] = 0;
    data[1] = 0;
    String newlyBuilt = "Y";
    db.query( "SELECT * FROM registry WHERE "+type+" = "+search);
    while (db.next()) {
      if (newlyBuilt.equals(db.getString("OldNew")))
      {
        data[0]++;
      } else
      {
        data[1]++;
      }
    }
    pChart = new PieChart(200, 200, 200, data);
  }
  void displayHouseType() {
    float[] data = new float[5];
    for (int i=0; i<data.length; i++) {
      data[i]=0;
    }
    String detached = "D";
    String semiDetached = "S";
    String terraced = "T";
    String flats = "F";
    String other = "O";

    db.query( "SELECT * FROM registry WHERE "+type+" = "+search);
    while (db.next()) {
      String houseType = db.getString("Type");
      if (detached.equals(houseType))
      {
        data[0]++;
      } else if (semiDetached.equals(houseType))
      {
        data[1]++;
      } else if (terraced.equals(houseType))
      {
        data[2]++;
      } else if (flats.equals(houseType))
      {
        data[3]++;
      } else if (other.equals(houseType))
      {
        data[4]++;
      }
    }
    String[] key = {"Detached", "Semi-Detached", "Terraced", "Flats", "Other"};
    pChart = new PieChart(400, 400, 200, data, key);
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
    for (int i = 0; (i < 20); i++)
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
  boolean isStringInteger(String number ) {
    try {
      Integer.parseInt(number);
    }
    catch(Exception e ) {
      return false;
    }
    return true;
  }
}
