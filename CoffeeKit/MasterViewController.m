//
//  MasterViewController.m
//  CoffeeKit
//
//  Created by Fabian  Rodriguez Avellaneda on 9/29/14.
//  Copyright (c) 2014 ___FlyInc___. All rights reserved.
//

#define kCLIENTID @"YRZZSJZHTGVQLKXIAN5REWUZYAYWE2TMESCGL3HEX4W1MYRK"
#define kCLIENTSECRET @"OZS4K30DTGVJIVHI23WGNWR0HBKL4TIOL2ZHRH3T44U3WMD5"

#import "MasterViewController.h"
#import "DetailViewController.h"

#import <RestKit/RestKit.h>
#import "VenueCell.h"

#import "WebServicesAbstractFactory.h"
#import "WSTopReddit.h"


@interface MasterViewController ()

@property (nonatomic, strong) NSArray *venues;

@property id wsTopReddit;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Testing the WSAFNetworking connection
    _wsTopReddit = [WebServicesAbstractFactory createWebServiceTopReddit:AFNetworkingType];
    [_wsTopReddit getTopListWithLimit:50];
    
    
//    [self configureRestKit];
//    [self loadVenues];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _venues[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];

//    Venue *venue = _venues[indexPath.row];
//    cell.nameLabel.text = venue.name;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
