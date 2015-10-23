//
//  WebServiceAbstracFactoryProtocol.h
//  Unitienda
//
//  Created by Fly on 4/14/15.
//  Copyright (c) 2015 ___FlyInc___. All rights reserved.
//

#import "WSTopReddit.h"

@protocol WebServicesAbstracFactoryProtocol

+(id<WSTopReddit>) createWebServiceTopReddit;

@end