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


-(void)allocateArray{
    
    self.patienttestid_arr = [[NSMutableArray alloc]init];
    self.patienttesttype_arr = [[NSMutableArray alloc]init];
    self.patienttestname_arr = [[NSMutableArray alloc]init];
    self.patienttestrange_arr = [[NSMutableArray alloc]init];
    self.patienttestdate_arr = [[NSMutableArray alloc]init];
    self.patienttesttime_arr = [[NSMutableArray alloc]init];
    self.patienttestvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestunits_arr = [[NSMutableArray alloc]init];
    self.patienttestminvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestmaxvalue_arr = [[NSMutableArray alloc]init];
    self.patienttestisready = [[NSMutableArray alloc]init];
    self.departmentid_arr = [[NSMutableArray alloc]init];
    self.departmentname_arr = [[NSMutableArray alloc]init];
    self.patienttestlowcritical = [[NSMutableArray alloc]init];
    self.patienttesthighcritical = [[NSMutableArray alloc]init];
}
-(void)alloclogin{
    self.patientlogin_arr = [[NSMutableArray alloc]init];
}

-(void)appintmentArrayAlloc{
    self.apptdate_arr = [[NSMutableArray alloc]init];
    self.apptest_arr = [[NSMutableArray alloc]init];
    self.departmentname_arr = [[NSMutableArray alloc]init];
    self.apptid_arr = [[NSMutableArray alloc]init];
    self.patientteststatus_arr = [[NSMutableArray alloc]init];
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
            
            
            /*
            const char *sql_stmt_groupreportsinfo ="create table if not exists groupreportslist(testid text primary key, testname text, testid text, testdate text,departid text,units text,departname text,testminvalue text,testmaxvalue text,testresultvalue text,criticallowvalue text,criticalhighvalue text,typevalue text)";
            
            
            if (sqlite3_exec(database, sql_stmt_groupreportsinfo, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                //NSLog(@"Failed to create groupreportslist table");
            }
            
            const char *sql_stmt_panelreportsinfo ="create table if not exists panelgroupreportslist(testid text primary key, testname text, testid text, testdate text,departid text,units text,departname text,testminvalue text,testmaxvalue text,testresultvalue text,criticallowvalue text,criticalhighvalue text,typevalue text)";
            
            
            if (sqlite3_exec(database, sql_stmt_groupreportsinfo, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                //NSLog(@"Failed to create groupreportslist table");
            }
            */
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

-(BOOL)saveLoginCredentials:(NSString*)username_str :(NSString*)password_str{
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into patientlogin (pid,username,password) values (\"%d\",\"%@\", \"%@\")",1,username_str,password_str];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        
        // sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return NO;

}

-(BOOL)savePatientInfo:(NSString*)patientid :(NSString*)patientfirstname :(NSString*)patientlastname :(NSString*)patientgender :(NSString*)patientdob :(NSString*)patientemail :(NSString*)patientmobile :(NSString*)patientbloodg :(NSData*)patientimg{
    //NSLog(@"savePatientInfo..");
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        //patientimg=nil;
        
        //NSString *insertSQL = [NSString stringWithFormat:@"insert into patientinfo (patientid,patientfirstname, patientlastname, patientgender,patientdob,patientemail,patientmobile,patientbloodg,patientimg) values (\"%@\",\"%@\", \"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",patientid,patientfirstname, patientlastname, patientgender,patientdob,patientemail,patientmobile,patientbloodg,[patientimg bytes]];
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into patientinfo (patientid,patientfirstname, patientlastname, patientgender,patientdob,patientemail,patientmobile,patientbloodg,patientimg) values (?,?,?,?,?,?,?,?,?)"];

        
                                //NSLog(@"insertsql:%@",insertSQL);
                                const char *insert_stmt = [insertSQL UTF8String];
        
        /*
                                sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
                                if (sqlite3_step(statement) == SQLITE_DONE)
                                {
                                    return YES;
                                } 
                                else {
                                    return NO;
                                }
         */
        
        
        
        if(sqlite3_prepare_v2(database, insert_stmt, -1, &statement, NULL)==SQLITE_OK){
            //NSLog(@"preare:");
            sqlite3_bind_text(statement, 1, [patientid UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [patientfirstname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [patientlastname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [patientgender UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [patientdob UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [patientemail UTF8String], -1, SQLITE_TRANSIENT);
             sqlite3_bind_text(statement, 7, [patientmobile UTF8String], -1, SQLITE_TRANSIENT);
             sqlite3_bind_text(statement, 8, [patientbloodg UTF8String], -1, SQLITE_TRANSIENT);
            //sqlite3_bind_blob(updateStmt, 6, [patientimg bytes], -1, SQLITE_TRANSIENT);
            sqlite3_bind_blob(statement, 9, [patientimg bytes], (int)[patientimg length], SQLITE_TRANSIENT);
            
            
            
        }
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        
        
                                //sqlite3_reset(statement);
                                }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
                                
    return NO;
}


-(BOOL)savePatientTests:(NSString*)testid :(NSString*)testname :(NSString*)type :(NSString*)testdate :(NSString*)departid :(NSString*)units :(NSString*)departname :(NSString*)testminvalue :(NSString*)testmaxvalue :(NSString*)testresultvalue :(NSString*)criticallowvalue :(NSString*)criticalhighvalue :(int)isEntered{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into reportslist (testid,testname, type,testdate,departid,units,departname,testminvalue,testmaxvalue,testresultvalue,criticallowvalue,criticalhighvalue,isEntered) values (\"%@\",\"%@\", \"%@\", ,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\")",testid,testname, type, testdate,departid,units,departname,testminvalue,testmaxvalue,testresultvalue,criticallowvalue,criticalhighvalue,isEntered];
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        
       // sqlite3_reset(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return NO;
}


-(BOOL)saveGroupTests:(NSString*)testid :(NSString*)testname :(NSString*)type :(NSString*)testdate :(NSString*)testtime :(NSString*)departid :(NSString*)units :(NSString*)departname :(NSString*)testminvalue :(NSString*)testmaxvalue :(NSString*)testresultvalue :(NSString*)criticallowvalue :(NSString*)criticalhighvalue :(int)isEntered{
    @try {
        
    
    //NSLog(@"savegrouptests");
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        //NSLog(@"open db");
        NSString *insertSQL = [NSString stringWithFormat:@"insert into testslist (testid,testname, type,testdate,testtime,departid,units,departname,testminvalue,testmaxvalue,testresultvalue,criticallowvalue,criticalhighvalue,isEntered) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\")",testid,testname, type, testdate,testtime,departid,units,departname,testminvalue,testmaxvalue,testresultvalue,criticallowvalue,criticalhighvalue,isEntered];
        //NSLog(@"insertsql:%@",insertSQL);
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            //NSLog(@"yes success");
            return YES;
        }
        else {
        //NSLog(@"Error while saving tests. %s", sqlite3_errmsg(database));
            //NSLog(@"No Failed");
            return NO;
        }
       
        //sqlite3_reset(statement);
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    } @catch (NSException *exception) {
        //NSLog(@"exception savegroups:%@",exception);
    } @finally {
        //NSLog(@"finallyyyy savegroups");
    }
    return NO;
}



-(BOOL)savePatientAppoinments:(NSString*)apptmntid :(NSString*)testname :(NSString*)testdate :(NSString*)departname :(NSString*)appinttime{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:@"insert into appointmentlist (apptid,testname,testdate,departname,testtime) values (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",apptmntid,testname, testdate, departname,appinttime];
        const char *insert_stmt = [insertSQL UTF8String];
        //NSLog(@"insertsql appointment:%@",insertSQL);
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        
        //sqlite3_reset(statement);
        
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return NO;
}


- (IMIHLDBManager*)getPatientLogin
{
    
    [self alloclogin];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select * from patientlogin"];
        
        const char *query_stmt = [querySQL UTF8String];
        // NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            
            @try {
                // Loop through the results and add them to the feeds array
                while(sqlite3_step(statement) == SQLITE_ROW)
                {
                    /*
                     NSString *apptid_str = [[NSString alloc] initWithUTF8String:
                     (const char *) sqlite3_column_text(statement, 0)];
                     [resultArray addObject:apptid_str];
                     */
                    NSString *username_str = [[NSString alloc] initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 1)];
                    [self.patientlogin_arr addObject:username_str];
                    
                    NSString *password_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 2)];
                    [self.patientlogin_arr addObject:password_str];
                    /*
                     NSString *departmnt_str = [[NSString alloc]initWithUTF8String:
                     (const char *) sqlite3_column_text(statement, 3)];
                     [resultArray addObject:departmnt_str];
                     
                     NSString *testtime_str = [[NSString alloc]initWithUTF8String:
                     (const char *) sqlite3_column_text(statement, 4)];
                     [resultArray addObject:testtime_str];
                     */
                    
                    //sqlite3_finalize(statement);
                    //sqlite3_close(database);
                    
                    //return resultArray;
                    
                }
            }
            @catch (NSException *exception) {
                //NSLog(@"Exception DB:%@",exception);
            }
            @finally {
                //NSLog(@"entered in final block");
            }
            
            
            
            //sqlite3_reset(statement);
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return self;
}


