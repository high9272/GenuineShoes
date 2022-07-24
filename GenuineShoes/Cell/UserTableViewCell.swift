//
//  UserTableViewCell.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/18.
//

import Foundation
import UIKit
import Firebase
import SDWebImage

class UserTableViewCell: UITableViewCell {
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "97menta")
//        imageView.backgroundColor = .tertiaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "high9412@naver.com"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    
    lazy var thumbsUpBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.contentMode = .scaleAspectFit
//        button.setTitle(" 정품같아요 ", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.label.cgColor
//        button.layer.cornerRadius = 5

        return button
        
    }()
    
    lazy var thumbsDownBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
//        button.contentMode = .scaleToFill
        
//        button.setTitle(" 가품같아요 ", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.label.cgColor
//        button.layer.cornerRadius = 5
        
 
        return button
        
    }()
    
    lazy var thumbsUpLabel: UILabel = {
        let label = UILabel()
        label.text = "1 thumbsUp"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
        
    }()
    
    
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    func configure() {
        guard let viewModel = viewModel else {return}
        captionLabel.text = viewModel.caption
        
        postImageView.sd_setImage(with: viewModel.imageUrl)
        
        
        
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [userEmailLabel, postImageView, thumbsUpBtn, thumbsDownBtn, captionLabel, thumbsUpLabel].forEach {contentView.addSubview($0)}
        
        
//        contentView.addSubview(userEmailLabel)
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
//        contentView.addSubview(postImageView)
        
        postImageView.snp.makeConstraints { make in
            //            make.width.equalTo(200)
//            make.height.equalTo(450)
            make.width.equalTo(contentView.frame.width)
            make.top.equalTo(userEmailLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(2)
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(thumbsUpBtn.snp.top).offset(-4)
            //            make.bottom.equalToSuperview()
        }
        
        thumbsUpBtn.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(4)
            make.height.equalTo(35)
            make.width.equalTo(35)
            
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-4)
            
        }
        thumbsDownBtn.snp.makeConstraints { make in
            make.top.equalTo(thumbsUpBtn.snp.bottom).offset(4)
            make.height.equalTo(35)
            make.width.equalTo(35)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-4)
        }
        
        thumbsUpLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(2)
        }
        
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbsUpLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalTo(thumbsUpBtn.snp.leading)
            make.bottom.equalToSuperview()
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
