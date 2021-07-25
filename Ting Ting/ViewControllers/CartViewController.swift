//
//  CartViewController.swift
//  Ting Ting
//
//  Created by Anish Shrestha on 25/07/21.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!

    var cartItemArray: [FoodModel] = []
    weak var delagate: CartItemProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
    }
    
    func registerCell() {
        tableView.register(CartDetailsTableViewCell.nib(), forCellReuseIdentifier:  "CartDetailsTableViewCell")
        tableView.register(EmptyCartTableViewCell.nib(), forCellReuseIdentifier:  "EmptyCartTableViewCell")        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cardButtonAction(_ sender: Any) {
        showToast(message: "Navigate to Card VC")
    }

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemArray.isEmpty ? 1 : cartItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if cartItemArray.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCartTableViewCell", for: indexPath) as! EmptyCartTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartDetailsTableViewCell", for: indexPath) as! CartDetailsTableViewCell
            cell.setup(cartItemArray[indexPath.row])
            cell.indexPath = indexPath
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let view = Bundle.main.loadNibNamed("CartTableViewFooter", owner: self, options: nil)?.first as? CartTableViewFooter, cartItemArray.count > 0 {
            view.totalValueLabel.text = "$" + String(cartItemArray.reduce(0) { $0 + $1.totalAmount})
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cartItemArray.isEmpty ? 0 : 79
    }
}

extension CartViewController: DeleteFromCartTableViewCellDelegate {
    
    func didClickDeleteFromCart(indexPath: IndexPath) {
        let deletedItem = cartItemArray[indexPath.row]
        cartItemArray.remove(at: indexPath.row)
        delagate?.didUpdateItem(cartItemArray, deletedItem)
        tableView.reloadData()
    }
    
}
