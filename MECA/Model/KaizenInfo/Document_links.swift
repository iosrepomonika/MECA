

import Foundation
struct Document_links : Codable {
	let title : String?
	let info : String?
	let link : String?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case info = "info"
		case link = "link"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		info = try values.decodeIfPresent(String.self, forKey: .info)
		link = try values.decodeIfPresent(String.self, forKey: .link)
	}

}
