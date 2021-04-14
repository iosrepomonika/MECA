

import Foundation
struct NewCarKaizenModel : Codable {
	let data : [DataKaizen]?
	let total : Int?
	let resp_code : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case total = "total"
		case resp_code = "resp_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([DataKaizen].self, forKey: .data)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
	}

}
