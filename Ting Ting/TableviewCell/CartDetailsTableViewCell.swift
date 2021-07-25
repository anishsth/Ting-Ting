//
//  CartDetailsTableViewCell.swift
//  Ting Ting
//
//  Created by Anish Shrestha on 25/07/21.
//

import UIKit

protocol DeleteFromCartTableViewCellDelegate {
    func didClickDeleteFromCart(indexPath: IndexPath)
}

class CartDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    var delegate: DeleteFromCartTableViewCellDelegate?
    var indexPath: IndexPath?
    
    class func nib() -> UINib{
        return UINib(nibName: "CartDetailsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func crossButtonAction(_ sender: Any) {
        delegate?.didClickDeleteFromCart(indexPath: indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    func setup(_ itemModel: FoodModel) {
        itemImageView.image = itemModel.image
        itemTitleLabel.text = itemModel.itemName
        itemPriceLabel.text = "\(itemModel.currentOrderCount) x \(itemModel.displayPrice)"
    }
    
}
