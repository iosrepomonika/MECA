

import Foundation
struct Video_links : Codable {
	let link : String?
	let title : String?
	let info : String?
	let ShashKey : String?

	enum CodingKeys: String, CodingKey {

		case link = "link"
		case title = "title"
		case info = "info"
		case ShashKey = "$hashKey"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		link = try values.decodeIfPresent(String.self, forKey: .link)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		info = try values.decodeIfPresent(String.self, forKey: .info)
		ShashKey = try values.decodeIfPresent(String.self, forKey: .ShashKey)
	}

}
