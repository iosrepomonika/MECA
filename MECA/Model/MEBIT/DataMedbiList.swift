
import Foundation
struct MedbiList : Codable {
	let id : Int?
	let title : String?
	let survey_link : String?
	let location : String?
	let description : String?
	let cover_image : String?
	let start_date : String?
	let end_date : String?
	let latitude : Double?
	let longitude : Double?
	let start_time : String?
	let end_time : String?
	let likes : Int?
	let category : Int?
	let created_at : String?
	let updated_at : String?
	let whatsnew_type : String?
	let whatsnew_type_lable : String?
	let writer_name : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case survey_link = "survey_link"
		case location = "location"
		case description = "description"
		case cover_image = "cover_image"
		case start_date = "start_date"
		case end_date = "end_date"
		case latitude = "latitude"
		case longitude = "longitude"
		case start_time = "start_time"
		case end_time = "end_time"
		case likes = "likes"
		case category = "category"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case whatsnew_type = "whatsnew_type"
		case whatsnew_type_lable = "whatsnew_type_lable"
		case writer_name = "writer_name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		survey_link = try values.decodeIfPresent(String.self, forKey: .survey_link)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		category = try values.decodeIfPresent(Int.self, forKey: .category)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		whatsnew_type = try values.decodeIfPresent(String.self, forKey: .whatsnew_type)
		whatsnew_type_lable = try values.decodeIfPresent(String.self, forKey: .whatsnew_type_lable)
		writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
	}

}
