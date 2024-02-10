//
//  ApodModel.swift
//
//
//  Created by Shrish Deshpande on 10/02/24.
//

import Foundation

struct ApodModel: Codable {
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let service_version: String
    let title: String
    let url: String
}
