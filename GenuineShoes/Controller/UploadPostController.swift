//
//  UploadPostController.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class UploadPostController: UIViewController {
    let indicator = NVActivityIndicatorView(frame: CGRect(x: 162, y: 100, width: 50, height: 50),
                                            type: .circleStrokeSpin,
                                            color: .black,
                                            padding: 0)
    
    let uscv = UserCheckViewController()
    
    
    var selectedImage: UIImage?{
        didSet {PhotoImageView.image = selectedImage}
    }
    
    
    private lazy var PhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
//        imageView.image =  #imageLiteral(resourceName: "obsidian")
        return imageView
    }()
    
    private lazy var captionTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "입력해주세요"
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.delegate = self
        return textView
        
    }()
    
    private lazy var characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        view.backgroundColor = .white
    }
    
    @objc func didTapCancel(){
        dismiss(animated: true)
    }
    
    @objc func didTapDone(){
        guard let image = selectedImage else {return}
        guard let caption = captionTextView.text else {return}
        indicator.startAnimating()
        
        PostService.uploadPost(caption: caption, image: image) { error in
            self.indicator.stopAnimating()
            if error == error {
                print("failed to upload")
                return
            }
            
            //            self.dismiss(animated: true)
        }
   
        self.dismiss(animated: true)
        print("업로ㄷ 컨트롤러가 사라집니다")
        uscv.testprint()
        
        
    }
    
    func checkMaxLength(_ textView: UITextView){
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
        
    }
    
    
    func setUpLayout(){
        navigationItem.title = "Upload Post"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        
        
        [PhotoImageView, captionTextView, characterCountLabel, indicator].forEach {view.addSubview($0)}
        
        PhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
            
        }
        
        captionTextView.snp.makeConstraints { make in
            make.top.equalTo(PhotoImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(64)

        }
        
        characterCountLabel.snp.makeConstraints { make in
            make.top.equalTo(captionTextView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
}

extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
        
    }
}
