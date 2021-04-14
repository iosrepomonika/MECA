

import Foundation
struct Event_videos : Codable {
	let name : String?
	let filetype : String?
	let file : String?

	enum CodingKeys: String, CodingKey {

		case name = "name"
		case filetype = "filetype"
		case file = "file"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		filetype = try values.decodeIfPresent(String.self, forKey: .filetype)
		file = try values.decodeIfPresent(String.self, forKey: .file)
	}

}
