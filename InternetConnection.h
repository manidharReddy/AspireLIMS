//
//  InternetConnection.h
//  Dentistkart
//
//  Created by ihub on 5/24/16.
//  Copyright © 2016 Google Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternetConnection : NSObject
+(InternetConnection*)getSharedInstance;
-(BOOL)CheckNetwork;
@end
