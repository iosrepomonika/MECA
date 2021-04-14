
import UIKit

struct Kaizen_DocumentLinks : Codable {
    let name : String?
    let info : String?
    let link : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case info = "info"
        case link = "link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        info = try values.decodeIfPresent(String.self, forKey: .info)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }

}
