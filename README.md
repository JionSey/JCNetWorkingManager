## iOS 一个模块化，接口化的网络缓存工具
做iOS开发也有一段时间了，也去了很多公司，接触了许多的网络工具。但是很多工具对业务的耦合性比较高，很难脱离业务层。现在我对网络工具进行了一些优化，实现了接口化及模块化。使该工具更加易用，低耦合，可模块化。

### 1.模块详解

####1.1 结构简图
![模块化结构图](https://github.com/JionSey/JCNetWorkingManager/blob/master/屏幕快照%202018-02-23%2010.35.48.png?raw=true)

####1.2 类模块解释
####config

- JCNetWorkingEnvironmentConfigure 域名及环境的全局配置
- JCNetWorkingProtocolManager 模型转换和缓存功能实例化单例（此类对两层协议进行类绑定）
采用协议的方式进行实现可将接口统一，之后如果需要修改sdk只需要修改实现类即可，不会让sdk代码入侵业务代码之中

####protocol
- JCNetWorkingBusinessServiceProtocol 请求服务协议
- JCNetWorkingModelProtocol           模型转换协议(主要实现字典与模型之间的转换)
- JCNetWorkingCacheProtocol           缓存功能协议(主要实现数据缓存)
- JCNetWorkingServiceProtocol  网络请求的主要实现协议

####custom
- JCNetWorkingBusinessService  基础服务协议实现类,绑定了功能组件
- JCNetWorkingModelTool        模型转换实现类
- JCNetWorkingCacheTool        缓存功能实现类
- JCNetWorkingServiceTool      网络请求实现类
- JCNetWorkingClient           此类使用AFNetWorking对网络请求的post get update进行了实现
- JCNetWorkingRequest          网络请求工具请求对象（封装和定义了请求参数及缓存功能）

####model
- JCNetWorkingParameterModel         基础请求体模型
- JCNetWorkingResponseModel          基础返回体模型
- JCNetWorkingErrorResponseModel  错误返回体模型

####tool
- NSString+JCNetWoringUtil       将json字典直接转化为格式好的json字符串
- NSDictionary+JCNetWoringUtil   字典去空工具

### 2.使用的sdk
1.AFNetworking
2.MJExtension
3.YYCache

