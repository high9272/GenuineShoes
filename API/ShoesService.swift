//
//  ShoesService.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/12.
//

import Foundation
import Firebase
import FirebaseDatabase
import CodableFirebase

//struct ShoesService {
//    static func fetchData() {
//
//        db.observeSingleEvent(of: .value) { snapshot  in
//            print(snapshot)
//            guard let snapData = snapshot.value as? [String: AnyObject] else {return}
//            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
//
//            do{
//                let decoder = JSONDecoder()
//                let moelList: [ShoesModel] = try
//                decoder.decode([ShoesModel].self, from: data)
//
//                DispatchQueue.main.async {
//
//                }
//            }catch let error {
//                print("\(error)")
//            }
//
//        }
//
//
//    }
//
//}
