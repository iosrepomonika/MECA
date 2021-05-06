//
//  MaasWriterinfo.swift
//  MECA
//
//  Created by Macbook  on 13/04/21.
//

import UIKit

class MaasWriterinfo: Codable {
    
    let id : Int?
    let email : String?
    let phone : String?
    let name : String?
    let logo : String?
    let location : String?
    let country : String?
    let latitude : Double?
    let longitude : Double?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case email = "email"
        case phone = "phone"
        case name = "name"
        case logo = "logo"
        case location = "location"
        case country = "country"
        case latitude = "latitude"
        case longitude = "longitude"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        logo = try values.decodeIfPresent(String.self, forKey: .logo)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        country = try values.decodeIfPresent(String.self, forKey: .country)
    }

}
