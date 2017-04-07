import java.util.Scanner;
class DateOfSale
{
  int year;
  int month;
  String monthName;
  int day;

  DateOfSale(String entry)
  {
    String dateString;  
    int date;
    String monthString; 
    int month;
    String yearString;  
    int year;
    Scanner entryScanner = new Scanner(entry);
    entryScanner.useDelimiter("/");


    dateString = entryScanner.next();
    day = (int) Integer.parseInt(dateString);
    //System.out.println(date);
    monthString = entryScanner.next();
    month = Integer.parseInt(monthString);

    yearString = "20"+entryScanner.next();
    year = Integer.parseInt(yearString);
  }
}