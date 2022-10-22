//
//  NoteEditVC-collectionview.swift
//  LittlePink-git
//
//  Created by 乔一 on 2022/10/19.
//

import YPImagePicker
import MBProgressHUD
import SKPhotoBrowser
import AVKit

extension NoteEditVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isVideo{
            
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoURL!)
            present(playerVC, animated: true) { playerVC.player?.play() }
            
        }else{
            
            var images: [SKPhoto] = []
            
            for photo in photos{
                images.append(SKPhoto.photoWithImage(photo))
            }
            
            let browser = SKPhotoBrowser(photos: images, initialPageIndex: indexPath.item)
            browser.delegate = self
            SKPhotoBrowserOptions.displayAction = false
            SKPhotoBrowserOptions.displayDeleteButton = true
            present(browser, animated: true)
            
        }
        
    }
    
}

// MARK: -SKPhotoBrowserDelegate
extension NoteEditVC: SKPhotoBrowserDelegate{
    
    func removePhoto(_ browser: SKPhotoBrowser, index: Int, reload: @escaping (() -> Void)) {
        photos.remove(at: index)
        photoCollectionView.reloadData()
        reload()
    }
    
    
}

extension NoteEditVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoCollectionViewCellID, for: indexPath) as! PhotoCollectionViewCell
        
        cell.imageView.image = photos[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind{
        case UICollectionView.elementKindSectionFooter:
            let photoFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kPhotoFooterID, for: indexPath) as! PhotoFooter
            
            photoFooter.addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
            
            return photoFooter
        default:
            fatalError("CollectionView-Footer出错")
        }
        
    }
    
    
}

extension NoteEditVC{
    @objc private func addPhoto(){
        if photoCount < kMaxPhotoNum{
            var config = YPImagePickerConfiguration()
            
            // MARK: 通用配置
            config.albumName = Bundle.main.appName //存图片进相册App的'我的相簿'里的文件夹名称
            config.screens = [.library] //依次展示相册，拍视频，拍照页面
            
            // MARK: 相册配置
            config.library.defaultMultipleSelection = true //是否可多选
            config.library.maxNumberOfItems = kMaxPhotoNum - photoCount //最大选取照片或视频数
            config.library.spacingBetweenItems = kSpacingBetweenItems //照片缩略图之间的间距
            
            // MARK: - Gallery(多选完后的展示和编辑页面)-画廊
            config.gallery.hidesRemoveButton = false //每个照片或视频右上方是否有删除按钮
            
            let picker = YPImagePicker(configuration: config)
            
            // MARK: 选完或按取消按钮后的异步回调处理（依据配置处理单个或多个）
            picker.didFinishPicking { [unowned picker] items, _ in
  
                for item in items {
                    if case let .photo(photo) = item{
                        self.photos.append(photo.image)
                    }
                }
                self.photoCollectionView.reloadData()
                
                picker.dismiss(animated: true)
            }
            
            present(picker, animated: true)
        }else{
            showTextHUD("最多选择\(kMaxPhotoNum)张图片")
        }
    }
}
