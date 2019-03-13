//
//  BiometricViewController.swift

//

//

import UIKit
import LocalAuthentication

enum LocalAuthenticationError: Error {
    case biometryNotAvailable
    case forwarded(Error)
    case unknown
}

class BiometricViewController: UIViewController {

    
    private func authenticateWithBiometrics(completion: @escaping (Error?) -> Void) {
        let authenticationContext = LAContext()
        
        var localAuthenticationError: NSError?
        
        if authenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &localAuthenticationError),
            localAuthenticationError == nil {

            let reason: String
            
            switch authenticationContext.biometryType {
            case .touchID:
                reason = "Log in with your Touch ID"
            case .faceID:
                reason = "Log in with your Face ID"
            case .none:
                completion(LocalAuthenticationError.biometryNotAvailable)
                return
            }
            
            authenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if success {
                    completion(nil)
                } else {
                    if let localError = error {
                        completion(LocalAuthenticationError.forwarded(localError))
                    } else {
                        completion(LocalAuthenticationError.unknown)
                    }
                }
            }
            
        } else {
            if let error = localAuthenticationError {
                completion(LocalAuthenticationError.forwarded(error))
            } else {
                completion(LocalAuthenticationError.unknown)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        authenticateWithBiometrics { (authenticationError) in
            var title = "Success"
            var message = "You logged in successfully using biometrics"
            
            if let error = authenticationError {
                title = "Failure"
                message = "Could not authenticate using biometrics. Reason: \(error)"
            }
            
            DispatchQueue.main.async {
                let alertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                
                let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alertController.addAction(dismissAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

