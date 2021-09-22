//
//  ImagesViewController.swift
//  2mem
//
//  Created by Artem Firsov on 9/21/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImagesViewController: UICollectionViewController {

    var searchPhotoArray = [Result]()
    var inputId = ""
    private var timer: Timer?
    var apiService = ApiService()
    var pages = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCompLayout()
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIden)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super .viewWillAppear(animated)
     
            self.apiService.getPhotos(searchTerm: self.inputId) { [weak self] (searchResponse) in
                guard let response = searchResponse else { return }
                self?.searchPhotoArray = response.results
                self?.pages = response.totalPages
                self?.collectionView.reloadData()
                }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPhotoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIden, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        if searchPhotoArray.count != 0 {
        let photos = searchPhotoArray[indexPath.item]
        cell.searchPhotoOut = photos
        return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            cell.backgroundColor = .black
            return cell
            
        }
    }

    
    
    
    
}

extension ImagesViewController {
    
        func configureCompLayout() {
    
            collectionView.setCollectionViewLayout(firstLayout(), animated: true)
        }
    
        func firstLayout() -> UICollectionViewCompositionalLayout {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 3, leading: 3, bottom: 3, trailing: 3)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(400))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
    //        section.orthogonalScrollingBehavior = .continuous
    //        return section
            let layout = UICollectionViewCompositionalLayout(section: section)
            return layout
        }
}
