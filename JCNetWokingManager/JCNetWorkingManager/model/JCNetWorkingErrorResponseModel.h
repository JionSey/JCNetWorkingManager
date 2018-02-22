//
//  JCNetWorkingErrorResponseModel.h
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "JCNetWorkingResponseModel.h"

typedef NS_ENUM(NSInteger, JCErrorCode) {
    JCNoCacheError = -1L,
    JCGeneralError = -2L,
    JCIllegalInputError = -3L,
    JCResponseFormatError = -4L,
    JCNoNetworkConnectError = -5L,
    JCServerUnReachabilityError = -6L,
    JCCancelRequestError = -7L,
    JCEntityNotFoundError = -8L
};

@interface JCNetWorkingErrorResponseModel : JCNetWorkingResponseModel

+ (instancetype)initWithErrorCode:(JCErrorCode)error;

@end
