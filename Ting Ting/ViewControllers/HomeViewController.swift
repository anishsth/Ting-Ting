//
//  HomeViewController.swift
//  Ting Ting
//
//  Created by Anish Shrestha on 17/07/21.
//

import UIKit

protocol CartItemProtocol: AnyObject {
    func didUpdateItem(_ itemArray: [FoodModel], _ item: FoodModel)
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var cartView: UIView!
    @IBOutlet private weak var cartCountView: UIView!
    @IBOutlet private weak var parallexView: UIView!
    
    @IBOutlet private weak var cartCountLabel: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
        
    var foodItemArray: [FoodModel]!
    var currentOrderItemArray: [FoodModel] = []

    var totalCartCount: Int = 0
    var collectionImageView: [UIImage]!
    var oldContentOffset: CGPoint = .zero
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        createDummyFoodModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    func registerCell() {
        collectionView.register(ItemDetailsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ItemDetailsCollectionViewCell")
        tableView.register(ItemDetailsTableViewCell.nib(), forCellReuseIdentifier:  "ItemDetailsTableViewCell")
    }
    
    //MARK: - IBOutlets
    @IBAction func cartButtonAction(_ sender: Any) {
        
        guard !currentOrderItemArray.isEmpty else {
            showToast(message: "Ooops, your cart is empty")
            return
        }

        let cartVC = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        cartVC.modalTransitionStyle = .crossDissolve
        cartVC.modalPresentationStyle = .overCurrentContext
        cartVC.cartItemArray = currentOrderItemArray
        cartVC.delagate = self
        self.present(cartVC, animated: true, completion: nil)
    }
    
    func createDummyFoodModel() {
        let food1 = FoodModel()
        food1.id = "1"
        food1.image = #imageLiteral(resourceName: "Pizza-1")
        food1.itemName = "Hawaiian"
        food1.itemDescription = "Chicken, Pineapple, Domino's Sauce"
        food1.itemQuantity = "200 grams, 35 cm"
        food1.price = "45"

        let food2 = FoodModel()
        food2.id = "2"
        food2.image = #imageLiteral(resourceName: "Pizza-2")
        food2.itemName = "Deluxe"
        food2.itemDescription = "Chicken, Pineapple, Domino's Sauce"
        food2.itemQuantity = "150 grams, 25 cm"
        food2.price = "35"

        let food3 = FoodModel()
        food3.id = "3"
        food3.image = #imageLiteral(resourceName: "Pizza-3")
        food3.itemName = "Pepperoni"
        food3.itemDescription = "Chicken, Pineapple, Domino's Sauce"
        food3.itemQuantity = "100 grams, 15 cm"
        food3.price = "25"
        
        foodItemArray = [food1, food2, food3]
        
        collectionImageView = [#imageLiteral(resourceName: "Monday-Discount"), #imageLiteral(resourceName: "Discount")]  //Offer Images
    }

}

//MARK: - AddToCartTableViewCellDelegate
extension HomeViewController: AddToCartTableViewCellDelegate {
    
    func didClickAddToCart(indexPath: IndexPath) {
        guard foodItemArray[indexPath.row].currentOrderCount < 9 else {
            showAlert(title: "Ooopps", message: "Looks like you have added enough \(foodItemArray[indexPath.row].itemName) for the day")
            return
        }
        foodItemArray[indexPath.row].currentOrderCount += 1
        
        if let index = currentOrderItemArray.firstIndex(where: { $0.id == foodItemArray[indexPath.row].id}) {
            currentOrderItemArray[index] = foodItemArray[indexPath.row]
        } else {
            currentOrderItemArray.append(foodItemArray[indexPath.row])
        }
        
        updateTotalCartCount()
        tableView.reloadData()
    }
    
    func updateTotalCartCount() {
        totalCartCount = currentOrderItemArray.reduce(0) { $0 + $1.currentOrderCount}
        cartCountView.isHidden = totalCartCount > 0 ? false : true
        cartCountLabel.text = String(totalCartCount)
    }
}

//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailsTableViewCell", for: indexPath) as! ItemDetailsTableViewCell
        cell.setup(foodItemArray[indexPath.row])
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self, options: nil)?.first as? HomeTableViewHeader {
            return view
        }
        return nil
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = collectionImageView.count
        return collectionImageView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailsCollectionViewCell", for: indexPath) as! ItemDetailsCollectionViewCell
        cell.setup(image: collectionImageView[indexPath.row])
        return cell
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 235.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
}

//MARK: - CartItemProtocol
extension HomeViewController: CartItemProtocol {
    
    func didUpdateItem(_ itemArray: [FoodModel], _ item: FoodModel) {
        currentOrderItemArray = itemArray

        foodItemArray.forEach { foodItem in
            if foodItem === item {
                foodItem.currentOrderCount = 0
            }
        }
        
        tableView.reloadData()
        updateTotalCartCount()
    }
    
}


extension HomeViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
