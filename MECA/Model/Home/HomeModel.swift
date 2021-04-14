

import Foundation
struct HomeModel : Codable {
	let data : [Data_Home]?
	let resp_code : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case resp_code = "resp_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([Data_Home].self, forKey: .data)
		resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
	}

}
