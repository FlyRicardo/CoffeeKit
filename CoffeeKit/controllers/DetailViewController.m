//
//  DetailViewController.m
//  CoffeeKit
//
//  Created by Fabian  Rodriguez Avellaneda on 9/29/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#import "DetailViewController.h"
#import "ASFSharedViewTransition.h"

#import "ImageUtilities.h"


@interface DetailViewController ()<ASFSharedViewTransitionDataSource>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initVariables];
    [self loadImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AlertController configuration

- (IBAction)SaveCopyImage:(id)sender {

    [self showAlertControllerSaveOrCopyImage];

}



#pragma mark - Action methods

-(void) showAlertControllerSaveOrCopyImage{
    
    
    UIAlertAction *saveImageAction;
    UIAlertAction *copyImageAction;
    UIAlertAction *cancelAction;
    
    UIAlertController * alertController= [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    saveImageAction = [UIAlertAction actionWithTitle:@"Save"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 //Call method to copy image on clipboard
                                                 [[ImageUtilities getInstance] saveImageOnLibrary:_imageView.image];
                                             }];
    
    copyImageAction = [UIAlertAction actionWithTitle:@"Copy"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 [[ImageUtilities getInstance] copyImageOnPasteBoard:[_source url]];
                                             }];
    
    
    cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                            style:UIAlertActionStyleCancel
                                          handler:^(UIAlertAction *action) {
                                              [alertController dismissViewControllerAnimated:YES completion:nil];
                                          }];
    
    [alertController addAction:saveImageAction];
    [alertController addAction:copyImageAction];
    [alertController addAction:cancelAction];
    [alertController setModalPresentationStyle:UIModalPresentationCurrentContext];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - Init resources and variables Image Utilities

-(void) initVariables{
    
}

-(void) loadImage{
    
    NSURL *imageURL = [NSURL URLWithString: [_source url]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    [_imageView setImage:image];
    
}

#pragma mark - ASFSharedViewTransitionDataSource

- (UIView *)sharedView
{
    return _imageView;
}


@end