- (IMIHLDBManager*)getPatientAppointmentsList
{
    
    [self appintmentArrayAlloc];
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select * from appointmentlist"];
        
        const char *query_stmt = [querySQL UTF8String];
       // NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            
            @try {
                // Loop through the results and add them to the feeds array
                while(sqlite3_step(statement) == SQLITE_ROW)
                {
                    
                    NSString *apptid_str = [[NSString alloc] initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 0)];
                    [self.apptid_arr addObject:apptid_str];
                    
                    NSString *testname_str = [[NSString alloc] initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 1)];
                    [self.apptest_arr addObject:testname_str];
                    
                    NSString *testdate_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 2)];
                    [self.apptdate_arr addObject:testdate_str];
                    
                    NSString *departmnt_str = [[NSString alloc]initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 3)];
                    [self.departmentname_arr addObject:departmnt_str];
                    
                    NSString *testtime_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 4)];
                    [self.patientteststatus_arr addObject:testtime_str];
                    
                    
                    //sqlite3_finalize(statement);
                    //sqlite3_close(database);

                    //return resultArray;

                }
            }
            @catch (NSException *exception) {
                //NSLog(@"Exception DB:%@",exception);
            }
            @finally {
                //NSLog(@"entered in final block");
            }
            
            
        
                        //sqlite3_reset(statement);
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return self;
}

