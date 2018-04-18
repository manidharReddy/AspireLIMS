//
//  IMIHLDBManager.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 15/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLDBManager.h"

static IMIHLDBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation IMIHLDBManager
+(IMIHLDBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}



-(BOOL)createDB{
    
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"IMIHL.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            
            
            const char *sql_stmt_patientlogin ="create table if not exists patientlogin(pid integer primary key autoincrement, username text,password  text)";
            if (sqlite3_exec(database, sql_stmt_patientlogin, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                //NSLog(@"Failed to create patientlogin table");
            }
            
            
            
            const char *sql_stmt_patientinfo ="create table if not exists patientinfo(patientid text primary key, patientfirstname text,patientlastname  text,patientgender text,patientdob text,patientemail text,patientmobile text,patientbloodg text,patientimg blob)";
            if (sqlite3_exec(database, sql_stmt_patientinfo, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                //NSLog(@"Failed to create patientinfo table");
            }
            
            const char *sql_stmt_reportsinfo ="create table if not exists reportslist(testid text, testname text,type text, testdate text,departid text,units text,departname text,testminvalue text,testmaxvalue text,testresultvalue text,criticallowvalue text,criticalhighvalue text,isEntered INTEGER)";
            
            
            if (sqlite3_exec(database, sql_stmt_reportsinfo, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                //NSLog(@"Failed to create reportslist table");
            }
            
            
            const char *sql_stmt_appointmentsinfo ="create table if not exists appointmentlist(apptid text primary key, testname text,testdate text,departname text,testtime text)";
            
            
            if (sqlite3_exec(database, sql_stmt_appointmentsinfo, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                //NSLog(@"Failed to create appointments table");
            }
            
            const char *sql_stmt_alltestsinfo ="create table if not exists testslist(testid text, testname text,type text, testdate text,testtime text,departid text,units text,departname text,testminvalue text,testmaxvalue text,testresultvalue text,criticallowvalue text,criticalhighvalue text,isEntered INTEGER)";
            
            
            if (sqlite3_exec(database, sql_stmt_alltestsinfo, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                //NSLog(@"Failed to create testslist table");
            }
            
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            //NSLog(@"Failed to open/create database");
        }
    }
     
    return isSuccess;
    
    //return YES;
}

-(BOOL)saveGroupTests:(NSString*)testid :(NSString*)testname :(NSString*)type :(NSString*)testdate :(NSString*)testtime :(NSString*)departid :(NSString*)units :(NSString*)departname :(NSString*)testminvalue :(NSString*)testmaxvalue :(NSString*)testresultvalue :(NSString*)criticallowvalue :(NSString*)criticalhighvalue :(int)isEntered{
    @try {
        
    
    //NSLog(@"savegrouptests");
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into testslist (testid,testname, type,testdate,testtime,departid,units,departname,testminvalue,testmaxvalue,testresultvalue,criticallowvalue,criticalhighvalue,isEntered) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\")",testid,testname, type, testdate,testtime,departid,units,departname,testminvalue,testmaxvalue,testresultvalue,criticallowvalue,criticalhighvalue,isEntered];
        NSLog(@"insertsql:%@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"yes success");
            return YES;
        }
        else {
        //NSLog(@"Error while saving tests. %s", sqlite3_errmsg(database));
            NSLog(@"No Failed");
            return NO;
        }
       
        //sqlite3_reset(statement);
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    } @catch (NSException *exception) {
        NSLog(@"exception savegroups:%@",exception);
    } @finally {
        //NSLog(@"finallyyyy savegroups");
    }
    return NO;
}


-(int)deleteGroupTestsInfoDB{
    //sqlite3_stmt *stmt2;
    NSString *delete;
    int x = 0;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        delete=[[NSString alloc]initWithFormat:@"DELETE from testslist"];
        //update=[[NSString alloc]initWithFormat:@"DROP TABLE cart;"];
        
        //NSLog(@"delete:%@",delete);
        x = sqlite3_prepare_v2(database, [delete UTF8String], -1, &statement, nil);
        NSLog(@" deleteGroupTestsInfoDB x=%d",x);
        
    }
    if (sqlite3_step(statement) != SQLITE_DONE)
         NSLog(@" deleteGroupTestsInfoDB Deletion Error.");
    sqlite3_finalize(statement);
    
    sqlite3_close(database);
    return x;
    
}
-(NSMutableArray<ALTest*>*)listOfTestsFilteredByDate:(NSString*)testId{
    
    NSMutableArray<ALTest*>*listOfTests = nil;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        
        //NSLog(@"test:%@",testname);
        NSString *querySQL = [NSString stringWithFormat:@"select * from testslist WHERE testid='%@' LIMIT 5",testId];
        const char *query_stmt = [querySQL UTF8String];
        // NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            //if (sqlite3_step(statement) == SQLITE_ROW)
           listOfTests = [NSMutableArray new];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSLog(@"getallll");
                
                ALTest*testObj = [ALTest new];
                NSString *testid_str = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 0)];
                testObj.testid = testid_str;
                NSLog(@"testid in db:%@",testid_str);
                NSString *testname_str = [[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 1)];
                testObj.testname = testname_str;
                
                //NSLog(@"testname from db:%@",testname_str);
                
                NSString *type_str = [[NSString alloc]initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 2)];
                testObj.type = type_str;
                
                NSString *testdate_str = [[NSString alloc]initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 3)];
                testObj.testdatesplit = testdate_str;
                
                NSString *testtime_str = [[NSString alloc]initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 4)];
                testObj.testtimesplit = testtime_str;
                
                
                NSString *deptid_str = [[NSString alloc]initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 5)];
                testObj.departmentid = deptid_str;
                
                NSString *units_str = [[NSString alloc]initWithUTF8String:
                                       (const char *) sqlite3_column_text(statement, 6)];
                testObj.testunits = units_str;
                
                NSString *departname_str = [[NSString alloc]initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 7)];
                testObj.departmentname = departname_str;
                
                NSString *testminvalue_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 8)];
                testObj.testminvalue = testminvalue_str;
                
                NSString *testmaxvalue_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 9)];
                testObj.testmaxvalue = testmaxvalue_str;
                
                NSString *testresultvalue_str = [[NSString alloc]initWithUTF8String:
                                                 (const char *) sqlite3_column_text(statement, 10)];
                testObj.testresultvalue = testresultvalue_str;
                
                NSString *criticallowvalue_str = [[NSString alloc]initWithUTF8String:
                                                  (const char *) sqlite3_column_text(statement, 11)];
                testObj.testcriticallowvalue = criticallowvalue_str;
                
                NSString *criticalhighvalue_str = [[NSString alloc]initWithUTF8String:
                                                   (const char *) sqlite3_column_text(statement, 12)];
                
                testObj.testcriticallowvalue = criticalhighvalue_str;
                
                NSString *isEntered_str = [[NSString alloc]initWithUTF8String:
                                           (const char *) sqlite3_column_text(statement, 13)];
                 testObj.isentered = isEntered_str;
                
                [listOfTests addObject:testObj];
                // sqlite3_finalize(statement);
                //sqlite3_close(database);
                
                //return self;
            }
            //else{
            //  //NSLog(@"Not found");
            //return self;
            //}
            // sqlite3_reset(statement);
        }
    }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return listOfTests;
}

@end
