


import Foundation
struct MEBITModel : Codable {
    let data : [MEBITDataModel]?
    let resp_code : Int?


    enum CodingKeys: String, CodingKey {

        case data = "data"
        case resp_code = "resp_code"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([MEBITDataModel].self, forKey: .data)
        resp_code = try values.decodeIfPresent(Int.self, forKey: .resp_code)

    }

}
