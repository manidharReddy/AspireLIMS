//
//  IMIHLDBManager.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 15/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface IMIHLDBManager : NSObject
{
    NSString *databasePath;
}
@property(nonatomic,retain) NSMutableArray*patientlogin_arr;
@property(nonatomic,retain) NSMutableArray*apptid_arr;
@property(nonatomic,retain) NSMutableArray*patienttestid_arr;
@property(nonatomic,retain) NSMutableArray*patienttestrange_arr;
@property(nonatomic,retain) NSMutableArray*patienttestdate_arr;
@property(nonatomic,retain) NSMutableArray*patienttesttime_arr;
@property(nonatomic,retain)NSMutableArray*patientteststatus_arr;
@property(nonatomic,retain)NSMutableArray*patienttestunits_arr;
@property(nonatomic,retain)NSMutableArray*patienttestname_arr;
@property(nonatomic,retain)NSMutableArray*patienttesttype_arr;
@property(nonatomic,retain)NSMutableArray*patienttestminvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestmaxvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestvalue_arr;
@property(nonatomic,retain)NSMutableArray*patienttestisready;
@property(nonatomic,retain)NSMutableArray*departmentid_arr;
@property(nonatomic,retain)NSMutableArray*departmentname_arr;
@property(nonatomic,retain)NSMutableArray*patienttestlowcritical;
@property(nonatomic,retain)NSMutableArray*patienttesthighcritical;

///////////////////////Appointments Array////////////////////////

@property(nonatomic,retain)NSMutableArray*apptdate_arr;
@property(nonatomic,retain)NSMutableArray*apptest_arr;




+(IMIHLDBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL)saveLoginCredentials:(NSString*)username_str :(NSString*)password_str;
-(BOOL)savePatientInfo:(NSString*)patientid :(NSString*)patientfirstname :(NSString*)patientlastname :(NSString*)patientgender :(NSString*)patientdob :(NSString*)patientemail :(NSString*)patientmobile :(NSString*)patientbloodg :(NSData*)patientimg;
-(BOOL)savePatientTests:(NSString*)testid :(NSString*)testname :(NSString*)type :(NSString*)testdate :(NSString*)departid :(NSString*)units :(NSString*)departname :(NSString*)testminvalue :(NSString*)testmaxvalue :(NSString*)testresultvalue :(NSString*)criticallowvalue :(NSString*)criticalhighvalue :(int)isEntered;
-(BOOL)saveGroupTests:(NSString*)testid :(NSString*)testname :(NSString*)type :(NSString*)testdate :(NSString*)testtime :(NSString*)departid :(NSString*)units :(NSString*)departname :(NSString*)testminvalue :(NSString*)testmaxvalue :(NSString*)testresultvalue :(NSString*)criticallowvalue :(NSString*)criticalhighvalue :(int)isEntered;

-(BOOL)updatePatientinfo:(NSString*)patientid :(NSString*)patientfirstname :(NSString*)patientlastname :(NSString*)patientgender :(NSString*)patientdob :(NSString*)patientemail :(NSData*)patientimg;

-(BOOL)savePatientAppoinments:(NSString*)apptmntid :(NSString*)testname :(NSString*)testdate :(NSString*)departname :(NSString*)appinttime;
- (IMIHLDBManager*)getAllGroupTestsDB:(NSString*)testname;
- (IMIHLDBManager*)getPatientAppointmentsList;
- (IMIHLDBManager*)getPatientLogin;
- (NSArray*)getPatientInfoDB;
//-(int)deletePatientLoginDB;
-(int)deleteOldAppoinmentsList:(NSString*)datestr;
//-(int)deletePatientInfoDB;
-(int)deleteReportsListDB;
-(int)deleteGroupTestsInfoDB;
-(int)deleteAppoinmentsInfoDB;

@end
