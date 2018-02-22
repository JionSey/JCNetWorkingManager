
#import "JCNetWorkingEnvironmentConfigure.h"

@interface JCNetWorkingEnvironmentConfigure ()

@end

@implementation JCNetWorkingEnvironmentConfigure

#pragma mark - Init Method

static id _showJCEnvironmentConfigureInstance;
+ (instancetype)showJCEnvironmentConfigure {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        _showJCEnvironmentConfigureInstance = [[[self class] alloc] init];
    });
    return _showJCEnvironmentConfigureInstance;
}

- (id)init {
    
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - InitData

- (void)initData {
    
}

#pragma mark - Config Data

#pragma mark - System Delegate

#pragma mark - Custom Delegate

#pragma mark - Event Response

#pragma mark - NSNotificationCenter Method

#pragma mark - other Match

#pragma mark - Getters & Setters

- (void)setEnvironmentType:(JCNetWorkingEnvironmentType)environmentType {
    
    _environmentType = environmentType;
    switch (environmentType) {
            case JCNetWorkingEnvironmentTypeTest:
        {
            _HTTPHost = @"http://www.baidu.com";
            _HomeHost = @"http://www.google.com";
        }
            break;
            case JCNetWorkingEnvironmentTypeOnline:
        {
            _HTTPHost = @"http://www.baidu.com";
            _HomeHost = @"http://www.google.com";
        }
            break;
        default:
            break;
    }
}
    
- (NSString *)configPathWithDomainTypeDefault:(JCDomainType)domainTypeDefault path:(NSString *)path {
    
    switch (domainTypeDefault) {
        case JCDomainTypeDefault:
        {
            return [[JCNetWorkingEnvironmentConfigure showJCEnvironmentConfigure].HTTPHost stringByAppendingString:path];
        }
        break;
        case JCDomainTypeHome:
        {
            return [[JCNetWorkingEnvironmentConfigure showJCEnvironmentConfigure].HomeHost stringByAppendingString:path];
        }
        break;
    }
}

@end