- (IMIHLDBManager*)getAllGroupTestsDB:(NSString*)testname
{
    
    //NSLog(@"entredr get allll");
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        [self allocateArray];
        //NSLog(@"test:%@",testname);
        NSString *querySQL = [NSString stringWithFormat:@"select * from testslist WHERE testname='%@'",testname];
        const char *query_stmt = [querySQL UTF8String];
       // NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            //if (sqlite3_step(statement) == SQLITE_ROW)
            
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSLog(@"getallll");
                NSString *testid_str = [[NSString alloc] initWithUTF8String:
                                           (const char *) sqlite3_column_text(statement, 0)];
                [self.patienttestid_arr addObject:testid_str];
                
                NSString *testname_str = [[NSString alloc] initWithUTF8String:
                                                  (const char *) sqlite3_column_text(statement, 1)];
                [self.patienttestname_arr addObject:testname_str];
                
                //NSLog(@"testname from db:%@",testname_str);
                
                NSString *type_str = [[NSString alloc]initWithUTF8String:
                                                 (const char *) sqlite3_column_text(statement, 2)];
                [self.patienttesttype_arr addObject:type_str];
                
                NSString *testdate_str = [[NSString alloc]initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 3)];
                [self.patienttestdate_arr addObject:testdate_str];
               
                NSString *testtime_str = [[NSString alloc]initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 4)];
                [self.patienttesttime_arr addObject:testtime_str];
                
                
                NSString *deptid_str = [[NSString alloc]initWithUTF8String:
                                            (const char *) sqlite3_column_text(statement, 5)];
                [self.departmentid_arr addObject:deptid_str];
                
                NSString *units_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 6)];
                [self.patienttestunits_arr addObject:units_str];
                
                NSString *departname_str = [[NSString alloc]initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 7)];
                [self.departmentname_arr addObject:departname_str];
                
                NSString *testminvalue_str = [[NSString alloc]initWithUTF8String:
                                               (const char *) sqlite3_column_text(statement, 8)];
                [self.patienttestminvalue_arr addObject:testminvalue_str];
                
                NSString *testmaxvalue_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 9)];
                [self.patienttestmaxvalue_arr addObject:testmaxvalue_str];
                
                NSString *testresultvalue_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 10)];
                [self.patienttestvalue_arr addObject:testresultvalue_str];
                
                NSString *criticallowvalue_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 11)];
                [self.patienttestlowcritical addObject:criticallowvalue_str];
                
                NSString *criticalhighvalue_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 12)];
                
                [self.patienttesthighcritical addObject:criticalhighvalue_str];
                
                NSString *isEntered_str = [[NSString alloc]initWithUTF8String:
                                              (const char *) sqlite3_column_text(statement, 13)];
                [self.patienttestisready addObject:isEntered_str];
                
                
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
    return self;
}


