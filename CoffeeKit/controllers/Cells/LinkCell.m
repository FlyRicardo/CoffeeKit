//
//  LinkCell.m
//  CoffeeKit
//
//  Created by Fly on 10/22/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "LinkCell.h"
#import "CacheManager.h"

@implementation LinkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void) setLink:(DataOM*)data index:(int)index{
    
    // Image of row
    
    [self setCacheImage:data];
    
    // Title of link
    
    [[self linkTitleLable]setText:[data title]];
    
}

// Use this method to keep on cache the most recurrent images

- (void) setCacheImage:(DataOM*)data{
    
    UIImage *cached_image = [[CacheManager sharedCacheController] getCachedImage:[NSString stringWithFormat:@"image-%@",[data thumbnailUrl]]];
    
    if(cached_image != nil){
        [_linkImage setImage:cached_image];
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSURL * imageURL = [NSURL URLWithString:[data thumbnailUrl]];
            NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage * image = [UIImage imageWithData:imageData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_linkImage setImage: image];
                [[CacheManager sharedCacheController] setCachedImage:image name:[NSString stringWithFormat:@"image-%@", [data name]]];
            });
        });
    }
}



@end
