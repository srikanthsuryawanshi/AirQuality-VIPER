//
//  CityListViewCellTableViewCell.swift
//  AirQuality
//
//  Created by Srikanth SP on 09/05/22.
//

import UIKit

class CityListViewCellTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    
    func configureCell(city: String, value: Double, lastUpdated: String) {
        cityLabel.text = city
        
        let standard = AirQualityStandard.withValue(Int(value))
        self.backgroundColor = standard.color()
        valueLabel.text = String(format:"%.2f", value)
        
        lastUpdatedLabel.text = lastUpdated
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