- (NSArray*)getPatientInfoDB
{
    //NSLog(@"getPatientInfoDB");
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"select * from patientinfo"];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //NSLog(@"heloo");
                NSString *patientid_str = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:patientid_str];
                //NSLog(@"patientid_str:%@",patientid_str);
                
                NSString *patientfirstname_str = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:patientfirstname_str];
                
                NSString *patientlastname_str = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:patientlastname_str];
                
                NSString *patientgender_str = [[NSString alloc]initWithUTF8String:
                                                 (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:patientgender_str];

                NSString *patientdob_str = [[NSString alloc]initWithUTF8String:
                                                 (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:patientdob_str];

                NSString *patientemail_str = [[NSString alloc]initWithUTF8String:
                                                 (const char *) sqlite3_column_text(statement, 5)];
                [resultArray addObject:patientemail_str];

                NSString *patientmobile_str = [[NSString alloc]initWithUTF8String:
                                                 (const char *) sqlite3_column_text(statement, 6)];
                [resultArray addObject:patientmobile_str];

                NSString *patientbloodg_str = [[NSString alloc]initWithUTF8String:
                                                 (const char *) sqlite3_column_text(statement, 7)];
                [resultArray addObject:patientbloodg_str];
                
                
                
                const char *raw = sqlite3_column_blob(statement, 8);
                int rawLen = sqlite3_column_bytes(statement, 8);
                NSData *data = [NSData dataWithBytes:raw length:rawLen];
                //NSLog(@"data image:%@",data);
                //NSLog(@"length:%d",rawLen);
                
                
                [resultArray addObject:data];

                sqlite3_finalize(statement);
                sqlite3_close(database);

                return resultArray;
            }
            else{
                //NSLog(@"Not found");
                return nil;
            }
           // sqlite3_reset(statement);
        }
    }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return nil;
}

