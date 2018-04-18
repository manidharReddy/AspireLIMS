//
//  IMIHLRestService.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 20/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InternetConnection.h"
@interface IMIHLRestService : NSObject
@property (strong,nonatomic) NSDictionary*restresult_dict;
@property (strong,nonatomic) NSString*urlpathstr;

+(IMIHLRestService*)getSharedInstance;
-(void)profileUpdateService:(NSString*)patientid :(NSString*)firstname :(NSString*)lastname :(NSString*)gender :(NSString*)dob :(NSString*)emailid  :(NSString*)mobilenumber :(NSData*)filedata :(void (^)(NSInteger))handler;

///////////////////////Doctor Services///////////////////////////////
-(int)getDoctorLocations:(NSString*)patientid;
-(int)getDoctorDepartments:(NSString*)locationid;
-(int)getDoctorsList:(NSString*)loc_id :(NSString*)departid;
-(int)getDoctorsDates:(NSString*)doctid;
-(int)getDoctorsTimes:(NSString*)doctid;
-(int)getDoctorSpecialities:(NSString*)locationid;


//////////////////////New Services/////////////////////////////
-(void)recentActivities:(NSString*)patientId withCompletionHandler:(void (^)(NSInteger))handler;
-(void)newLoginWithUserIdPasswordByBlock:(NSString*)username :(NSString*)password withCompletionHandler:(void (^)(NSInteger))handler;
-(void)remainders:(NSString*)patientId withCompletionHandler:(void (^)(NSInteger))handler;
-(void)reports:(NSString*)registeredID :(NSString*)fromdate :(NSString*)todate withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getpatientInfo:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)feedbackService:(NSString*)patientid :(NSString*)feedbacktype :(NSString*)feedbackcontent withCompletionHandler:(void (^)(NSInteger))handler;
-(void)changepasswordService:(NSString*)patientid :(NSString*)currentPass :(NSString*)changePass :(NSString*)reenterPass withCompletionHandler:(void (^)(NSInteger))handler;
-(void)forgotPasswordService:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)confrimForgotPasswordService:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getAboutUsService:(NSString*)aboutid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)createAppointment:(NSString*)patientId :(NSString*)appointmentDate :(NSString*)locationid :(NSString*)departmentId :(NSString*)serviceId withCompletionHandler:(void (^)(NSInteger))handler;
-(void)cancelAppointment:(NSString*)appntId :(NSString*)reason withCompletionHandler:(void (^)(NSInteger))handler;
-(void)reSchedule:(NSString *)appntId :(NSString *)reason withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getDepartments:(NSString*)locationid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getServices:(NSString*)departid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getAllAppointments:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getLocations:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getSearchServices:(NSString*)patientid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getPatientOrdersList:(NSString *)patientid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getSearchResults:(NSString*)patientid :(NSString*)testid withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getForgotResetPassword:(NSString*)patientid :(NSString*)userid :(NSString*)password withCompletionHandler:(void (^)(NSInteger))handler;
-(void)getTestName:(NSString*)testname :(NSString*)locid
withCompletionHandler:(void (^)(NSInteger))handler;


-(void)reportDownloadPdf:(NSString*)orderid_str :(NSString*)type withCompletionHandler:(void (^)(NSInteger))handler;
-(void)invoiceDownloadPdf:(NSString *)orderid_str :(NSString*)type withCompletionHandler:(void (^)(NSInteger))handler;
//-(int)downloadFile:(NSString*)url_str :(NSString*)orderid_str;
-(void)reportDownloadInPDF:(NSString*)orderid_str :(NSString*)serviceId :(NSString*)type withCompletionHandler:(void (^)(NSInteger))handler;
@end
