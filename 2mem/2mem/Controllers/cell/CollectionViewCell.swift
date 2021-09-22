//
//  CollectionViewCell.swift
//  2mem
//
//  Created by Artem Firsov on 9/21/21.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static var reuseIden = "imageCell"
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupImageConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    func clearCell() {
        imageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var searchPhotoOut: Result! {
        didSet {
            let photoid = searchPhotoOut.id
            let photoUrl = searchPhotoOut.urls["small"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            imageView.sd_setImage(with: url, placeholderImage: UIImage())
        }
    
    }
    
    func setupImageConstraints() {
        addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
}
