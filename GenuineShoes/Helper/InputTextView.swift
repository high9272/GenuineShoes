//
//  InputTextView.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/21.
//

import Foundation
import UIKit
import SnapKit
class InputTextView: UITextView {
    
    var placeholderText: String?{
        didSet {placeholderLabel.text = placeholderText}
        
    }
    
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
  
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
//        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingtop: 4)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChanged), name: UITextView.textDidChangeNotification, object: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTextDidChanged(){
        placeholderLabel.isHidden = !text.isEmpty
    }
    
}
