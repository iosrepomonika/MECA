
import Foundation
struct LoginUserModel : Codable {
	let id : Int?
	let distributor : Int?
	let division : Int?
	let first_name : String?
	let last_name : String?
	let email : String?
	let phone : String?
	let avatar : String?
	let firebaseid : String?
	let firebasepassword : String?
	let status : Int?
	let comments : String?
	let reset_token : String?
	let last_call_at : Int?
	let created_at : String?
	let updated_at : String?
	let token : String?
	let unread : Int?
	let distributorinformation : Distributorinformation?
	let divisioninformation : Divisioninformation?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case distributor = "distributor"
		case division = "division"
		case first_name = "first_name"
		case last_name = "last_name"
		case email = "email"
		case phone = "phone"
		case avatar = "avatar"
		case firebaseid = "firebaseid"
		case firebasepassword = "firebasepassword"
		case status = "status"
		case comments = "comments"
		case reset_token = "reset_token"
		case last_call_at = "last_call_at"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case token = "token"
		case unread = "unread"
		case distributorinformation = "distributorinformation"
		case divisioninformation = "divisioninformation"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		distributor = try values.decodeIfPresent(Int.self, forKey: .distributor)
		division = try values.decodeIfPresent(Int.self, forKey: .division)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
		firebaseid = try values.decodeIfPresent(String.self, forKey: .firebaseid)
		firebasepassword = try values.decodeIfPresent(String.self, forKey: .firebasepassword)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		comments = try values.decodeIfPresent(String.self, forKey: .comments)
		reset_token = try values.decodeIfPresent(String.self, forKey: .reset_token)
		last_call_at = try values.decodeIfPresent(Int.self, forKey: .last_call_at)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		unread = try values.decodeIfPresent(Int.self, forKey: .unread)
		distributorinformation = try values.decodeIfPresent(Distributorinformation.self, forKey: .distributorinformation)
		divisioninformation = try values.decodeIfPresent(Divisioninformation.self, forKey: .divisioninformation)
	}

}
