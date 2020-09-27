//
//  UIImageView+Extensions.swift
//  CognizantProficiencyTestApp
//
//  Created by Vijay Bhaskar on 25/09/20.
//

import Foundation
import UIKit
import MBProgressHUD

var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    func load(urlString: String) {
                
        MBProgressHUD.showAdded(to: self, animated: true)
        if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
         self.image = image
        }
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .background).async {[weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                        if let weakSelf = self {
                            MBProgressHUD.hide(for: weakSelf, animated: true)
                        }
                    }
                }
            }
        }
        
    }
}
