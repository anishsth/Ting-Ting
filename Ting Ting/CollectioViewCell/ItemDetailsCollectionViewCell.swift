//
//  ItemDetailsCollectionViewCell.swift
//  Ting Ting
//
//  Created by Anish Shrestha on 24/07/21.
//

import UIKit

class ItemDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImageView: UIImageView!
    
    class func nib() -> UINib {
        return UINib(nibName: "ItemDetailsCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(image: UIImage) {
        collectionImageView.image = image
    }
    
}
