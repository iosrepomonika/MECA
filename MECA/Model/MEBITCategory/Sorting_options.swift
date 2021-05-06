//
//


import Foundation
struct Sorting_options : Codable {
    let lable : String?
    let sortkey : String?
    let sortorder : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case lable = "lable"
        case sortkey = "sortkey"
        case sortorder = "sortorder"
        case icon = "icon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lable = try values.decodeIfPresent(String.self, forKey: .lable)
        sortkey = try values.decodeIfPresent(String.self, forKey: .sortkey)
        sortorder = try values.decodeIfPresent(String.self, forKey: .sortorder)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }

}


