/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct GRDetail_Data : Codable {
	let cover_image : String?
	let created_at : String?
	let description : String?
	let document_links : [GRDocument_links]?
	let end_date : String?
	let event_documents : [Event_documents]?
	let event_images : [Event_videos]?
	let event_videos : [Event_videos]?
	let has_access : Int?
	let id : Int?
	let is_admin : Int?
	let is_public : Int?
	let isliked : Int?
	let likes : Int?
	let start_date : String?
	let status : Int?
	let title : String?
	let type : Int?
	let updated_at : String?
	let user : Int?
	let video_links : [Video_links]?
	let written_by : Int?
    let comments_count : Int?

	enum CodingKeys: String, CodingKey {

		case cover_image = "cover_image"
		case created_at = "created_at"
		case description = "description"
		case document_links = "document_links"
		case end_date = "end_date"
		case event_documents = "event_documents"
		case event_images = "event_images"
		case event_videos = "event_videos"
		case has_access = "has_access"
		case id = "id"
		case is_admin = "is_admin"
		case is_public = "is_public"
		case isliked = "isliked"
		case likes = "likes"
		case start_date = "start_date"
		case status = "status"
		case title = "title"
		case type = "type"
		case updated_at = "updated_at"
		case user = "user"
		case video_links = "video_links"
		case written_by = "written_by"
        case comments_count = "comments_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		document_links = try values.decodeIfPresent([GRDocument_links].self, forKey: .document_links)
		end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
		event_documents = try values.decodeIfPresent([Event_documents].self, forKey: .event_documents)
		event_images = try values.decodeIfPresent([Event_videos].self, forKey: .event_images)
		event_videos = try values.decodeIfPresent([Event_videos].self, forKey: .event_videos)
		has_access = try values.decodeIfPresent(Int.self, forKey: .has_access)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
		is_public = try values.decodeIfPresent(Int.self, forKey: .is_public)
		isliked = try values.decodeIfPresent(Int.self, forKey: .isliked)
		likes = try values.decodeIfPresent(Int.self, forKey: .likes)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		type = try values.decodeIfPresent(Int.self, forKey: .type)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		user = try values.decodeIfPresent(Int.self, forKey: .user)
		video_links = try values.decodeIfPresent([Video_links].self, forKey: .video_links)
		written_by = try values.decodeIfPresent(Int.self, forKey: .written_by)
        comments_count = try values.decodeIfPresent(Int.self, forKey: .comments_count)
	}

}
