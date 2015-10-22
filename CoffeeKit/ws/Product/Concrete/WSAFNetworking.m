//
//  WSAFNetworking.m
//  Top50ForReddit
//
//  Created by Fly on 10/21/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import "WSAFNetworking.h"

#import "WSConnectionAFNetworking.h"
#import <RestKit/RestKit.h>

#import "DataOM.h"
#import "ImageOM.h"
#import "SourceOM.h"


@interface WSAFNetworking()

@property (nonatomic, strong) WSAFNetworking *wsAFNetworking;

@property (nonatomic, strong) RKResponseDescriptor *responseDescriptor;
@property (nonatomic, strong) WSConnectionAFNetworking *wsConnectionAFNetworking;

@end


@implementation WSAFNetworking

#pragma mark - Singleton Pattern implementation

static WSAFNetworking* _instance;

+(void)initialize{
    if(self == [WSAFNetworking class]){
        _instance = [[WSAFNetworking alloc]init];
    }
}

-(id)init{
    self = [super init];
    if(self){
        
        //Initialite own parammeters
        
        //Object manager configuration
        _wsConnectionAFNetworking = [WSConnectionAFNetworking getInstance];
        
    }
    return self;
}

+(id)getInstance{
    return _instance;
}


#pragma mark - Protocol methos implementation

-(void)getTopListWithLimit:(NSInteger) limit {
    
    
    //RESPONSE DESCRIPTOR CONFIGURATION
    

    // Mapping the <Children> object. Item of top list object
    
    RKObjectMapping *dataMapping = [RKObjectMapping mappingForClass:[DataOM class]];
    
    [dataMapping addAttributeMappingsFromDictionary:@{
//                                                      @"kind":@"kind"
                                                      @"num_comments": @"numberOfComments",
                                                      @"created":@"created",
                                                      @"thumbnail":@"thumbnail",
                                                      @"title":@"title",
                                                      @"author":@"author"
                                                      }];
    
    // Mapping the first attribute of <Data> object. <Image> object.
    
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[ImageOM class]];
    [imageMapping addAttributeMappingsFromDictionary:@{
                                                       @"id":@"imageId"
                                                       }];
    
    
    // Mapping the first attribute of <Data> object. <Source> object.
    
    RKObjectMapping *sourceMapping = [RKObjectMapping mappingForClass:[SourceOM class]];
    [sourceMapping addAttributeMappingsFromDictionary:@{
                                                        @"url":@"url",
                                                        @"width":@"width", @"height":@"height"
                                                        }];
    
    
    // Nesting objects
    
    [dataMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"preview.images"
                                                                                toKeyPath:@"imageArray"
                                                                              withMapping:imageMapping]];
    
    [imageMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"source"
                                                                                 toKeyPath:@"sourceOM"
                                                                               withMapping:sourceMapping]];
    
    //Seting up response descriptor
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:dataMapping
                                                                                            method:RKRequestMethodPOST
                                                                                       pathPattern:nil
                                                                                           keyPath:@"data.children.data"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    //Adding request and response descriptor to ObjectManager
    
    [[_wsConnectionAFNetworking objectManager] addResponseDescriptor:responseDescriptor];
    
    
    //Nesting the blocks to handle the success or failire routines
    
    //Adding parammeter to request
    NSNumber *limitNumber = [[NSNumber alloc] initWithInteger:limit];
    NSDictionary *queryParams  = @{@"limit":limitNumber};
    
    [[_wsConnectionAFNetworking objectManager] getObjectsAtPath:@"/top.json"
                                                     parameters:queryParams
                                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                            NSLog(@"success block");
                                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                            NSLog(@"failure block");
                                                        }];

    
    
}

@end
