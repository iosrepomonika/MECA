

import Foundation
struct Data_MEBITCat : Codable {
	let event : [Event_MEBITCat]?
	let kaizen : [Kaizen_MEBITCat]?
	let maas : [Maas_MEBITCat]?
	let sdgs : [Sdgs_MEBITCat]?
	let hydrogen : [Hydrogen_MEBITCat]?
	let news : [News_MEBITCat]?
	let tags : [String]?
	let videos : [String]?
    let sorting_options : [Sorting_options]?
    let modules : [Modules]?
    
	enum CodingKeys: String, CodingKey {

		case event = "event"
		case kaizen = "kaizen"
		case maas = "maas"
		case sdgs = "sdgs"
		case hydrogen = "hydrogen"
		case news = "news"
		case tags = "tags"
		case videos = "videos"
        case sorting_options = "sorting_options"
        case modules = "modules"
        
    }

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		event = try values.decodeIfPresent([Event_MEBITCat].self, forKey: .event)
		kaizen = try values.decodeIfPresent([Kaizen_MEBITCat].self, forKey: .kaizen)
		maas = try values.decodeIfPresent([Maas_MEBITCat].self, forKey: .maas)
		sdgs = try values.decodeIfPresent([Sdgs_MEBITCat].self, forKey: .sdgs)
		hydrogen = try values.decodeIfPresent([Hydrogen_MEBITCat].self, forKey: .hydrogen)
		news = try values.decodeIfPresent([News_MEBITCat].self, forKey: .news)
		tags = try values.decodeIfPresent([String].self, forKey: .tags)
		videos = try values.decodeIfPresent([String].self, forKey: .videos)
        sorting_options = try values.decodeIfPresent([Sorting_options].self, forKey: .sorting_options)
        modules = try values.decodeIfPresent([Modules].self, forKey: .modules)
	}

}
