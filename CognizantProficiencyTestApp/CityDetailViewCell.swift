//
//  CityDetailViewCell.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 25/09/20.
//

import UIKit
import SDWebImage

class CityDetailViewCell: UITableViewCell {
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(coder: coder)
        setUp()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.imgView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.imgView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        self.imgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.imgView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
//        self.imgView.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        self.imgView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        self.titleLabel.leftAnchor.constraint(equalTo: self.imgView.rightAnchor, constant: 10).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -4).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.imgView.rightAnchor, constant: 10).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true

    }
    
    func setData(cityDetailObj: CityDetail?) {
        if let detailObj = cityDetailObj {
            
            if let imageUrl = detailObj.image{
                self.imgView.load(urlString: imageUrl)
            } else {
                self.imgView.constraints.last?.constant = 0
            }
            self.titleLabel.text = detailObj.title
            if let desc = detailObj.descrption {
                self.descriptionLabel.text = desc
                self.descriptionLabel.isHidden = desc.isEmpty
            }
        }
        self.setNeedsLayout()
    }
}
