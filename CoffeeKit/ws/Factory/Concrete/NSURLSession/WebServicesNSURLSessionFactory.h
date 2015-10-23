//
//  WebServicesNSURLSession.h
//  CoffeeKit
//
//  Created by Fly on 10/22/15.
//  Copyright © 2015 ___FlyInc___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServicesAbstracFactoryProtocol.h"

@interface WebServicesNSURLSessionFactory : NSObject<WebServicesAbstracFactoryProtocol>

+(id)getInstance;

@end