//
//  CityViewCell.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 27/09/20.
//

import UIKit
import SDWebImage

class CityViewCell: UITableViewCell {

    var widthConstraint: NSLayoutConstraint!
    var validTraitWidth: CGFloat = 60
   
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    var imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    var emptySpace: UIView = {
        let spaceView = UIView()
        return spaceView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp(traitCollection: self.traitCollection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp(traitCollection: UITraitCollection) {
        self.selectionStyle = .none
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(labelStackView)
        
      
        imgView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        labelStackView.addArrangedSubview(emptySpace)

        imgView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        imgView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        imgView.trailingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor, constant: -10).isActive = true
        
        // MARK:- TraitCollection changes based on size classes(iPad & iPhone)
        
        if (self.traitCollection.horizontalSizeClass == .regular &&  self.traitCollection.verticalSizeClass == .regular) {
            self.titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
            widthConstraint = imgView.widthAnchor.constraint(equalToConstant: 100)
            validTraitWidth = 100
            widthConstraint.isActive = true
            imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            emptySpace.heightAnchor.constraint(equalToConstant: 16).isActive = true
        } else {
            self.titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
            self.descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
            widthConstraint = imgView.widthAnchor.constraint(equalToConstant: 60)
            widthConstraint.isActive = true
            validTraitWidth = 60
            imgView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            emptySpace.heightAnchor.constraint(equalToConstant: 4).isActive = true
        }
        
        // MARK:- Labels construction for title and description using stackview
        
        labelStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: self.imgView.trailingAnchor, constant: 10).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
    }
    func setData(cityDetailObj: CityDetail?) {
        self.widthConstraint.constant = validTraitWidth
        if let detailObj = cityDetailObj {
            if let imageUrl = detailObj.image{
                self.imgView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "error-image-generic"), options: .continueInBackground, context: nil)
            } else {
                self.widthConstraint.constant = 0
            }
            self.titleLabel.text = detailObj.title
            self.descriptionLabel.text = detailObj.descrption ?? "No Description"
        }
        self.layoutIfNeeded()
    }
}

// MARK:- Traitcollection for iPad and iPhone when Orientation changes

extension CityViewCell {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUp(traitCollection: traitCollection)
    }    
}
