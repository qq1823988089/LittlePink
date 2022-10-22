//
//  File.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/18.
//

import Foundation


// MARK: -UICollectionViewDragDelegate
extension NoteEditVC: UICollectionViewDragDelegate{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        //可用indexpath判断某section或某item是否可拖动,若不可拖动则返回空数组
        
        let photo = photos[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: photo))
        //放下cell时，移动photos数组里的数据时需用到;在同一app内拖放时，localObject可以加快数据传递
        dragItem.localObject = photo
        
        return [dragItem]
        
    }
    
    
}

// MARK: -UICollectionViewDropDelegate
extension NoteEditVC: UICollectionViewDropDelegate{
    
    //拖着移动时-可选实现，但一般都实现，频繁调用，代码尽可能快速简单执行
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag{
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }else{
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        if coordinator.proposal.operation == .move{
            
            if let item = coordinator.items.first,
               let sourceIndexPath = item.sourceIndexPath,
               let destinationIndexPath = coordinator.destinationIndexPath{
                
                collectionView.performBatchUpdates {
                    //先remove再insert，remove后photos数组的indexpath.item会变，所以用localobject锁定图片插入
                    photos.remove(at: sourceIndexPath.item)
                    photos.insert(item.dragItem.localObject as! UIImage, at: destinationIndexPath.item)
                    collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
                }
                
                //固定操作,让拖拽变得自然
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                
            }
            
        }
    }
    
}
