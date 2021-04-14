

import Foundation
struct Data_Event : Codable {
	let id : Int?
	let title : String?
	let category : Int?
	let start_date : String?
	let end_date : String?
	let start_time : String?
	let end_time : String?
	let survey_link : String?
	let location : String?
	let latitude : Double?
	let longitude : Double?
	let description : String?
	let cover_image : String?
	let event_files : [String]?
	let video_links : [Video_links]?
	let event_documents : [Event_documents]?
	let likes : Int?
	let is_public : Int?
	let created_at : String?
	let updated_at : String?
	let isliked : Int?
	let has_access : Int?
    let event_images : [Event_videos]?
    let event_videos : [Event_videos]?
	let ownerprofile : Ownerprofile?
	let travelinfo : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case title = "title"
		case category = "category"
		case start_date = "start_date"
		case end_date = "end_date"
		case start_time = "start_time"
		case end_time = "end_time"
		case survey_link = "survey_link"
		case location = "location"
		case latitude = "latitude"
		case longitude = "longitude"
		case description = "description"
		case cover_image = "cover_image"
		case event_files = "event_files"
		case video_links = "video_links"
		case event_documents = "event_documents"
		case likes = "likes"
		case is_public = "is_public"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case isliked = "isliked"
		case has_access = "has_access"
		case ownerprofile = "ownerprofile"
		case travelinfo = "travelinfo"
        case event_videos = "event_videos"
        case event_images = "event_images"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		category = try values.decodeIfPresent(Int.self, forKey: .category)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
		start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
		end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
		survey_link = try values.decodeIfPresent(String.self, forKey: .survey_link)
		location = try values.decodeIfPresent(String.self, forKey: .location)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		event_files = try values.decodeIfPresent([String].self, forKey: .event_files)
		video_links = try values.decodeIfPresent([Video_links].self, forKey: .video_links)
		event_documents = try values.decodeIfPresent([Event_documents].self, forKey: .event_documents)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		is_public = try values.decodeIfPresent(Int.self, forKey: .is_public)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		isliked = try values.decodeIfPresent(Int.self, forKey: .isliked)
		has_access = try values.decodeIfPresent(Int.self, forKey: .has_access)
		ownerprofile = try values.decodeIfPresent(Ownerprofile.self, forKey: .ownerprofile)
		travelinfo = try values.decodeIfPresent(String.self, forKey: .travelinfo)
        event_images = try values.decodeIfPresent([Event_videos].self, forKey: .event_images)
        event_videos = try values.decodeIfPresent([Event_videos].self, forKey: .event_videos)

	}

}
