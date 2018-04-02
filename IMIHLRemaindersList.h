//
//  IMIHLRemaindersList.h
//  AspireLIMS
//
//  Created by ihub on 21/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALRemainders.h"
@interface IMIHLRemaindersList : NSObject
@property(strong,nonatomic) NSMutableArray*remainders;
-(IMIHLRemaindersList*)getRemainders:(NSDictionary*)response;
@end
