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

protocol FeedCellDelegate {
    func cell (_ cell: UserTableViewCell, didLike post: PostModel)
    func cell (_ cell: UserTableViewCell, didUnLike post: PostModel)
    func cell (_ cell: UserTableViewCell, wantToCommentView post: PostModel)
    
}

class UserTableViewCell: UITableViewCell {
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
     var delegate: FeedCellDelegate?
    
    
    
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
        //button.setBackgroundImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        //button.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapUpBtn), for: .touchUpInside)
//        button.setTitle(" 정품같아요 ", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.label.cgColor
//        button.layer.cornerRadius = 5

        return button
        
    }()
    
    lazy var thumbsDownBtn: UIButton = {
        let button = UIButton()
        //button.setBackgroundImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        button.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapdownBtn), for: .touchUpInside)
//        button.contentMode = .scaleToFill
        
//        button.setTitle(" 가품같아요 ", for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.label.cgColor
//        button.layer.cornerRadius = 5
        
 
        return button
        
    }()
    

    lazy var commentBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapCommentBtn), for: .touchUpInside)
        return button
    }()
    
    lazy var thumbsUpLabel: UILabel = {
        let label = UILabel()
//        label.text = "1 thumbsUp"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
        
    }()
    
    
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    //MARK: Action
    
    @objc func didTapUpBtn(){
        guard let viewModel = viewModel else {return}
        delegate?.cell(UserTableViewCell(), didLike: viewModel.post)
        
    }
    
    
    @objc func didTapdownBtn(){
        guard let viewModel = viewModel else {return}
        delegate?.cell(self, didUnLike: viewModel.post)
        
    }
    
    @objc func didTapCommentBtn(){
        guard let viewModel = viewModel else {return}
        delegate?.cell(self, wantToCommentView: viewModel.post)
    }
    
    

    
    func configure() {
        guard let viewModel = viewModel else {return}
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)
        thumbsUpLabel.text = viewModel.likesLabelText
        
        
    }
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        [userEmailLabel, postImageView, thumbsUpBtn, thumbsDownBtn, captionLabel, thumbsUpLabel, commentBtn].forEach {contentView.addSubview($0)}
        
        
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
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
            //make.centerX.equalTo(contentView)
            make.height.equalTo(300)
            //make.bottom.equalTo(thumbsUpBtn.snp.top).offset(-4)
            //            make.bottom.equalToSuperview()
        }
        
        thumbsUpBtn.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(4)
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.leading.equalToSuperview()
            
        }
        thumbsDownBtn.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(4)
            make.height.equalTo(30)
            make.width.equalTo(30)
            //make.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(thumbsUpBtn.snp.trailing).offset(4)
        }
        
        thumbsUpLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbsUpBtn.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(2)
        }
        
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbsUpLabel.snp.bottom)
            make.leading.equalToSuperview()
            //make.trailing.equalTo(thumbsUpBtn.snp.leading)
            //make.bottom.equalToSuperview()
        }
        commentBtn.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(4)
            make.leading.equalTo(thumbsDownBtn.snp.trailing).offset(4)
            make.height.equalTo(30)
            make.width.equalTo(30)
          
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
