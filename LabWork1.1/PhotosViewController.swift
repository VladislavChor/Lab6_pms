//
//  PhotosViewController.swift
//  LabWork1.1
//
//  Created by Vladislav on 22.05.2021.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var arrayOfPictures = [Photo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let layout = collectionView?.collectionViewLayout as? MyCollectionViewLayout {
            layout.delegate = self
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
        getPictures()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
 
    func getPictures() {
        NetworkManager.sharad.getPhotos(with: "yellow+flowers", count: 27) { [weak self](data, error) in
            
            if let data = data {
                if let photos = Manager.shared.parseJSON(data: data, type: Photos.self) {
                    self?.arrayOfPictures = photos.hits
                    self?.collectionView.reloadData()
                }
                self?.collectionView.reloadData()
            }
            
        }
    }
}

extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.configure(url: arrayOfPictures[indexPath.item].largeImageURL)

        
        return cell
    }
    
    
}


extension PhotosViewController: MyCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        if((indexPath.item + 1) % 9 == 1 || (indexPath.item + 1) % 9 == 0) {
            return collectionView.frame.width/3*2
        } else{
            return collectionView.frame.width/3
        }
    }
}

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func openPhotos() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard (info[.originalImage] as? UIImage) != nil else { return }
        collectionView.reloadData()
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
