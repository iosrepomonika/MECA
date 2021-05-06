
import Foundation
struct GRDocument_links : Codable {
	let link : String?
	let name : String?
	let info : String?

	enum CodingKeys: String, CodingKey {

		case link = "link"
		case name = "name"
		case info = "info"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		info = try values.decodeIfPresent(String.self, forKey: .info)
	}

}
