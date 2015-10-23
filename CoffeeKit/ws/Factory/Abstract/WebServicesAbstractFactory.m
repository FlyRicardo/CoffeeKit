//
//  WebServiceFactory.m
//  CC
//
//  Created by Fly on 11/25/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServicesAbstractFactory.h"

#import "WebServicesAFNetworkingFactory.h"
#import "WebServicesNSURLSessionFactory.h"


@implementation WebServicesAbstractFactory

#pragma mark - Singleton Pattern implementation

static WebServicesAbstractFactory* _instance;

+(void)initialize{
    if(self == [WebServicesAbstractFactory class]){
        _instance = [[WebServicesAbstractFactory alloc]init];
    }
}

-(id)init{
    self = [super init];
    if(self){
        //Initialite own parammeters
    }
    return self;
}

+(id)getInstance{
    return _instance;
}

#pragma mark - interface implementations

+(id<WSTopReddit>) createWebServiceTopReddit:(OutputTypes)type{
    
    switch (type) {
        case AFNetworkingType:
        {
            return [WebServicesAFNetworkingFactory createWebServiceTopReddit];//Method of Class
        }
        case NSURLSessionTYpe:
        {
            return [WebServicesNSURLSessionFactory createWebServiceTopReddit];//Method of Class

        }
            
        default:
            break;
    }
    return nil;
}

@end