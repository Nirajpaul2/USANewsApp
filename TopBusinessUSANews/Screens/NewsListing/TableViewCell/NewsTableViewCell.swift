//
//  NewsTableViewCell.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak private var imgView: UIImageView!
    @IBOutlet weak private var lblAuthor: UILabel!
    @IBOutlet weak private var lblDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCellData(news: News?) {
        imgView.downloadImage(from: news?.urlToImage ?? "") { [weak self] response in
            DispatchQueue.main.async {
                self?.imgView.image = response.status ? response.image : UIImage(named: "noImage")
            }
        }
        
        lblAuthor.text = news?.author ?? "N/A"
        lblDetail.text = news?.description ?? "N/A"
    }
}
