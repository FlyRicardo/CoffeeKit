//
//  DetailViewController.h
//  CoffeeKit
//
//  Created by Fabian  Rodriguez Avellaneda on 9/29/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

