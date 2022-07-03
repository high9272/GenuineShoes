//
//  customCell.swift
//  GenuineShoes
//
//  Created by DaWoon Jeong on 2022/07/01.
//

import UIKit

class CustomCell: UITableViewCell {

    //@IBOutlet weak var imageUrlLabel: UILabel!
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var snkImage: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
