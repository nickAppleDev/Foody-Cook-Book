//
//  FoodListCell.swift
//  Foody Cook Book
//
//  Created by Niral Shah on 01/06/21.
//

import UIKit

class FoodListCell: UITableViewCell {

    @IBOutlet weak var imgFood: UIImageView?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var lblDescription: UILabel?
    @IBOutlet weak var btnFavourite: UIButton?
    @IBOutlet weak var viewBase: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
