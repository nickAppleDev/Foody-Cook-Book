//
//  AppAPIConnection.swift
//  Foody Cook Book
//
//  Created by Niral Shah on 01/06/21.
//

import Foundation
import SwiftyJSON
import Alamofire
import ProgressHUD

struct AppAPIConnection {

    let BaseURL: String = "https://www.themealdb.com/api/json/v1/1/search.php?"
    
    // MARK:- GET FOOD
    func APICall_GET(parameters: NSMutableDictionary, isLoader: Bool, completion: @escaping (_ result: Data) -> Void, error: @escaping (_ error: Error) -> Void) {

        if isLoader == true{
            ProgressHUD.show("Loading...", interaction: false)
        }
                
        AF.request(BaseURL, method: .get, parameters: parameters as? Parameters, encoding: URLEncoding.default).responseJSON { response in
            print(response)
            
            switch (response.result) {
            case .success:
                if isLoader == true{
                    ProgressHUD.dismiss()
                }
                completion(response.data!)
            case .failure( let error):
                if isLoader == true{
                    ProgressHUD.dismiss()
                }
                print(error)
            }
        }
    }
    
    func getFoodCookBook(parameters: NSMutableDictionary, isLoader: Bool, completion: @escaping (_ result: FoodListModel) -> Void) {
                
        AppAPIConnection().APICall_GET(parameters: parameters, isLoader: isLoader) { (responseValue) in
            
            print(responseValue)
            
            let decoder = JSONDecoder()
            guard let foodListModel =  try? decoder.decode(FoodListModel.self, from: responseValue) else {
                return
            }
            
            completion(foodListModel)

        } error: { (error) in
            print(error)
        }
    }

}
