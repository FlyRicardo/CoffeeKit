//
//  WSAFNetworking.h
//  Top50ForReddit
//
//  Created by Fly on 10/21/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSAFNetworking : NSObject

-(void)getTopListWithLimit:(NSInteger) limit;

+(id)getInstance;

@end
