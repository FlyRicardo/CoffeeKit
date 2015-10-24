//
//  ImageUtilities.h
//  CoffeeKit
//
//  Created by Fly on 10/24/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageUtilities : UITableViewCell

+(id)getInstance;

-(void) saveImageOnLibrary:(UIImage*) image;
-(void) copyImageOnPasteBoard:(NSString*) stringURL;

@end
