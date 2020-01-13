//
//  StuffCell.swift
//  FirestoreApp
//
//  Created by Javier Calderon Jr. on 1/13/20.
//  Copyright © 2020 RockefellerMagic. All rights reserved.
//

import UIKit

class StuffCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var leftPick: UIButton!
    @IBOutlet weak var rightPick: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func populate(item: Stuff) {
        title.text = "\(item.brand): \(item.name)"
        weight.text = item.weight
        price.text = "$\(item.price)"
    }
}
