
 import  UIKit
 import LocalAuthentication

 class LocalAuthorizationService {

     static let shared = LocalAuthorizationService()

     let localAuthContext = LAContext()
     var error: NSError?

     func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void) {
         if localAuthContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                               error: &error) {
             let reason = "Please authorize"
             localAuthContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                             localizedReason: reason) { success, error in
                 DispatchQueue.main.async {
                     guard success, error == nil else {
                         print("wrong face")
                         authorizationFinished(false)
                         return
                        
                     }
                     print("face is ok")
                     authorizationFinished(true)
                 }
             }
         } else {
             authorizationFinished(false)
            if let error = error as? LAError {
                print(error.localizedDescription)
            }
         }
     }
 }
