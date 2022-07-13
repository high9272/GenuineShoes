//
//  ShoesModel.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/02.
//
import UIKit
import Foundation
//import Firebase
//import CodableFirebase


struct ShoesModel: Codable {
    
    var modelName: String
    var nick: String
    var imageUrl: String?
    var brandName: String
    //var legiturl: String?
    var detail: Detail

    
}
struct Detail: Codable {
    var legiturl: String
}

