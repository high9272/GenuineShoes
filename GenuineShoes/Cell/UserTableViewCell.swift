//
//  UserTableViewCell.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/18.
//

import Foundation
import UIKit
import Firebase

class UserTableViewCell: UITableViewCell {
    

    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "97menta")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(myImageView)
        
        myImageView.snp.makeConstraints { make in
//            make.width.equalTo(200)
            make.height.equalTo(100)
            make.top.equalTo(5)
            make.leading.equalTo(5)
//            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
