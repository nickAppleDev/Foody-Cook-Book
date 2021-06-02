//
//  FoodListVC.swift
//  Foody Cook Book
//
//  Created by Niral Shah on 01/06/21.
//

import UIKit

class FoodListVC: UIViewController {

    // MARK: -  IBOutlets
    @IBOutlet weak var tblFoodList: UITableView?
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: -  Variables
    var dictFoodData: FoodListModel!

    // MARK: -  View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupViewStructure()
        self.getFoodData(keyword: "")
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    // MARK: -  View Setup
    func setupViewStructure() {
        //Register NIB
        self.tblFoodList?.register(UINib(nibName: "FoodListCell", bundle: nil), forCellReuseIdentifier: "FoodListCell")
    }
}

// MARK: -  Button Events
extension FoodListVC{
    // MARK: -  Button Events
    @IBAction func setFavourite(_ sender: UIButton) {
        let cell = self.tblFoodList!.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! FoodListCell
        if cell.btnFavourite?.isSelected == true{
            cell.btnFavourite?.isSelected = false
        }else{
            cell.btnFavourite?.isSelected = true
        }
    }
}

extension FoodListVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dictFoodData.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FoodListCell = tableView.dequeueReusableCell(withIdentifier: "FoodListCell") as! FoodListCell
        
        cell.lblTitle?.text = self.dictFoodData.meals[indexPath.row].strMeal
        cell.lblDescription?.text = self.dictFoodData.meals[indexPath.row].strInstructions
        cell.imgFood?.downloaded(from: self.dictFoodData.meals[indexPath.row].strMealThumb)
        
        cell.btnFavourite!.addTarget(self, action: #selector(setFavourite), for: .touchUpInside)
        cell.btnFavourite?.tag = indexPath.row
        
        cell.lblDescription?.numberOfLines = 4
        cell.lblDescription?.sizeToFit()
        cell.btnFavourite?.frame.origin.y = (cell.lblDescription?.frame.origin.y)! + (cell.lblDescription?.frame.size.height)! + 5
        cell.viewBase?.frame.size.height = (cell.btnFavourite?.frame.origin.y)! + (cell.btnFavourite?.frame.size.height)!
        tableView.rowHeight = (cell.viewBase?.frame.size.height)!
        
        return cell
    }
    
    // MARK: -  Collectionview Delegate
    // MARK: -  Tableview Delegate
    // MARK: -  UITextField Delegate
    // MARK: -  Other Delegate
    //Searchbar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.getFoodData(keyword: self.searchBar.text!)
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension FoodListVC{
    // MARK: -  API Connections
    func getFoodData(keyword: String){
        let parameters = NSMutableDictionary()
        parameters.setValue(keyword, forKey: "s")
        
        AppAPIConnection().APICall_GET(parameters: parameters, isLoader: true) { (responseValue) in
            
            print(responseValue)
            
            let decoder = JSONDecoder()
            guard let foodListModel =  try? decoder.decode(FoodListModel.self, from: responseValue) else {
                return
            }
            
            self.dictFoodData = foodListModel
            self.tblFoodList?.delegate = self
            self.tblFoodList?.dataSource = self
            self.tblFoodList?.reloadData()
            
        } error: { (error) in
            print(error)
        }
    }
}

extension FoodListVC{
    // MARK: -  Database Setup
}

extension FoodListVC{
    // MARK: -  Language Localisation
}

extension FoodListVC{
    // MARK:-  Additional Functions
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
