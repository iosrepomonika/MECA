//
//  DataMaas.swift
//  MECA
//
//  Created by Macbook  on 13/04/21.
//

import Foundation
struct DataMaas : Codable {
    let cover_image : String?
    let created_at : String?
    let description : String?
    let document_links : [Maas_DocumentLinks]?
    let end_date : String?
    let id : Int?
    let is_admin : Int?
    let is_public : Int?
    let likes : Int?
    let kaizen_documents : [Maas_documents]?
    let kaizen_files : [Maas_files]?
    let ownerprofile : MaasOwnerprofile?
    let start_date : String?
    let status : Int?
    let title : String?
    let type : Int?
    let updated_at : String?
    let user : Int?
    let video_links : [Video_links]?
    let written_by : Int?
    let writerinfo : MaasWriterinfo?
    let writername : String?
    let type_lable : String?
    
    
 
    enum CodingKeys: String, CodingKey {
        case cover_image = "cover_image"
        case created_at = "created_at"
        case description = "description"
        case document_links = "document_links"
        case end_date = "end_date"
        case writername = "writer_name"
        case type_lable = "type_lable"
        case id = "id"
        case type = "type"
        case user = "user"
        case title = "title"
        
        case start_date = "start_date"
        
        
        case kaizen_files = "kaizen_files"
        case video_links = "video_links"
        case kaizen_documents = "kaizen_documents"
        
        case status = "status"
        case is_admin = "is_admin"
        case likes = "likes"
        case is_public = "is_public"
        case written_by = "written_by"
        
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
        writername = try values.decodeIfPresent(String.self, forKey: .writername)
        type_lable = try values.decodeIfPresent(String.self, forKey: .type_lable)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
        cover_image = try values.decodeIfPresent(String.self, forKey: .cover_image)
        kaizen_files = try values.decodeIfPresent([Maas_files].self, forKey: .kaizen_files)
        video_links = try values.decodeIfPresent([Video_links].self, forKey: .video_links)
        kaizen_documents = try values.decodeIfPresent([Maas_documents].self, forKey: .kaizen_documents)
        document_links = try values.decodeIfPresent([Maas_DocumentLinks].self, forKey: .document_links)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        is_admin = try values.decodeIfPresent(Int.self, forKey: .is_admin)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        is_public = try values.decodeIfPresent(Int.self, forKey: .is_public)
        written_by = try values.decodeIfPresent(Int.self, forKey: .written_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        ownerprofile = try values.decodeIfPresent(MaasOwnerprofile.self, forKey: .ownerprofile)
        writerinfo = try values.decodeIfPresent(MaasWriterinfo.self, forKey: .writerinfo)
    }

}
