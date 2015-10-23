//
//  WebServicesAFNetworking.m
//  CoffeeKit
//
//  Created by Fly on 10/22/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "WebServicesAFNetworkingFactory.h"
#import "WS_AFNetworkingTopReddit.h"

@implementation WebServicesAFNetworkingFactory

#pragma mark - Singleton Pattern implementation

static WebServicesAFNetworkingFactory* _instance;

+(void) initialize{
    if(self==[WebServicesAFNetworkingFactory class]){
        _instance = [[WebServicesAFNetworkingFactory alloc] init];
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
    return [WS_AFNetworkingTopReddit getInstance];
}

@end
