import Foundation
import Paywall

@objc(Superwall)
class Superwall: RCTEventEmitter {
    
    public static var emitter: RCTEventEmitter!

      override init() {
        super.init()
        Superwall.emitter = self
      }

      open override func supportedEvents() -> [String] {
        ["superwallAnalyticsEvent"]
      }
    
    
    @objc(initPaywall:revenueCatApiKey:)
    func initPaywall(superwallApiKey:String, revenueCatApiKey:String) -> Void {
        PaywallService.initPaywall(superwallApiKey: superwallApiKey, revenueCatApiKey: revenueCatApiKey)
    }
    
    @objc(setRegister:)
    func setRegister(isRegister:String) -> Void {
    let attributes: [String: Any] = [
          "register": isRegister,
          "testing": "false"
        ]
        Paywall.setUserAttributes(attributes)
    }

    @objc(identify:)
    func identify(userId:String) -> Void {
        Paywall.identify(userId: userId)
    }

    @objc(reset:)
    func reset(test:String) -> Void {
        Paywall.reset()
    }

    @objc(trigger:resolver:rejecter:)
    func trigger(campaignName:String, resolver: @escaping RCTPromiseResolveBlock,  rejecter: @escaping RCTPromiseRejectBlock) -> Void {
        
        Paywall.trigger(
          event: campaignName,
          params: nil,
          onSkip: { error in
            rejecter("error", error?.description, nil)
          },
          onPresent: nil,
          onDismiss: { didPurchase, productId, paywallInfo in
              if didPurchase {
                  resolver(["didPurchase": true, "productId": productId])
              } else {
                resolver(["didPurchase": false, "productId": nil])
              }
            }
        )
    }

    
}
