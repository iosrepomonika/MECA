

import Foundation
struct KaizenVideoLinkModel : Codable {
    let link : String?
    let title : String?
    let info : String?

    enum CodingKeys: String, CodingKey {

        case link = "link"
        case title = "title"
        case info = "info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        info = try values.decodeIfPresent(String.self, forKey: .info)
    }

}
