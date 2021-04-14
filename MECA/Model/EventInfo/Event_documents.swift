

import Foundation
struct Event_documents : Codable {
	let filetype : String?
	let name : String?
	let info : String?
	let file : String?

	enum CodingKeys: String, CodingKey {

		case filetype = "filetype"
		case name = "name"
		case info = "info"
		case file = "file"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		filetype = try values.decodeIfPresent(String.self, forKey: .filetype)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		info = try values.decodeIfPresent(String.self, forKey: .info)
		file = try values.decodeIfPresent(String.self, forKey: .file)
	}

}
