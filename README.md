## iOS 一个模块化，接口化的网络请求工具JCNetWokingManager
做iOS开发也有一段时间了，也去了很多公司，接触了许多的网络工具。但是很多工具对业务的耦合性比较高，很难脱离业务层。现在我对网络工具进行了一些优化，实现了接口化及模块化。使该工具更加易用，低耦合，可模块化。

### 1.模块详解

#### 1.1 结构简图
![模块化结构图](https://github.com/JionSey/JCNetWorkingManager/blob/master/README_PIC/屏幕快照%202018-02-23%2010.35.48.png?raw=true)

#### 1.2 类模块解释
![工程结构图](https://github.com/JionSey/JCNetWorkingManager/blob/master/README_PIC/B7BD3EDC2ABF711F2B18BDEAB1DB5B37.png?raw=true)
#### config

- JCNetWorkingEnvironmentConfigure 域名及环境的全局配置
- JCNetWorkingProtocolManager 模型转换和缓存功能实例化单例（此类对两层协议进行类绑定）
采用协议的方式进行实现可将接口统一，之后如果需要修改sdk只需要修改实现类即可，不会让sdk代码入侵业务代码之中

#### protocol
- JCNetWorkingBusinessServiceProtocol 请求服务协议
- JCNetWorkingModelProtocol           模型转换协议(主要实现字典与模型之间的转换)
- JCNetWorkingCacheProtocol           缓存功能协议(主要实现数据缓存)
- JCNetWorkingServiceProtocol  网络请求的主要实现协议

#### custom
- JCNetWorkingBusinessService  基础服务协议实现类,绑定了功能组件
- JCNetWorkingModelTool        模型转换实现类
- JCNetWorkingCacheTool        缓存功能实现类
- JCNetWorkingServiceTool      网络请求实现类
- JCNetWorkingClient           此类使用AFNetWorking对网络请求的post get update进行了实现
- JCNetWorkingRequest          网络请求工具请求对象（封装和定义了请求参数及缓存功能）

#### model
- JCNetWorkingParameterModel         基础请求体模型
- JCNetWorkingResponseModel          基础返回体模型
- JCNetWorkingErrorResponseModel  错误返回体模型

#### tool
- NSString+JCNetWoringUtil       将json字典直接转化为格式好的json字符串
- NSDictionary+JCNetWoringUtil   字典去空工具

#### 1.3 使用的第三方sdk

1. AFNetworking （网络请求SDK）
2. MJExtension  （模型转换SDK）
3. YYCache      （数据缓存SDK）

### 2.架构思想解析
#### 2.1 接口化
##### 组件使用了协议进行了接口化，统一外部接口，让我们只需要关注内在的功能实现。在模型协议中，我们只要关注协议遵守对象对统一接口的实现即可。而不需要关注该对象在整个组件之间的逻辑，这样在我们需要更换SDK或者协议对象实现方式的时候就会更加方便和便捷。此处以模型协议JCNetWorkingModelProtocol做为例子进行讲解。
##### 我们定义一个需要统一接口的协议：JCNetWorkingModelProtocol

```
#import <Foundation/Foundation.h>

@protocol JCNetWorkingModelProtocol <NSObject>

// 模型变成字典
+ (NSDictionary *)configDictWithResponseModel:(id)responseObject;

// 将数据转换成模型
+ (id)configModelWithResponseObject:(id)responseObject class:(Class)cls;

@end
```

##### 我们定义一个实现该协议的对象：JCNetWorkingModelTool

```
#import <Foundation/Foundation.h>
#import "JCNetWorkingModelProtocol.h"

@interface JCNetWorkingModelTool : NSObject <JCNetWorkingModelProtocol>

@end
```

```
#import "JCNetWorkingModelTool.h"
#import "MJExtension.h"
#import "NSDictionary+JCNetWoringUtil.h"

@implementation JCNetWorkingModelTool

+ (NSDictionary *)configDictWithResponseModel:(id)responseObject {

return [[responseObject mj_keyValues] removeNullValues];
}

+ (id)configModelWithResponseObject:(id)responseObject class:(Class)cls {

if ([responseObject isKindOfClass:[NSArray class]]) {
return [cls mj_objectArrayWithKeyValuesArray:responseObject];
}
id responseModel = [cls mj_objectWithKeyValues:responseObject];
return responseModel;
}

@end
```

##### 在JCNetWorkingModelTool协议对象中，我们使用了第三方SDK MJExtension进行模型转换的实现，如果我们发现MJExtension出现了严重的bug，不再适合工程使用的时候，我们只需要关注协议方法的实现即可，只需要替换的SDK 实现协议功能即可，耦合性变得很低。当然该组件使用的是接口化的方式，protocol文件夹下的其他接口协议同样适用。

#### 2.2 模块化
##### 在测试项目中我们书写了一个首页网络请求模块。不同的开发人员只要集JCNetWorkingManager组件，并书写各自的网络服务协议便可按照各自的模块进行开发，使各个模块之间没有任何耦合。
##### 我们定义一个模块的网络层服务协议
```
#import <Foundation/Foundation.h>
#import "JCNetWorkingParameterModel.h"

@protocol JCHomeSerivceProtocol <NSObject>

/**
*
*  @brief 启动页
*
*/
- (void)requestStartUpWithParameter:(JCNetWorkingParameterModel *)parameterModel Success:(RequestSuccess)success failure:(RequestFailure)failure;

@end
```
##### 我们定义一个模块的网络层服务协议实现类JCHomeService，并实现协议方法即可。
```
#import "JCHomeService.h"

static NSString *const kStartPic = @"/zbs/index/startpic";       //启动图片

@implementation JCHomeService

- (void)requestStartUpWithParameter:(JCNetWorkingParameterModel *)parameterModel Success:(RequestSuccess)success failure:(RequestFailure)failure {

JCNetWorkingRequest *request = [JCNetWorkingRequest requestWithDomainType:JCDomainTypeHome path:kStartPic parameterModel:parameterModel responseClass:[JCHomeStarPageResponseModel class]];
request.netWorkingModelProtocolClass = self.netWorkingModelProtocolClass;
request.netWorkingCacheTool = self.netWorkingCacheTool;
[self sendRequest:request success:success failure:failure];
}

@end
```

### 3.使用详解
#### 3.1 工程环境及域名配置
##### 在正式使用项目的时候我们需要配置功能环境，以达到自动切换请求环境的目的。
![工程环境配置](https://github.com/JionSey/JCNetWorkingManager/blob/master/README_PIC/99DD33EDA6EC4B3CFA363E3362903269.png?raw=true)
##### 在Appdelegate书写转换代码，这样只要我们切换了编译环境。我们网络请求模块的域名就会自动修改为对应的环境域名。
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.

#ifdef TEST_ENV
[[JCNetWorkingEnvironmentConfigure showJCEnvironmentConfigure] setEnvironmentType:JCNetWorkingEnvironmentTypeTest];
#else
[[JCNetWorkingEnvironmentConfigure showJCEnvironmentConfigure] setEnvironmentType:JCNetWorkingEnvironmentTypeOnline];
#endif

return YES;
}
```
##### 在JCNetWorkingEnvironmentConfigure中对网络组件的总体域名进行定义并分类。在.h文件中定义了两个分类枚举分别为环境枚举，域名枚举。
```
typedef NS_ENUM(NSUInteger, JCNetWorkingEnvironmentType) {
JCNetWorkingEnvironmentTypeTest,
JCNetWorkingEnvironmentTypeOnline
};

typedef NS_ENUM(NSInteger , JCDomainType) {
JCDomainTypeDefault,
JCDomainTypeHome
};
```
##### 在JCNetWorkingEnvironmentConfigure.m中主要是定义具体域名。
```
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
```
#### 3.2 网络请求模块书写
##### 该模块的教程书写同2.2 模块化中的具体实现即可。

#### 3.3 具体使用
##### 在具体的控制器中定义协议服务对象，并发起请求即可。
```
- (void)requestStarPage {

[self.homeService requestStartUpWithParameter:[JCHomeStarPageParameterModel new] Success:^(JCHomeStarPageResponseModel * responseModel, BOOL isCache) {
NSLog(@"%@", responseModel);
} failure:^(JCNetWorkingErrorResponseModel *responseModel) {
NSLog(@"%@", responseModel);
}];
}

- (JCHomeService *)homeService {
-
if (!_homeService){
_homeService = [JCHomeService new];
}
return _homeService;
}
```
### 4.结语
##### 在组件架构的设计过程中只有不断的完善代码，并将组件之间，模块与组件的耦合降低，才能设计出更加高效和易于扩展的组件。欢迎给我留言并提出您宝贵的意见，如果喜欢记得给一颗星哦。

###### 传送门: [git地址](https://github.com/JionSey/JCNetWorkingManager)


