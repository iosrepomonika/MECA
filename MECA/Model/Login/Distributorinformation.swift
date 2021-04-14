

import Foundation
struct Distributorinformation : Codable {
	let id : Int?
	let name : String?
	let email : String?
	let phone : String?
	let logo : String?
	let location : String?
	let country : String?
	let latitude : Double?
	let longitude : Double?
	let status : Int?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case email = "email"
		case phone = "phone"
		case logo = "logo"
		case location = "location"
		case country = "country"
		case latitude = "latitude"
		case longitude = "longitude"
		case status = "status"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		logo = try values.decodeIfPresent(String.self, forKey: .logo)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
