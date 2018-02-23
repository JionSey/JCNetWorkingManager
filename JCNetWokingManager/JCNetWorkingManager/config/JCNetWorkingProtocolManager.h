
#import <Foundation/Foundation.h>
#import "JCNetWorkingModelProtocol.h"
#import "JCNetWorkingCacheProtocol.h"

@interface JCNetWorkingProtocolManager: NSObject

+ (instancetype)showJCNetWorkingProtocolManager;

@property (nonatomic, copy) Class <JCNetWorkingModelProtocol> netWorkingModelProtocolClass;
@property (nonatomic, strong) id <JCNetWorkingCacheProtocol> netWorkingCacheTool;

@end
