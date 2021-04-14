

import Foundation
struct MedbiListModel : Codable {
	let data : [MedbiList]?
	let pdf_links : Pdf_links?
	let resp_code : Int?

	enum CodingKeys: String, CodingKey {

		case data = "data"
		case pdf_links = "pdf_links"
		case resp_code = "resp_code"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		data = try values.decodeIfPresent([MedbiList].self, forKey: .data)
		pdf_links = try values.decodeIfPresent(Pdf_links.self, forKey: .pdf_links)
		resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)
	}

}
