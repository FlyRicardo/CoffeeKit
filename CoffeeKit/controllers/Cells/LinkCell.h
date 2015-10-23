//
//  LinkCell.h
//  CoffeeKit
//
//  Created by Fly on 10/22/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataOM.h"


@interface LinkCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *linkImage;
@property (weak, nonatomic) IBOutlet UILabel *linkTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *howLongCreatedLinkLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLinkLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfCommentsLinkLabel;

-(void) setLink:(DataOM*)data index:(int)index;

@end
