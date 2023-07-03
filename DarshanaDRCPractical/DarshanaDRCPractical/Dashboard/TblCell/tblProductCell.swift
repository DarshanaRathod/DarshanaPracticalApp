//
//  tblProductCell.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import UIKit
import SDWebImage

class tblProductCell: UITableViewCell {
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblLike: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
           }
        // Initialization code

   @objc func stepperValueChanged() {
    lblQuantity.text = "\(Int(stepper.value))"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func stepperAction(_ sender: Any) {
        
    }
}
