//
//  IMIHLDBManager.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 15/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ALTest.h"
@interface IMIHLDBManager : NSObject
{
    NSString *databasePath;
}
+(IMIHLDBManager*)getSharedInstance;
-(BOOL)createDB;

-(BOOL)saveGroupTests:(NSString*)testid :(NSString*)testname :(NSString*)type :(NSString*)testdate :(NSString*)testtime :(NSString*)departid :(NSString*)units :(NSString*)departname :(NSString*)testminvalue :(NSString*)testmaxvalue :(NSString*)testresultvalue :(NSString*)criticallowvalue :(NSString*)criticalhighvalue :(int)isEntered;
- (IMIHLDBManager*)getAllGroupTestsDB:(NSString*)testname;
-(NSMutableArray<ALTest*>*)listOfTestsFilteredByDate:(NSString*)testId;

-(int)deleteGroupTestsInfoDB;


@end
