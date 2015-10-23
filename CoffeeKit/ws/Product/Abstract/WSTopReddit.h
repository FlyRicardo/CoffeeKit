//
//  TopReddit.h
//  CoffeeKit
//
//  Created by Fly on 10/22/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WSTopReddit

-(void)getTopListWithLimit:(NSInteger) limit;

@end