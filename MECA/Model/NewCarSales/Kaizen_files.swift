
import Foundation
struct Kaizen_files : Codable {
	let filetype : String?
	let file : String?

	enum CodingKeys: String, CodingKey {

		case filetype = "filetype"
		case file = "file"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		filetype = try values.decodeIfPresent(String.self, forKey: .filetype)
		file = try values.decodeIfPresent(String.self, forKey: .file)
	}

}
