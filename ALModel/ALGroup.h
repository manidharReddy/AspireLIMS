//
//  ALGroup.h
//  AspireLIMS
//
//  Created by ihub on 10/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALTest.h"
@interface ALGroup : NSObject
@property (strong,nonatomic) NSString*groupName;
@property (strong,nonatomic) NSString*groupDate;
@property (strong,nonatomic) NSString*groupTime;
@property (strong,nonatomic) NSString*groupIsEntered;
@property (strong,nonatomic) NSDictionary<NSString*,NSDictionary *>*tests;

+(ALGroup*)getSharedInstance;
-(void)allocate;
@end
