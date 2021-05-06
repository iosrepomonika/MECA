
import Foundation
struct GRHomeLis_Data : Codable {
	let id : Int?
	let title : String?
	let description : String?
	let cover_image : String?
	let created_at : String?
	let user : Int?
	let is_admin : Int?
	let writer_name : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case description = "description"
		case cover_image = "cover_image"
		case created_at = "created_at"
		case user = "user"
		case is_admin = "is_admin"
		case writer_name = "writer_name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
		is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
		writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
	}

}
