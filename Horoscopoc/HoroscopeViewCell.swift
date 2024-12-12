//
//  HoroscopeViewCell.swift
//  Horoscopoc
//
//  Created by Tardes on 12/12/24.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       
    }
    
    func render (from horoscope: Horoscope) {
        nameLabel.text = horoscope.name
        dateLabel.text = horoscope.dates
        iconImageView.image = horoscope.icon
        
    }

}
