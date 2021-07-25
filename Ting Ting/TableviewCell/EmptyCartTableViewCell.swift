//
//  EmptyCartTableViewCell.swift
//  Ting Ting
//
//  Created by Anish Shrestha on 25/07/21.
//

import UIKit

class EmptyCartTableViewCell: UITableViewCell {

    class func nib() -> UINib{
        return UINib(nibName: "EmptyCartTableViewCell", bundle: nil)
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
