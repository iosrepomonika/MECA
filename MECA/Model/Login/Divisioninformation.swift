

import Foundation
struct Divisioninformation : Codable {
	let id : Int?
	let distributor : Int?
	let division_name : String?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case distributor = "distributor"
		case division_name = "division_name"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		distributor = try values.decodeIfPresent(Int.self, forKey: .distributor)
		division_name = try values.decodeIfPresent(String.self, forKey: .division_name)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
