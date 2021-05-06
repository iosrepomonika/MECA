//
//  Maas_documents.swift
//  MECA
//
//  Created by Macbook  on 13/04/21.
//

import Foundation
struct Maas_documents : Codable {
    let filetype : String?
    let name : String?
    let info : String?
    let file : String?
    let ownerprofile : String?

    enum CodingKeys: String, CodingKey {

        case filetype = "filetype"
        case name = "name"
        case info = "info"
        case file = "file"
        case ownerprofile = "ownerprofile"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filetype = try values.decodeIfPresent(String.self, forKey: .filetype)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        info = try values.decodeIfPresent(String.self, forKey: .info)
        file = try values.decodeIfPresent(String.self, forKey: .file)
        ownerprofile = try values.decodeIfPresent(String.self, forKey: .ownerprofile)
    }

}
