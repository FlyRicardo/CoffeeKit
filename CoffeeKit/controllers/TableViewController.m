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

#import "NSString+WithHeight.h"


@interface TableViewController () <ASFSharedViewTransitionDataSource>

@property(nonatomic) NSArray* linkArray;

@property id wsTopReddit;

@property (strong, nonatomic) NSMutableDictionary *cellHeightList;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Put a waitter sppiner
    
    _wsTopReddit = [WebServicesAbstractFactory createWebServiceTopReddit:AFNetworkingType];
    [_wsTopReddit getTopListWithLimit:50];
    
    _cellHeightList = [[NSMutableDictionary alloc]init];
    
//    self.tableView.estimatedRowHeight = REDDIT_K_NORMAL_CELL_HEIGHT; // for example. Set your average height
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    [self.tableView reloadData];
    
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
    
    
    NSString* indexPathString = [self indexPathToStringKey:indexPath];          // Convert NSIndexPath to single String,
                                                                                // making faster looking the key on data structure
    
    [self calculateHeightRow:cell indexPathString:indexPathString];             // Save cell height that are greater than,
                                                                                // REDDIT_K_NORMAL_CELL_HEIGHT

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* indexPathString = [self indexPathToStringKey:indexPath];
    
    if([_cellHeightList valueForKey:indexPathString]){                          // If the selected row (indexPath),
                                                                                // in the _cellHeihtList array,
                                                                                // then return that value
        return [[_cellHeightList valueForKey:indexPathString] floatValue];
    }
    
    return REDDIT_K_NORMAL_CELL_HEIGHT;

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

#pragma mark - utilities of class

// Use this method to convert an NSIndexPath, to String Object key.

-(NSString*) indexPathToStringKey:(NSIndexPath *)indexPath{
    int indexPathInt = (int)[indexPath row];
    return [NSString stringWithFormat:@"%i",indexPathInt];
}

// Use this method to calculate the height of specific row, adding the dj label height to wrapper row that gonna wrap this label

-(void) calculateHeightRow:(LinkCell*) cell indexPathString:(NSString*)indexPath{
    
//    (CGFloat)heigthWithWidth:(CGFloat)width andFont:(UIFont *)font

    NSString* text = [[cell linkTitleLable]text];
    
    CGRect titleFrame = [[cell linkTitleLable] bounds];
    float titleHegiht = [text heigthWithWidth:titleFrame.size.width andFont:[UIFont systemFontOfSize:15.0]];

    CGRect howLongFrame = [[cell howLongCreatedLinkLabel] bounds];;
    float howLongHeight = howLongFrame.size.height;
    
    CGRect numComentsFrame = [[cell numberOfCommentsLinkLabel] bounds];;
    float numComentsHeight = numComentsFrame.size.height;
    
    float currentCellHeight = 5. + titleHegiht + 5. + howLongHeight + 5. + numComentsHeight + 5.;
    
    if(currentCellHeight > REDDIT_K_NORMAL_CELL_HEIGHT){
        
        NSNumber* cellHeight = [NSNumber numberWithFloat:currentCellHeight];
        [_cellHeightList setValue:cellHeight forKey:indexPath];
        
        // Test
        if([indexPath isEqualToString:@"1"]){
            NSLog(@"----------------------------------");
            NSLog(@"");
            NSLog(@"%@",[NSString stringWithFormat:@"Height of title: %f ",titleHegiht]);
            NSLog(@"%@",[NSString stringWithFormat:@"Height of howLongFrame: %f ",howLongHeight]);
            NSLog(@"%@",[NSString stringWithFormat:@"Height of numComentsFrame: %f ",numComentsHeight]);
            NSLog(@"%@",[NSString stringWithFormat:@"Value of variable height %f",currentCellHeight]);
            NSLog(@"Cell 1 heigth on special array: %f",[[_cellHeightList valueForKey:@"1"] floatValue]);
            NSLog(@"%@",[NSString stringWithFormat:@"Text of label title: %@", [[cell linkTitleLable] text]]);
            NSLog(@"");
            NSLog(@"----------------------------------");
        }

        
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
