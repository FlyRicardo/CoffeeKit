//
//  WSConnectionAFNetworking.h
//  Top50ForReddit
//
//  Created by Fly on 10/21/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface WS_AFNetworkingConnection : NSObject

@property (nonatomic, strong) RKObjectManager *objectManager;

+(id)getInstance;

@end
