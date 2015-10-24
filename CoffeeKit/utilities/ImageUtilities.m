//
//  ImageUtilities.m
//  CoffeeKit
//
//  Created by Fly on 10/24/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "ImageUtilities.h"

@implementation ImageUtilities

#pragma mark - Singleton Pattern implementation

static ImageUtilities* _instance;

+(void)initialize{
    if(self == [ImageUtilities class]){
        _instance = [[ImageUtilities alloc]init];
    }
}

-(id)init{
    self = [super init];
    if(self){
        
        //Initialite own parammeters
        
        //Object manager configuration
        
    }
    return self;
}

+(id)getInstance{
    return _instance;
}


#pragma mark - Pool of Method to hanlde images

-(void) saveImageOnLibrary:(UIImage*) image{
    UIImageWriteToSavedPhotosAlbum(image,
                                   self, // send the message to 'self' when calling the callback
                                   @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), // the selector to tell the method to call on completion
                                   NULL); // you generally won't need a contextInfo here
}

-(void) copyImageOnPasteBoard:(NSString*) stringURL{
    
    NSURL * imageURL = [NSURL URLWithString:stringURL];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setData:imageData forPasteboardType:@"public.png"];
    
}

- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    if (error) {
        // Do anything needed to handle the error or display it to the user
        NSLog(@"Error savign image");
    } else {
        // .... do anything you want here to handle
        // .... when the image has been saved in the photo album
        
        NSLog(@"Image save successfully");
    }
}


@end
