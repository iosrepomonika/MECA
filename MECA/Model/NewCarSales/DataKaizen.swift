

import Foundation
struct DataKaizen : Codable {
	let id : Int?
	let type : Int?
	let user : Int?
	let title : String?
	let description : String?
	let start_date : String?
	let end_date : String?
	let cover_image : String?
	let kaizen_files : [Kaizen_files]?
	let video_links : [Video_links]?
	let kaizen_documents : [Kaizen_documents]?
    let document_links : [Kaizen_DocumentLinks]?
	let status : Int?
	let is_admin : Int?
	let likes : Int?
	let is_public : Int?
	let written_by : Int?
	let created_at : String?
	let updated_at : String?
	let ownerprofile : OwnerprofileNewCar?
	let writerinfo : WriterinfoNewCar?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case type = "type"
		case user = "user"
		case title = "title"
		case description = "description"
		case start_date = "start_date"
		case end_date = "end_date"
		case cover_image = "cover_image"
		case kaizen_files = "kaizen_files"
		case video_links = "video_links"
		case kaizen_documents = "kaizen_documents"
		case document_links = "document_links"
		case status = "status"
		case is_admin = "is_admin"
		case likes = "likes"
		case is_public = "is_public"
		case written_by = "written_by"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case ownerprofile = "ownerprofile"
		case writerinfo = "writerinfo"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		type = try values.decodeIfPresent(Int.self, forKey: .type)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		kaizen_files = try values.decodeIfPresent([Kaizen_files].self, forKey: .kaizen_files)
		video_links = try values.decodeIfPresent([Video_links].self, forKey: .video_links)
		kaizen_documents = try values.decodeIfPresent([Kaizen_documents].self, forKey: .kaizen_documents)
		document_links = try values.decodeIfPresent([Kaizen_DocumentLinks].self, forKey: .document_links)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		is_public = try values.decodeIfPresent(Int.self, forKey: .is_public)
		written_by = try values.decodeIfPresent(Int.self, forKey: .written_by)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		ownerprofile = try values.decodeIfPresent(OwnerprofileNewCar.self, forKey: .ownerprofile)
		writerinfo = try values.decodeIfPresent(WriterinfoNewCar.self, forKey: .writerinfo)
	}

}
