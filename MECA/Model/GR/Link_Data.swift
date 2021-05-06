

import Foundation
struct Link_Data : Codable {
	let id : Int?
	let title : String?
	let icon : String?
	let href : String?
	let created_at : String?
	let updated_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case icon = "icon"
		case href = "href"
		case created_at = "created_at"
		case updated_at = "updated_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		href = try values.decodeIfPresent(String.self, forKey: .href)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
	}

}
