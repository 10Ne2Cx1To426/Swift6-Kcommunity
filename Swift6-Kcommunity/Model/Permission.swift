//
//  Permission.swift
//  Swift6-Kcommunity
//
//  Created by Sena Nishida on 2021/02/26.
//

import Foundation
import Photos

class PermissionCheckModel {
    
    func showCheckPermission() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status) {
            case .authorized:
                print("許可")
            case .denied:
                print("拒否")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .limited:
                print("limited")
            @unknown default: break
            }
        }
    }
}
