class PropertyEntry
{
  int price;
  String postcode, dateOfSale, street, locality, town, district, county, propertyType, oldOrNew, numName;

  
   PropertyEntry(String price, String dateOfSale, String postcode, String propertyType, 
                 String oldOrNew, String numName, String street,
                 String locality, String town, String district, String county)
   {
       this.price = Integer.parseInt((price == null)? "" : price);
       this.dateOfSale = ((dateOfSale == null)? "" : dateOfSale);
       this.postcode = ((postcode == null)? "" : postcode);
       this.propertyType = ((propertyType == null)? "" : propertyType);
       this.oldOrNew = ((oldOrNew == null)? "" : oldOrNew);
       this.numName = ((numName == null)? "" : numName);
       this.street = ((street == null)? "" : street);
       this.locality = ((locality == null)? "" : locality);
       this.town = ((town == null)? "" : town);
       this.district = ((district == null)? "" : district);
       this.county = ((county == null)? "" : county);
   }
     
 String getNumName()
 {
     return numName;  
 }
 
 String getStreet()
 {
   return street;
 }
 
 String toString()
 {
   return (" £" + price + " " + dateOfSale + " " + postcode + " " + propertyType + " " + oldOrNew + " " + numName + " " + street + " " + locality + " " + town + " " + district + " " + county);
 }
}