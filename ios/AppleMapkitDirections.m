#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(AppleMapkitDirections, NSObject)

RCT_EXTERN_METHOD(getAppleMapKitDirections:
                  (NSDictionary *)origin
                  toDestination:(NSDictionary *)destination
                  byTransitType:(NSString *)transitType
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject)
+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
