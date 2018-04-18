//
//  ForgotPasswordVC.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 23/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "ForgotPasswordVC.h"
#import "IMIHLRestService.h"
#import "IMIHLNewPasswordVC.h"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
@interface ForgotPasswordVC (){
    NSString*otpglobal_str;
}

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.backarrowbutton.hidden = YES;
    [self.email_txtfeild addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    
    self.email_icon_imgview.image = [UIImage imageWithIcon:@"fa-envelope-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25];
    
   // [self.backarrowbutton setBackgroundImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    self.email_txtfeild.layer.cornerRadius = self.email_txtfeild.bounds.size.height/2;
    //[[self.usrpasswrd_txt layer] setCornerRadius:15];
    self.email_txtfeild.layer.borderColor = [UIColor whiteColor].CGColor;
    self.email_txtfeild.layer.borderWidth = 2;
    [self.email_txtfeild setClipsToBounds: YES];
    
    self.getPasswordBtn.layer.cornerRadius = self.getPasswordBtn.bounds.size.height/2;
    
    self.getPasswordBtn.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)requestpasswrdClick:(id)sender {
    if([self.email_txtfeild validate]){
        
        IMIHLRestService*restforgtpass = [IMIHLRestService getSharedInstance];
        
        //int statuscode = [restforgtpass forgotPasswordService:self.email_txtfeild.text];
        [restforgtpass forgotPasswordService:self.email_txtfeild.text withCompletionHandler:^(NSInteger response) {
            if (response==200) {
                NSLog(@"status of forgotpassword:%@",restforgtpass.restresult_dict);
                NSString*otp_str = [restforgtpass.restresult_dict objectForKey:@"OTP"];
                otpglobal_str =otp_str;
                self.patientid_str= [restforgtpass.restresult_dict objectForKey:@"patientId"];
                self.userid_str= [restforgtpass.restresult_dict objectForKey:@"userId"];
                //NSLog(@"otp_str:%@",otp_str);
                [self alertController];
            }else if(response==0){
                [self showAlertController:@"No Network Connection"];
            }else{
                //NSLog(@"Error Message:%@",[restforgtpass.restresult_dict objectForKey:@"msg"]);
                [self showAlertController:[restforgtpass.restresult_dict objectForKey:@"msg"]];
            }
        }];
        
        
    }
}


-(void)alertController{
    // use UIAlertController
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Enter OTP"
                               message:@""
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   UITextField *textField = alert.textFields[0];
                                                   //NSLog(@"text was %@", textField.text);
                                                   
                                                   [self checkOTPMsg:textField];
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       //NSLog(@"cancel btn");
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                   }];
    
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter OTP...";
        textField.keyboardType = UIKeyboardTypeDefault;
        
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


-(void)checkOTPMsg:(UITextField*)txtfld{
    //NSLog(@"checkOTPMsg");
    if (![txtfld.text isEqualToString:@""]) {
        //NSLog(@"txt empty");
        if ([txtfld.text isEqualToString:otpglobal_str]) {
            //NSLog(@"matched");
            //[self confirmOTP:@""];
            
            [self changepassword];
        }else{
        [self showAlertController:@"OTP is invalid"];
        }
    }else{
        [self showAlertController:@"Please enter text in textbox"];
    }
}


-(void)confirmOTP:(NSString*)otpstr{
    IMIHLRestService*restforgtpass = [IMIHLRestService getSharedInstance];
    //int statuscode =[restforgtpass confrimForgotPasswordService:self.email_txtfeild.text];
    [restforgtpass confrimForgotPasswordService:self.email_txtfeild.text withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            NSLog(@"status of confirmforgotpassword:%@",restforgtpass.restresult_dict);
            // NSString*responsemsg_str = [restforgtpass.restresult_dict objectForKey:@"message"];
            //NSLog(@"responsemsg_str:%@",responsemsg_str);
            // [self showAlertController:@"Your password is send to your mail or mobile number"];
            [self changepassword];
            
        }else if (response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restforgtpass.restresult_dict objectForKey:@"message"]);
            [self showAlertController:[restforgtpass.restresult_dict objectForKey:@"message"]];
        }
    }];
    
}


-(void)changepassword{
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    IMIHLNewPasswordVC * vc = [storyboard instantiateViewControllerWithIdentifier:@"forgotnewpass"];
    vc.userid_str = self.userid_str;
    vc.patientid_str = self.patientid_str;
    //[self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];

    
}

-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:alrtmsg
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    [alert addAction:button0];
    [self presentViewController:alert animated:YES completion:nil];
        
}


- (IBAction)backArrowLeftClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"loginpage"];
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //if(txtDemo==textField){
    //[scrlView setContentOffset:CGPointMake(0, 50) animated:YES];
    //}
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[self.username_txtfld resignFirstResponder];
    //[self.usrpasswrd_txt resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
}


-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    //[self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)backToSigntouch:(id)sender {
   [self loadViewControllerFromStoryBoard:@"loginpage"];
}
@end
