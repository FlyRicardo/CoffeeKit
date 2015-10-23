//
//  WebServicesFactory.h
//  CC
//
//  Created by Fly on 11/25/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTopReddit.h"


typedef enum ouputTypes {
    NSURLSessionTYpe,
    AFNetworkingType
} OutputTypes;

@interface WebServicesAbstractFactory : NSObject

//+(id<WSLoginConnector>) createWebServiceLoginConnection:(OutputTypes)type;
+(id<WSTopReddit>) createWebServiceTopReddit:(OutputTypes)type;

@end



