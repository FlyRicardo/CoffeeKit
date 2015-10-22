//
//  Data.h
//  CoffeeKit
//
//  Created by Fly on 10/21/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SourceOM;

@interface DataOM : NSObject

@property (nonatomic) NSString* kind;
@property (nonatomic) NSString* author;
@property (nonatomic) NSString* title;
@property (nonatomic) NSNumber* numberOfComments;
@property (nonatomic) NSDate* created;
@property (nonatomic) NSString* thumbnail;
@property (nonatomic, strong) NSArray* imageArray;

@end
