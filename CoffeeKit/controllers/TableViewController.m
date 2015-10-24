//
//  TableViewController.m
//  Top50ForReddit
//
//  Created by Fly on 10/21/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "TableViewController.h"
#import "LinkCell.h"

#import "WebServicesAbstractFactory.h"
#import "WSTopReddit.h"

#import "Constants.h"

#import "ASFSharedViewTransition.h"
#import "DetailViewController.h"
#import "ImageOM.h"

@interface TableViewController () <ASFSharedViewTransitionDataSource>

@property(nonatomic) NSArray* linkArray;

@property id wsTopReddit;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Put a waitter sppiner
    
    _wsTopReddit = [WebServicesAbstractFactory createWebServiceTopReddit:AFNetworkingType];
    [_wsTopReddit getTopListWithLimit:50];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [self registerNotifyProcess];
}

-(void) viewWillDisappear:(BOOL)animated{
    [self unregisterNotifyProcess];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_linkArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell
    
    NSString *identifier = @"LinkCell";
    
    LinkCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[LinkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell setLink:[_linkArray objectAtIndex:[indexPath row]] index:(int)[indexPath row]];

    
    return cell;
}


#pragma mark - Notifying Web services proccess

-(void)registerNotifyProcess{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveRedditTopXNotification:)
                                                 name:REDDIT_TOP_X_RESPONSE_NOTIFICATION
                                               object:nil];

}

-(void) unregisterNotifyProcess{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:REDDIT_TOP_X_RESPONSE_NOTIFICATION
                                                  object:nil];
}

-(void)receiveRedditTopXNotification:(NSNotification *) notification{
    NSDictionary *dictionary = notification.userInfo;
    if(![dictionary[REDDIT_TOP_X_RESPONSE] isKindOfClass:[NSError class]]){
        _linkArray = dictionary[REDDIT_TOP_X_RESPONSE];
        [self.tableView reloadData];
    }else{
        //Launch pop up notifying user about error
    }

}

#pragma mark - Navigation rules

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        // Get the selected item index path
        NSIndexPath *selectedIndexPath = [[self tableView]indexPathForSelectedRow];
        
        // Set the thing on the view controller we're about to show
        if (selectedIndexPath != nil) {
            DetailViewController *detailVC = segue.destinationViewController;
            DataOM* data = _linkArray[selectedIndexPath.row];
            
            ImageOM *imageOM = [[data imageArray]objectAtIndex:0];
            detailVC.source = [imageOM sourceOM];
        }
    }
}



#pragma mark - ASFSharedViewTransitionDataSource

- (UIView *)sharedView
{
    LinkCell *linkCell =  (LinkCell*)[self tableView:[self tableView] cellForRowAtIndexPath:[[self tableView]indexPathForSelectedRow]];
    
    return [linkCell imageView];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
