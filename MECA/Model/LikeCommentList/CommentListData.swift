

import Foundation
struct CommentListData : Codable {
	let id : Int?
	let module : Int?
	let item : Int?
	let isfile : Int?
	let parent : Int?
	let is_reply : Int?
	let reply_for : Int?
	let comment : String?
	let created_at : String?
	let updated_at : String?
	let showreply : Int?
	let writer_name : String?
	let subcomments : [Subcomments]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case module = "module"
		case item = "item"
		case isfile = "isfile"
		case parent = "parent"
		case is_reply = "is_reply"
		case reply_for = "reply_for"
		case comment = "comment"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case showreply = "showreply"
		case writer_name = "writer_name"
		case subcomments = "subcomments"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		module = try values.decodeIfPresent(Int.self, forKey: .module)
		item = try values.decodeIfPresent(Int.self, forKey: .item)
		isfile = try values.decodeIfPresent(Int.self, forKey: .isfile)
		parent = try values.decodeIfPresent(Int.self, forKey: .parent)
		is_reply = try values.decodeIfPresent(Int.self, forKey: .is_reply)
		reply_for = try values.decodeIfPresent(Int.self, forKey: .reply_for)
		comment = try values.decodeIfPresent(String.self, forKey: .comment)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		showreply = try values.decodeIfPresent(Int.self, forKey: .showreply)
		writer_name = try values.decodeIfPresent(String.self, forKey: .writer_name)
		subcomments = try values.decodeIfPresent([Subcomments].self, forKey: .subcomments)
	}

}
