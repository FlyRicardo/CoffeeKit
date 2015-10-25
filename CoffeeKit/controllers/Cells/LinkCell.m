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
    
    // How long created link
    
    [[self howLongCreatedLinkLabel] setText:[self getHowLongCreated:[data created]]];
    
    // Author
    
    [[self authorLinkLabel]setText:[data author]];
    
    //Number of comments
    
    [[self numberOfCommentsLinkLabel] setText:[NSString stringWithFormat:@"%i %@",[[data numberOfComments] intValue], @"Comments"]];
    
}

// Use this method to keep on cache the most recurrent images

- (void) setCacheImage:(DataOM*)data{
    
    UIImage *cached_image = [[CacheManager sharedCacheController] getCachedImage:[NSString stringWithFormat:@"image-%@",[data thumbnailUrl]]];
    
    if(cached_image != nil){
        [_linkImage setImage:cached_image];
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            UIImage * image;
            
            if(![[data thumbnailUrl] isEqualToString:@""]){
                
                NSURL * imageURL = [NSURL URLWithString:[data thumbnailUrl]];
                NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
                image = [UIImage imageWithData:imageData];
                
            }else{
                
                image = [UIImage imageNamed:@"defaultImage"];
                
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [_linkImage setImage: image];
                [[CacheManager sharedCacheController] setCachedImage:image name:[NSString stringWithFormat:@"image-%@", [data name]]];
            });
            
        });
    }
    
}



#pragma mark - Method utilities

- (NSString*) getHowLongCreated:(NSDate*) created{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger startDay=[calendar ordinalityOfUnit:NSCalendarUnitHour
                                           inUnit:NSCalendarUnitEra
                                          forDate:created];
    NSInteger endDay=[calendar ordinalityOfUnit:NSCalendarUnitHour
                                         inUnit:NSCalendarUnitEra
                                        forDate:[NSDate date]];

    return [NSString stringWithFormat:@"%@ %li %@", @"Sent", labs(endDay-startDay), @"hours by"];
}

@end
