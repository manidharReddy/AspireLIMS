//
//  IMIHLPassword.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLPassword.h"

#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_OLD_PASSWORD_LIMIT @"^.{0,20}$"
#define REGEX_OLD_PASSWORD @"[A-Za-z0-9]{0,20}"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"

@interface IMIHLPassword ()

@end

@implementation IMIHLPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self textFieldErrorsMesseges];
    //[self.backBarBtn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.changePasswordBtn.layer.cornerRadius = self.changePasswordBtn.bounds.size.height/2;
    self.changePasswordBtn.clipsToBounds = YES;

}

-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.navigationController.navigationBarHidden=NO;
    self.backBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backBarBtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backBarBtn];
}
- (void)goBack
{
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldErrorsMesseges{
    
    [self.oldpasswrd_txtfld addRegx:REGEX_OLD_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 0-20"];
    [self.oldpasswrd_txtfld addRegx:REGEX_OLD_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    [self.newpasswrd_txtfld addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [self.newpasswrd_txtfld addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];

    [self.reenterpasswrd_txtfld addConfirmValidationTo:self.newpasswrd_txtfld withMsg:@"Confirm password didn't match."];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    IMIHLDashboardVC * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    //vc.patientid_str = self.patientid_str;
    //vc.patientname_str = self.patientname_str;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)backBarClick:(id)sender {
     [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}

- (IBAction)changePasswordBtnClick:(id)sender {
    if([self.oldpasswrd_txtfld validate] & [self.newpasswrd_txtfld validate] & [self.reenterpasswrd_txtfld validate]){
        
        IMIHLRestService*restchangepass = [IMIHLRestService getSharedInstance];
        
        //NSLog(@"patientid:%@",self.patientid_str);
        //NSLog(@"oldpasswrd:%@",self.oldpasswrd_txtfld.text);
        //NSLog(@"newpasswrd:%@",self.newpasswrd_txtfld.text);
        //NSLog(@"renterpawwrd:%@",self.reenterpasswrd_txtfld.text);
        
        //int statuscode = [restchangepass changepasswordService:self.patientid_str :self.oldpasswrd_txtfld.text :self.newpasswrd_txtfld.text :self.reenterpasswrd_txtfld.text];
        
        [restchangepass changepasswordService:self.patientid_str :self.oldpasswrd_txtfld.text :self.newpasswrd_txtfld.text :self.reenterpasswrd_txtfld.text withCompletionHandler:^(NSInteger response) {
            if (response==200) {
                //NSLog(@"status of changepassword:%@",restchangepass.restresult_dict);
                //[self showAlertController:[restchangepass.restresult_dict objectForKey:@"message"]];
                
                self.oldpasswrd_txtfld.text=@"";
                self.newpasswrd_txtfld.text=@"";
                self.reenterpasswrd_txtfld.text=@"";
                
                [self showAlertController:@"Successfully changed"];
            }else if(response==0){
                [self showAlertController:@"No Network Connection"];
            }else{
                //NSLog(@"Error Message:%@",[restchangepass.restresult_dict objectForKey:@"message"]);
                [self showAlertController:[restchangepass.restresult_dict objectForKey:@"message"]];
            }
        }];
       
        
    }
    
}

-(void)showAlertController:(NSString*)msgshow{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:msgshow
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

@end
