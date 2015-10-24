//
//  DetailViewController.h
//  CoffeeKit
//
//  Created by Fabian  Rodriguez Avellaneda on 9/29/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SourceOM.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic)SourceOM* source;

@end

