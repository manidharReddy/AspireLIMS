//
//  IMIHLRestService.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 20/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InternetConnection.h"
@interface IMIHLRestService : NSObject{
    int statuscode;
}
@property (strong,nonatomic) NSDictionary*restresult_dict;
@property (strong,nonatomic) NSString*urlpathstr;

+(IMIHLRestService*)getSharedInstance;
-(int)login:(NSString*)username :(NSString*)password;
-(int)reports:(NSString*)registeredID :(NSString*)fromdate :(NSString*)todate;
-(int)getpatientInfo:(NSString*)patientid;
-(int)feedbackService:(NSString*)patientid :(NSString*)feedbacktype :(NSString*)feedbackcontent;
-(int)changepasswordService:(NSString*)patientid :(NSString*)currentPass :(NSString*)changePass :(NSString*)reenterPass;
-(int)getAboutUsService:(NSString*)aboutid;
-(int)profileUpdateService:(NSString*)patientid :(NSString*)firstname :(NSString*)lastname :(NSString*)gender :(NSString*)dob :(NSString*)emailid :(NSData*)filedata;
-(int)createAppointment:(NSString*)patientId :(NSString*)appointmentDate :(NSString*)locationid :(NSString*)departmentId :(NSString*)serviceId;
-(int)createDoctorAppointment:(NSString*)appointmentDate appointmentTime:(NSString*)appointmentTime doctorId:(NSString*)doctorId patientId:(NSString*)patientId;
-(int)getSearchResults:(NSString*)patientid :(NSString*)testid;
-(int)getSearchServices:(NSString*)patientid;
-(int)getDepartments:(NSString*)locationid;
-(int)getAllAppointments:(NSString*)patientid;
-(int)getDrAppointments:(NSString*)patientid;
-(int)getLocations:(NSString*)patientid;
-(int)getServices:(NSString*)departid;
-(int)forgotPasswordService:(NSString*)patientid;
-(int)confrimForgotPasswordService:(NSString*)patientid;
-(int)getForgotResetPassword:(NSString*)patientid :(NSString*)userid :(NSString*)password;
-(int)getTestName:(NSString*)testname :(NSString*)locid;
//-(int)previousAppointmentsService:
///////////////////////Doctor Services///////////////////////////////
-(int)getDoctorLocations:(NSString*)patientid;
-(int)getDoctorDepartments:(NSString*)locationid;
-(int)getDoctorsList:(NSString*)loc_id :(NSString*)departid;
-(int)getDoctorsDates:(NSString*)doctid;
-(int)getDoctorsTimes:(NSString*)doctid;
-(int)getDoctorSpecialities:(NSString*)locationid;
-(int)getPatientOrdersList:(NSString*)patientid;
-(int)reportDownloadPdf:(NSString*)orderid_str :(NSString*)type;
-(int)invoiceDownloadPdf:(NSString *)orderid_str :(NSString*)type;
//-(int)downloadFile:(NSString*)url_str :(NSString*)orderid_str;
-(int)reportDownloadInPDF:(NSString*)orderid_str :(NSString*)serviceId :(NSString*)type;
-(int)cancelAppointment:(NSString*)appntId :(NSString*)reason;
-(int)reSchedule:(NSString*)appntId :(NSString*)reason;
-(int)recentActivities:(NSString*)patientId;
-(int)newLogin:(NSString*)username :(NSString*)password;
-(int)remainders:(NSString*)patientId;

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
@end
