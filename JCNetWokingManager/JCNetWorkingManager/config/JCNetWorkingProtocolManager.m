
#import "JCNetWorkingProtocolManager.h"
#import "JCNetWorkingModelTool.h"
#import "JCNetWorkingCacheTool.h"

@interface JCNetWorkingProtocolManager ()

@end

@implementation JCNetWorkingProtocolManager

#pragma mark - Init Method

static id _showJCNetWorkingProtocolManagerInstance;
+ (instancetype)showJCNetWorkingProtocolManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        _showJCNetWorkingProtocolManagerInstance = [[[self class] alloc] init];
    });
    return _showJCNetWorkingProtocolManagerInstance;
}

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self initData];
    }
    return self;
}

#pragma mark - InitData

- (void)initData {
    
    self.netWorkingModelProtocolClass = [JCNetWorkingModelTool class];
    self.netWorkingCacheTool = [JCNetWorkingCacheTool new];
    ((JCNetWorkingCacheTool *)self.netWorkingCacheTool).netWorkingModelProtocolClass = [JCNetWorkingModelTool class];
}

#pragma mark - Config Data

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Event Response

#pragma mark - NSNotificationCenter Method

#pragma mark - other Match

#pragma mark - Getters & Setters

@end
