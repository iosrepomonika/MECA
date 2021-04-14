


import Foundation
struct MEBITDataModel : Codable {
    let id : Int?
    let type : Int?
    let user : Int?
    let title : String?
    let description : String?
    let cover_image : String?
    let start_date : String?
    let end_date : String?
    let is_admin : Int?
    let likes : Int?
    let created_at : String?
    let updated_at : String?
    let whatsnew_type : String?
    let whatsnew_type_lable : String?
    let writer_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case user = "user"
        case title = "title"
        case description = "description"
        case cover_image = "cover_image"
        case start_date = "start_date"
        case end_date = "end_date"
        case is_admin = "is_admin"
        case likes = "likes"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case whatsnew_type = "whatsnew_type"
        case whatsnew_type_lable = "whatsnew_type_lable"
        case writer_name = "writer_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        user = try values.decodeIfPresent(Int.self, forKey: .user)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        whatsnew_type = try values.decodeIfPresent(String.self, forKey: .whatsnew_type)
        whatsnew_type_lable = try values.decodeIfPresent(String.self, forKey: .whatsnew_type_lable)
        writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
    }

}
