

import Foundation
struct Pdf_links : Codable {
	let what_is_mebit : String?
	let over_all_schedule : String?

	enum CodingKeys: String, CodingKey {

		case what_is_mebit = "what_is_mebit"
		case over_all_schedule = "over_all_schedule"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		what_is_mebit = try values.decodeIfPresent(String.self, forKey: .what_is_mebit)
		over_all_schedule = try values.decodeIfPresent(String.self, forKey: .over_all_schedule)
	}

}
