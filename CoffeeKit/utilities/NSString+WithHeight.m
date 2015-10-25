//
//  NSString+WithHeight.m
//  CoffeeKit
//
//  Created by Fly on 10/24/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "NSString+WithHeight.h"

@implementation NSString (WithHeight)

- (CGFloat)widthWithFont:(UIFont *)font
{
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:self attributes:attributes] size].width;
}

- (CGFloat)heigthWithWidth:(CGFloat)width andFont:(UIFont *)font
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [self length])];
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}


@end
