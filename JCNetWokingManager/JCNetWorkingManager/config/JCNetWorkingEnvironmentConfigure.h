
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JCNetWorkingEnvironmentType) {
    JCNetWorkingEnvironmentTypeTest,
    JCNetWorkingEnvironmentTypeOnline
};

typedef NS_ENUM(NSInteger , JCDomainType) {
    JCDomainTypeDefault,
    JCDomainTypeHome
};

@interface JCNetWorkingEnvironmentConfigure: NSObject

@property (nonatomic, assign) JCNetWorkingEnvironmentType environmentType;
@property (nonatomic, copy) NSString *HTTPHost;
@property (nonatomic, copy) NSString *HomeHost;

+ (instancetype)showJCEnvironmentConfigure;
    
- (NSString *)configPathWithDomainTypeDefault:(JCDomainType)domainTypeDefault path:(NSString *)path;

@end
