//
//  WebServicesNSURLSession.m
//  CoffeeKit
//
//  Created by Fly on 10/22/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "WebServicesNSURLSessionFactory.h"
#import "WS_NSURLSessionTopReddit.h"

@implementation WebServicesNSURLSessionFactory

#pragma mark - Singleton Pattern implementation

static WebServicesNSURLSessionFactory* _instance;

+(void) initialize{
    if(self==[WebServicesNSURLSessionFactory class]){
        _instance = [[WebServicesNSURLSessionFactory alloc] init];
    }
}

-(id) init{
    self = [super init];
    if(self){
        //Initiate self parammeters
    }
    return self;
}

+(id)getInstance{
    return _instance;
}

#pragma mark - Protocol methos implementation

+(id<WSTopReddit>) createWebServiceTopReddit{
    return [WS_NSURLSessionTopReddit  getInstance];
}

@end
