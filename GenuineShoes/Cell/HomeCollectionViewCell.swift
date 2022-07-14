//
//  HomeCollectionViewCell.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/14.
//

import Foundation
import UIKit
import SnapKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    
    lazy var modelLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        return label
        
    }()
    
    lazy var brandLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var snkImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
        
        
    }()
    
    
    
}
extension HomeCollectionViewCell {
    func cellSetupLayout(){
        [modelLabel, snkImage, brandLabel].forEach{contentView.addSubview($0)}
        
        brandLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        snkImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.top.equalTo(brandLabel.snp.bottom).offset(2)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalTo(modelLabel.snp.top).offset(2)
        }
        
        modelLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.top.equalTo(snkImage.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-3)
        }
        
        
    }
}
