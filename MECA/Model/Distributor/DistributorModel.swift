/* */

import Foundation
public class DistributorModel {
    public var id : Int?
    public var name : String?
    public var email : String?
    public var phone : String?
    public var logo : String?
    public var location : String?
    public var country : String?
    public var latitude : Double?
    public var longitude : Double?
    public var status : Int?
    public var created_at : String?
    public var updated_at : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [DistributorModel]
    {
        var models:[DistributorModel] = []
        for item in array
        {
            models.append(DistributorModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
    required public init?(dictionary: NSDictionary) {

        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        email = dictionary["email"] as? String
        phone = dictionary["phone"] as? String
        logo = dictionary["logo"] as? String
        location = dictionary["location"] as? String
        country = dictionary["country"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        status = dictionary["status"] as? Int
        created_at = dictionary["created_at"] as? String
        updated_at = dictionary["updated_at"] as? String
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.id, forKey: "id")
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.email, forKey: "email")
        dictionary.setValue(self.phone, forKey: "phone")
        dictionary.setValue(self.logo, forKey: "logo")
        dictionary.setValue(self.location, forKey: "location")
        dictionary.setValue(self.country, forKey: "country")
        dictionary.setValue(self.latitude, forKey: "latitude")
        dictionary.setValue(self.longitude, forKey: "longitude")
        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")

        return dictionary
    }

}
