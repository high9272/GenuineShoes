//
//  HomeCollectionHeaderView.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/14.
//

import Foundation
import UIKit
import SnapKit

class HomeCollectionHeaderView: UICollectionReusableView {
    
//    lazy var myView: UIView = {
//        let uiView = UIView()
//        uiView.backgroundColor = .systemBackground
//        uiView.layer.cornerRadius = 10
//        uiView.layer.borderWidth = 1
//        uiView.layer.borderColor = UIColor.label.cgColor
//
//        return uiView
//    }()
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Copperplate-Bold", size: 25)
        label.text = "GenuineShoes"
        return label
    }()
    
    
    
    func setup(){
        [myLabel].forEach{addSubview($0)}
        
        myLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.bottom.equalToSuperview()
            
        }
        
        
//        myView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
////            make.width.equalTo(200)
////            make.height.equalTo(100)
//
//        }
    }
}
