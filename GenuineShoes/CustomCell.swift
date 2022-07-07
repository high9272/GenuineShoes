//
//  customCell.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/01.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    static let identifier = "customCell"
    
    lazy var modelLabel: UILabel = {
        var label = UILabel()
        label.textColor = .label
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.textAlignment = .left
        label.sizeToFit()
        return label
        
    }()
    
    lazy var brandLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    lazy var snkImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
        
        
    }()
    
    lazy var rightImage: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.compact.right")
        imageView.tintColor = .label
        return imageView
    }()
    
    
    //    @IBOutlet weak var brandLabel: UILabel!
    //    @IBOutlet weak var snkImage: UIImageView!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        contentView.addSubview(modelLabel)
//        contentView.addSubview(snkImage)
//        contentView.addSubview(brandLabel)
//
        [modelLabel,snkImage,brandLabel,rightImage].forEach {contentView.addSubview($0)}
        
        setupLayout()
        
        
    }
    
    func setupLayout(){
        
        snkImage.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(150)
        }
        
        
        modelLabel.snp.makeConstraints { make in
            make.leading.equalTo(snkImage.snp.trailing)
            make.centerY.equalTo(snkImage.snp.centerY)
            make.height.equalTo(100)
            make.trailing.equalTo(rightImage.snp.leading)
        }
        
        brandLabel.snp.makeConstraints { make in
            make.bottom.equalTo(modelLabel.snp.top).offset(10)
            make.leading.equalTo(snkImage.snp.trailing).offset(4)
        }
        
        rightImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(4)
            //make.top.equalToSuperview().offset(30)
//            make.left.equalTo(modelLabel.snp.trailing)
            make.centerY.equalTo(contentView)
            make.height.width.equalTo(15)
        }
        //accessoryType = .disclosureIndicator
        

        
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
