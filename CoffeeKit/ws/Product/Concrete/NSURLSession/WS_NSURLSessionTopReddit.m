//
//  WS_NSURLSessionTopReddit.m
//  CoffeeKit
//
//  Created by Fly on 10/22/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "WS_NSURLSessionTopReddit.h"

#import "WS_NSURLSessionConnection.h"


@interface WS_NSURLSessionTopReddit()

@property (nonatomic, strong) WS_NSURLSessionConnection *wsNSURLSessionConnection;

@end


@implementation WS_NSURLSessionTopReddit

#pragma mark - Singleton Pattern implementation

static WS_NSURLSessionTopReddit* _instance;

+(void)initialize{
    if(self == [WS_NSURLSessionTopReddit class]){
        _instance = [[WS_NSURLSessionTopReddit alloc]init];
    }
}

-(id)init{
    self = [super init];
    if(self){
        
        //Initialite own parammeters
        
        //Object manager configuration
        _wsNSURLSessionConnection = [WS_NSURLSessionTopReddit getInstance];
        
    }
    return self;
}

+(id)getInstance{
    return _instance;
}


#pragma mark - Protocol methos implementation

-(void)getTopListWithLimit:(NSInteger) limit {
}

@end
