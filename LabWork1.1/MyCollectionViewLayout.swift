//
//  MyCollectionViewLayout.swift
//  LabWork1.1
//
//  Created by Vladislav on 22.05.2021.
//

import UIKit

protocol MyCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}


class MyCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: MyCollectionViewLayoutDelegate?
    
    private let cellPadding: CGFloat = 1
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override func invalidateLayout() {
        super.invalidateLayout()
        contentHeight = 0
        cache = []
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        
        let x_axis: [CGFloat] = [0, contentWidth/3, contentWidth/3*2]
        var y_axis:CGFloat = 0
        
      
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            var frame:CGRect?
            let photoHeight = delegate?.collectionView(collectionView,heightForPhotoAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + photoHeight - 2
            
            if ((indexPath[1] + 1) % 9 == 1) {
                frame = CGRect(x: x_axis[0], y: y_axis, width: height, height: height)
            } else if((indexPath[1] + 1) % 9 == 2 || (indexPath[1] + 1) % 9 == 3) {
                frame = CGRect(x: x_axis[2], y: y_axis, width: height, height: height)
                y_axis += (indexPath[1] + 1) % 9 == 2 ? height : height
            } else if((indexPath[1] + 1) % 9 == 4 || (indexPath[1] + 1) % 9 == 5 || (indexPath[1] + 1) % 9 == 6){
                frame = CGRect(x: x_axis[indexPath[1] % 9 - 3], y: y_axis, width: height, height: height)
                y_axis += (indexPath[1] + 1) % 9 == 0 ? height : 0
            } else if((indexPath[1] + 1) % 9 == 7 || (indexPath[1] + 1) % 9 == 8){
                y_axis += (indexPath[1] + 1) % 9 == 7 ? height : 0
                frame = CGRect(x: x_axis[0], y: y_axis, width: height, height: height)
                y_axis += (indexPath[1] + 1) % 9 == 7 ? height : -height
            } else {
                frame = CGRect(x: x_axis[1], y: y_axis, width: height, height: height)
                y_axis += height
            }
            let insetFrame = frame!.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame!.maxY)
        }
    
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