-(BOOL)updatePatientinfo:(NSString*)patientid :(NSString*)patientfirstname :(NSString*)patientlastname :(NSString*)patientgender :(NSString*)patientdob :(NSString*)patientemail :(NSData*)patientimg{
   // sqlite3_stmt *updateStmt;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        //NSLog(@"patientid:%@,patientfirstname:%@,patientlastname:%@,patientgender:%@,patientdob:%@,patientemail:%@,patientimg:%@",patientid,patientfirstname,patientlastname,patientgender,patientdob,patientemail,patientimg);
       // const char *sql = "update patientinfo Set patientfirstname = ?, patientlastname = ?, patientgender = ?, patientdob = ?, patientemail = ?, patientimg = ? WHERE patientid=?";
        
        NSString *querySQL = [NSString stringWithFormat:@"update patientinfo Set patientfirstname = ?, patientlastname = ?, patientgender = ?, patientdob = ?, patientemail = ?, patientimg = ? WHERE patientid=?"];
        const char *query_stmt = [querySQL UTF8String];
        
        //NSLog(@"imag lngt:%lu",[patientimg length]);
        if(sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL)==SQLITE_OK){
            //NSLog(@"preare:");
            sqlite3_bind_text(statement, 1, [patientfirstname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [patientlastname UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [patientgender UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [patientdob UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [patientemail UTF8String], -1, SQLITE_TRANSIENT);
            //sqlite3_bind_blob(updateStmt, 6, [patientimg bytes], -1, SQLITE_TRANSIENT);
            sqlite3_bind_blob(statement, 6, [patientimg bytes], (int)[patientimg length], SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [patientid UTF8String], -1, SQLITE_TRANSIENT);

           
        }
    }
    
   // char* errmsg;
    //sqlite3_exec(database, "COMMIT", NULL, NULL, &errmsg);
    
    if(SQLITE_DONE != sqlite3_step(statement)){
        //NSLog(@"Error while updating. %s", sqlite3_errmsg(database));
    }
    else{
         sqlite3_finalize(statement);
        
        //NSLog(@"success....");
        // [self clearClick:nil];
        return YES;
    }
    //sqlite3_finalize(statement);
    sqlite3_close(database);
    //sqlite3_reset(statement);
    return NO;
}
/*
-(int)deletePatientInfoDB{
    sqlite3_stmt *stmt2;
    NSString *delete;
    int x;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
    delete=[[NSString alloc]initWithFormat:@"DELETE from patientinfo"];
    //update=[[NSString alloc]initWithFormat:@"DROP TABLE cart;"];
    
    //NSLog(@"delete:%@",delete);
    x = sqlite3_prepare_v2(database, [delete UTF8String], -1, &statement, nil);
    //NSLog(@"x=%d",x);
        
    }
    if (sqlite3_step(statement) != SQLITE_DONE)
        //NSLog(@"Deletion Error.");
    sqlite3_finalize(statement);
    
    sqlite3_close(database);
    return x;
    
}

-(int)deletePatientLoginDB{
    sqlite3_stmt *stmt2;
    NSString *delete;
    int x;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        delete=[[NSString alloc]initWithFormat:@"DELETE from patientlogin"];
        //update=[[NSString alloc]initWithFormat:@"DROP TABLE cart;"];
        
        //NSLog(@"delete:%@",delete);
        x = sqlite3_prepare_v2(database, [delete UTF8String], -1, &statement, nil);
        //NSLog(@"x=%d",x);
        
    }
    if (sqlite3_step(statement) != SQLITE_DONE)
        //NSLog(@"Deletion Error.");
    sqlite3_finalize(statement);
    
    sqlite3_close(database);
    return x;
    
}

*/

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
        NSLog(@"x=%d",x);
        
    }
    if (sqlite3_step(statement) != SQLITE_DONE)
        //NSLog(@"Deletion Error.");
    sqlite3_finalize(statement);
    
    sqlite3_close(database);
    return x;
    
}
-(int)deleteAppoinmentsInfoDB{
  //  sqlite3_stmt *stmt2;
    NSString *delete;
    int x = 0;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        delete=[[NSString alloc]initWithFormat:@"DELETE from testslist"];
        //update=[[NSString alloc]initWithFormat:@"DROP TABLE cart;"];
        
        //NSLog(@"delete:%@",delete);
        x = sqlite3_prepare_v2(database, [delete UTF8String], -1, &statement, nil);
        NSLog(@"x=%d",x);
        
    }
    if (sqlite3_step(statement) != SQLITE_DONE)
        //NSLog(@"Deletion Error.");
    sqlite3_finalize(statement);
    
    sqlite3_close(database);
    return x;
    
}



-(int)deleteOldAppoinmentsList:(NSString*)datestr{

    //sqlite3_stmt *stmt2;
    NSString *delete;
    
    int x = 0;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
        delete=[[NSString alloc]initWithFormat:@"delete from appointmentlist WHERE testdate = '%@'",datestr];
        
        
        //NSLog(@"delete:%@",delete);
        x = sqlite3_prepare_v2(database, [delete UTF8String], -1, &statement, nil);
        //NSLog(@"x=%d",x);
    }
    if (sqlite3_step(statement) != SQLITE_DONE)
        //NSLog(@"Deletion Error.");
    sqlite3_finalize(statement);
    sqlite3_close(database);
    return x;



}

-(int)deleteReportsListDB{
  //  sqlite3_stmt *stmt2;
    NSString *delete;
    
    int x = 0;
    const char *dbpath = [databasePath UTF8String];
    if(sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
    delete=[[NSString alloc]initWithFormat:@"delete from reportslist;"];

    
    //NSLog(@"delete:%@",delete);
    x = sqlite3_prepare_v2(database, [delete UTF8String], -1, &statement, nil);
    //NSLog(@"x=%d",x);
    }
    if (sqlite3_step(statement) != SQLITE_DONE)
        //NSLog(@"Deletion Error.");
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
                //NSLog(@"getallll");
                
                ALTest*testObj = [ALTest new];
                NSString *testid_str = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 0)];
                testObj.testid = testid_str;
                
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
