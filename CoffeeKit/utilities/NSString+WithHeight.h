//
//  NSString+WithHeight.h
//  CoffeeKit
//
//  Created by Fly on 10/24/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (WithHeight)

- (CGFloat)widthWithFont:(UIFont *)font;

- (CGFloat)heigthWithWidth:(CGFloat)width andFont:(UIFont *)font;

@end
