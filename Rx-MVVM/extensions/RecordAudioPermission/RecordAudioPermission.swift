//
//  RecordAudioPermission.swift
//  RevivalPatient
//
//  Created by Tu Van on 26/01/2022.
//

import AVFoundation
import UIKit

class RecordAudioPermission {
    
    static func hasStethoscope() -> Bool {
        let outputs = AVAudioSession.sharedInstance().currentRoute.outputs
        let names = ["Baets", "Receiver"]
        for desc in outputs {
            if names.contains(desc.portName) == true {
                return true
            }
        }
        return false
    }
    
    static func portTypes() -> String {
        let outputs = AVAudioSession.sharedInstance().currentRoute.outputs
        return outputs.map { "\($0.portType.rawValue) \($0.portName)" }.joined(separator: ".")
    }
    
    static func requesPermission(from viewController: UIViewController?, isShowAlert: Bool = false, completion: ((Bool) -> ())?) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                completion?(granted)
            } else {
                if isShowAlert {        
                    let alertVC = UIAlertController(title: "Microphone permission", message: "Please allow access to Microphone", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel) {_ in
                        // TODO
                    }
                    let okAction = UIAlertAction(title: "Goto Settings", style: .default) { _ in
                        self.gotoSettings()
                    }
                    
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancel)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.11, execute: { [weak viewController] in
                        viewController?.present(alertVC, animated: false, completion: nil)
                    })
                } else {
                    completion?(granted)
                }
            }
        }
    }
    
    private static func gotoSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                Logger.debug("Settings opened: \(success)")
            })
        }
    }
}
