//
//  IMIHLNewPasswordVC.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 08/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLNewPasswordVC.h"
#import "MBProgressHUD.h"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"

@interface IMIHLNewPasswordVC ()
@property (retain,nonatomic)TextFieldValidator *txtDemo;
@end

@implementation IMIHLNewPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.backarrowbutton setBackgroundImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];

    self.navigationController.navigationBarHidden=YES;
    
    self.submitBtn.layer.cornerRadius = self.submitBtn.bounds.size.height/2;
    
    self.newpasswrd_txtfield.layer.cornerRadius = self.newpasswrd_txtfield.bounds.size.height/2;
    self.newpasswrd_txtfield.layer.borderWidth=2;
    self.newpasswrd_txtfield.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.reenterpasswrd_txtfield.layer.cornerRadius = self.reenterpasswrd_txtfield.bounds.size.height/2;
    self.reenterpasswrd_txtfield.layer.borderWidth=2;
    self.reenterpasswrd_txtfield.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self textFieldErrorsMesseges];
    [self setIconsForLoginPage];
}
- (IBAction)backArrowLeftClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"loginpage"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldErrorsMesseges{
    
    //[txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [self.newpasswrd_txtfield addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [self.newpasswrd_txtfield addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    
    
    [self.reenterpasswrd_txtfield addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [self.reenterpasswrd_txtfield addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    [self.reenterpasswrd_txtfield addConfirmValidationTo:self.newpasswrd_txtfield withMsg:@"Confirm password didn't match."];
    
    //[txtPhone addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
    //txtPhone.isMandatory=NO;
}
-(void)setIconsForLoginPage{
    self.newpassicon_imgview.image = [UIImage imageWithIcon:@"fa-key" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:30];
    self.confirmpasswrd_imageview.image = [UIImage imageWithIcon:@"fa-key" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:30];
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

- (IBAction)loginClick:(id)sender {
    //NSLog(@"login click");
   
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


-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"load vc");
   NSString * storyboardName = @"Main";
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    //[self presentViewController:vc animated:YES completion:nil];
    // UINavigationController*navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController pushViewController:vc animated:YES];
    //[navigationController pushViewController:vc animated:YES];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)callLoader{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Changing....";
}

- (IBAction)resetpasswrdClick:(id)sender {
    if([self.newpasswrd_txtfield validate] & [self.reenterpasswrd_txtfield validate]){
        
        
        [self callLoader];
        [self performSelector:@selector(resetPassReset) withObject:nil afterDelay:0.1];

       
    }
    
}

-(void)resetPassReset{
    IMIHLRestService*restlogin = [IMIHLRestService getSharedInstance];
    //IMIHLRestService*restlogin = [[IMIHLRestService alloc]init];
   // int statuscode =[restlogin getForgotResetPassword:self.patientid_str :self.userid_str :self.newpasswrd_txtfield.text];
    [restlogin getForgotResetPassword:self.patientid_str :self.userid_str :self.newpasswrd_txtfield.text withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            
             [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self loadViewControllerFromStoryBoard:@"loginpage"];
            [self showAlertController:@"Your password has changed succesfully"];
            
        }else if(response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            //NSLog(@"Error Message:%@",[restlogin.restresult_dict objectForKey:@"message"]);
            [self showAlertController:[restlogin.restresult_dict objectForKey:@"message"]];
        }
    }];
   
    
}


@end
