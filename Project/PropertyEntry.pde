class PropertyEntry
{
  int price, numName;
  String postcode, dateOfSale, street, locality, town, district, county, propertyType, oldOrNew;

  
   PropertyEntry(String price, String dateOfSale, String postcode, String propertyType, 
                 String oldOrNew, String numName, String street,
                 String locality, String town, String district, String county)
   {
       this.dateOfSale = dateOfSale;
       this.postcode = postcode;
       this.propertyType = propertyType;
       this.oldOrNew = oldOrNew;
       this.street = street;
       this.locality = locality;
       this.town = town;
       this.district = district;
       this.county = county;
       
       this.price =  Integer.parseInt(price);
       this.numName = Integer.parseInt(numName);
       
   }
     
 int getNumName()
 {
     return numName;  
 }
 
 String getStreet()
 {
   return street;
 }
}