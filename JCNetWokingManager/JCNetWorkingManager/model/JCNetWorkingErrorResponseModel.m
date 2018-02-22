//
//  JCNetWorkingErrorResponseModel.m
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCNetWorkingErrorResponseModel.h"

@implementation JCNetWorkingErrorResponseModel

+ (instancetype)initWithErrorCode:(JCErrorCode)error {
    
    JCNetWorkingErrorResponseModel *model = [[JCNetWorkingErrorResponseModel alloc] init];
    //        switch (error) {
    //        case MNNoCacheError:
    //
    //            break;
    //        case MNGeneralError:
    //
    //            break;
    //        case MNIllegalInputError:
    //            model.message = @"输入信息不合法！";
    //            break;
    //        case MNResponseFormatError:
    //            model.message = @"数据格式错误";
    //            break;
    //        case MNNoNetworkConnectError:
    //            model.message = @"网络错误";
    //            break;
    //        case MNServerUnReachabilityError:
    //            model.message = @"无法连接网络";
    //            break;
    //        case MNCancelRequestError:
    //            model.message = @"请求已取消";
    //            break;
    //        case MNEntityNotFoundError:
    //            model.message = @"无数据";
    //            break;
    //    }
    
    model.message = @"请检测您的网络！";
    return model;
}

@end
