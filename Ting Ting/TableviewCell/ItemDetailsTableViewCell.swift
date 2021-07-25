//
//  ItemDetailsTableViewCell.swift
//  Ting Ting
//
//  Created by Anish Shrestha on 24/07/21.
//

import UIKit

protocol AddToCartTableViewCellDelegate {
    func didClickAddToCart(indexPath: IndexPath)
}

class ItemDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSubtitleLabel: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var delegate: AddToCartTableViewCellDelegate?
    var indexPath: IndexPath?
    
    class func nib() -> UINib{
        return UINib(nibName: "ItemDetailsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        delegate?.didClickAddToCart(indexPath: indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    func setup(_ itemModel: FoodModel) {
        itemImageView.image = itemModel.image
        itemTitleLabel.text = itemModel.itemName
        itemSubtitleLabel.text = itemModel.itemDescription
        itemQuantityLabel.text = itemModel.itemQuantity
        
        
        if itemModel.currentOrderCount == 0 {
            addButton.setTitle(itemModel.displayPrice, for: .normal)
            addButton.backgroundColor = .black
        } else {
            addButton.setTitle("added + \(itemModel.currentOrderCount)", for: .normal)
            addButton.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7098039216, blue: 0.3058823529, alpha: 1) //97,181,78
        }
        
    }
    
}
