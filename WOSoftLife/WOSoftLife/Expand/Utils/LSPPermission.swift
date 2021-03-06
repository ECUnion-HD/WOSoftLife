//
//  LSPPermission.swift
//  WOSoftLife
//
//  Created by Liu Chuanyong on 2021/4/8.
//  Copyright © 2021 安徽省合肥市软人生信息技术股份有限公司. All rights reserved.
//

import Foundation
import UIKit
import Photos

enum LSPAuthorizationStatus {
    /// 未知状态
    case unknown
    /// 用户未选择
    case notDetermined
    /// 用户没有权限
    case restricted
    /// 拒绝
    case denied
    /// 允许
    case authorized
    /// 临时允许
    case provisional
    /// 设备不支持
    case noSupport
    /// 是否可以访问
    var isAuthorized: Bool {
        return self == .authorized || self == .provisional
    }
    /// 是否不支持
    var isNoSupport: Bool {
        return self == .noSupport
    }
}

protocol LSPPermissionInterface {
    /// 是否允许
    var isAuthorized: Bool { get }
    /// 是否拒绝
    var isDenied: Bool { get }
    ///请求权限
    func request(сompletionCallback: ((LSPAuthorizationStatus)->())?)
}

// MARK: - 相册权限
struct LSPPhotoLibraryPermission: LSPPermissionInterface {
    var isAuthorized: Bool {
        return PHPhotoLibrary.authorizationStatus() == .authorized
    }
    var isDenied: Bool {
        return PHPhotoLibrary.authorizationStatus() == .denied
    }
    func request(сompletionCallback: ((LSPAuthorizationStatus)->())?) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var authorizationStatus: LSPAuthorizationStatus = .unknown
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
                authorizationStatus = .authorized
            case .notDetermined:
                authorizationStatus = .notDetermined
            case .restricted:
                authorizationStatus = .restricted
            case .denied:
                authorizationStatus = .denied
            default:
                authorizationStatus = .unknown
            }
            if authorizationStatus == .notDetermined {
                PHPhotoLibrary.requestAuthorization { (status) in
                    if status == .authorized {
                        authorizationStatus = .authorized
                    }else if status == .denied {
                        authorizationStatus = .denied
                    }
                    сompletionCallback?(authorizationStatus)
                }
            }else {
                сompletionCallback?(authorizationStatus)
            }
        } else {
            сompletionCallback?(.noSupport)
        }
    }
}

// MARK: - 相机权限
struct LSPCameraPermission: LSPPermissionInterface {
    var isAuthorized: Bool {
        return AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized
    }
    var isDenied: Bool {
        return AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.denied
    }
    func request(сompletionCallback: ((LSPAuthorizationStatus)->())?) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var authorizationStatus: LSPAuthorizationStatus = .unknown
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                authorizationStatus = .authorized
            case .notDetermined:
                authorizationStatus = .notDetermined
            case .restricted:
                authorizationStatus = .restricted
            case .denied:
                authorizationStatus = .denied
            default:
                authorizationStatus = .unknown
            }
            if authorizationStatus == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video) { (authorized) in
                    сompletionCallback?(authorized ? .authorized : .denied)
                }
            }else {
                сompletionCallback?(authorizationStatus)
            }
        } else {
            сompletionCallback?(.noSupport)
        }
    }
}

// MARK: - 通知权限
struct LSPNotificationPermission: LSPPermissionInterface {
    var isAuthorized: Bool {
        let authorizationStatus = fetchAuthorizationStatus()
        return authorizationStatus == .authorized
    }
    var isDenied: Bool {
        let authorizationStatus = fetchAuthorizationStatus()
        return authorizationStatus == .denied
    }
    func request(сompletionCallback: ((LSPAuthorizationStatus)->())?) {
       #if SPPERMISSION_NOTIFICATION
       var authorizationStatus: LSPAuthorizationStatus = .unknown
        switch fetchAuthorizationStatus() {
        case .notDetermined:
            authorizationStatus = .notDetermined
        case .authorized:
            authorizationStatus = .authorized
        case .denied:
            authorizationStatus = .denied
        case .provisional:
            authorizationStatus = .provisional
        default:
            authorizationStatus = .unknown
        }
       if authorizationStatus == .notDetermined {
           if #available(iOS 10.0, *) {
               let center = UNUserNotificationCenter.current()
               center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                if let error = error {
                    print("request NotificationPermission error \(error)")
                    сompletionCallback?(.unknown)
                }else {
                    сompletionCallback?(granted ? .authorized : .denied)
                }
               }
           }
           UIApplication.shared.registerForRemoteNotifications()
       }else {
           сompletionCallback?(authorizationStatus)
       }
       #else
       сompletionCallback?(.noSupport)
       #endif
    }
    private func fetchAuthorizationStatus() -> UNAuthorizationStatus {
        var notificationSettings: UNNotificationSettings!
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            UNUserNotificationCenter.current().getNotificationSettings { setttings in
                notificationSettings = setttings
                semaphore.signal()
            }
        }
        semaphore.wait()
        return notificationSettings.authorizationStatus
    }
}

// MARK: - 麦克风权限
struct LSPMicrophonePermission: LSPPermissionInterface {
    var isAuthorized: Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted
    }
    var isDenied: Bool {
        return AVAudioSession.sharedInstance().recordPermission == .denied
    }
    func request(сompletionCallback: ((LSPAuthorizationStatus)->())?) {
        if AVAudioSession.sharedInstance().isInputAvailable {
            var authorizationStatus: LSPAuthorizationStatus = .unknown
            switch AVAudioSession.sharedInstance().recordPermission {
            case .undetermined:
                authorizationStatus = .notDetermined
            case .granted:
                authorizationStatus = .authorized
            case .denied:
                authorizationStatus = .denied
            default:
                authorizationStatus = .unknown
            }
            if authorizationStatus == .notDetermined {
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    сompletionCallback?(granted ? .authorized : .denied)
                }
            } else {
                сompletionCallback?(authorizationStatus)
            }
        } else {
            сompletionCallback?(.noSupport)
        }
    }
}

// MARK: - 定位权限
struct LSPLocationPermission: LSPPermissionInterface {
    var isAuthorized: Bool {
        return AVAudioSession.sharedInstance().recordPermission == .granted
    }
    var isDenied: Bool {
        return AVAudioSession.sharedInstance().recordPermission == .denied
    }
    func request(сompletionCallback: ((LSPAuthorizationStatus)->())?) {
        if CLLocationManager.locationServicesEnabled() {
            var authorizationStatus: LSPAuthorizationStatus = .unknown
            switch AVAudioSession.sharedInstance().recordPermission {
            case .undetermined:
                authorizationStatus = .notDetermined
            case .granted:
                authorizationStatus = .authorized
            case .denied:
                authorizationStatus = .denied
            default:
                authorizationStatus = .unknown
            }
            if authorizationStatus == .notDetermined {
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    сompletionCallback?(granted ? .authorized : .denied)
                }
            } else {
                сompletionCallback?(authorizationStatus)
            }
        } else {
            сompletionCallback?(.noSupport)
        }
    }
}
