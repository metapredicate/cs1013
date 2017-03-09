class PropertyEntry
{
  String price, numName;
  String postcode, dateOfSale, street, locality, town, district, county, propertyType, oldOrNew;

  
   PropertyEntry(String price, String dateOfSale, String postcode, String propertyType, 
                 String oldOrNew, String numName, String street,
                 String locality, String town, String district, String county)
   {
       this.dateOfSale = ((dateOfSale == null)? "" : dateOfSale);
       this.postcode = ((postcode == null)? "" : postcode);
       this.propertyType = ((propertyType == null)? "" : propertyType);
       this.oldOrNew = ((oldOrNew == null)? "" : oldOrNew);
       this.street = ((street == null)? "" : street);
       this.locality = ((locality == null)? "" : locality);
       this.town = ((town == null)? "" : town);
       this.district = ((district == null)? "" : district);
       this.county = ((county == null)? "" : county);
       this.price = ((price == null)? "" : price);
       this.numName = ((numName == null)? "" : numName);
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
   return ("" + dateOfSale + " " + postcode + " " + propertyType + " " + oldOrNew + " " + numName + " " + street + " " + locality + " " + town + " " + district + " " + county + " £" + price);
 }
}