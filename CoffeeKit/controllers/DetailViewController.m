//
//  DetailViewController.m
//  CoffeeKit
//
//  Created by Fabian  Rodriguez Avellaneda on 9/29/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "DetailViewController.h"
#import "ASFSharedViewTransition.h"


@interface DetailViewController ()<ASFSharedViewTransitionDataSource>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action methods

- (IBAction)SaveCopyImage:(id)sender {
    
    NSLog(@"Save or copy image");
}



#pragma mark - Image Utilities

-(void) loadImage{
    
    NSURL *imageURL = [NSURL URLWithString: [_source url]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    [_imageView setImage:image];
    
}

#pragma mark - AlertController configuration

-(void) showAlertControllerSaveOrCopyImage{
    
    UIAlertAction *saveImageAction;
    UIAlertAction *copyImageAction;
    
    UIAlertController * alertController= [UIAlertController alertControllerWithTitle:@"Confirma que desea guardar su perfil?"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    
}


#pragma mark - ASFSharedViewTransitionDataSource

- (UIView *)sharedView
{
    return _imageView;
}


@end
