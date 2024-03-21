#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(Superwall, RCTEventEmitter)

RCT_EXTERN_METHOD(initPaywall:(NSString)superwallApiKey revenueCatApiKey:(NSString)revenueCatApiKey)

RCT_EXTERN_METHOD(setRegister:(NSString)isRegister)

RCT_EXTERN_METHOD(identify:(NSString)userId)

RCT_EXTERN_METHOD(reset)

RCT_EXTERN_METHOD(trigger:(NSString)campaignName resolver: (RCTPromiseResolveBlock)resolve rejecter: (RCTPromiseRejectBlock)reject)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
