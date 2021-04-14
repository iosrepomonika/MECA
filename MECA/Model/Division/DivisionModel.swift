

import Foundation
public class DivisionModel {
    public var id : Int?
    public var distributor : Int?
    public var division_name : String?
    public var created_at : String?
    public var updated_at : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [DivisionModel]
    {
        var models:[DivisionModel] = []
        for item in array
        {
            models.append(DivisionModel(dictionary: item as! NSDictionary)!)
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
        distributor = dictionary["distributor"] as? Int
        division_name = dictionary["division_name"] as? String
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
        dictionary.setValue(self.distributor, forKey: "distributor")
        dictionary.setValue(self.division_name, forKey: "division_name")
        dictionary.setValue(self.created_at, forKey: "created_at")
        dictionary.setValue(self.updated_at, forKey: "updated_at")

        return dictionary
    }

}
