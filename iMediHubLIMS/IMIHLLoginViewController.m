//
//  IMIHLLoginViewController.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 17/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLLoginViewController.h"
#import "TextFieldValidator.h"
#import "IMIHLLogin.h"
#import "IMIHLDBManager.h"
#import "AppDelegate.h"
#import "IMIHLDashboardVC.h"
#import "MBProgressHUD.h"
#import "ViewController.h"
#import "ALUserLogin.h"
#define REGEX_USER_NAME_LIMIT @"^.{3,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{3,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"

@interface IMIHLLoginViewController (){
IBOutlet TextFieldValidator *txtUserName;
IBOutlet TextFieldValidator *txtPassword;
TextFieldValidator *txtDemo;
}

@end

@implementation IMIHLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    //NSLog(@"loginviewcontroller");
    self.signInBtn.layer.cornerRadius = 20;
    [self setIconsForLoginPage];
    txtUserName.delegate = self;
    txtPassword.delegate = self;
    txtUserName.layer.cornerRadius = txtUserName.bounds.size.height/2;
    txtUserName.layer.borderColor = [UIColor whiteColor].CGColor;
    txtUserName.layer.borderWidth = 2;
    [txtUserName.layer setMasksToBounds:YES];
   // [[self.username_txtfld layer] setCornerRadius:15];
    [txtUserName setClipsToBounds: YES];
    
    
   txtPassword.layer.cornerRadius = txtPassword.bounds.size.height/2;
    //[[self.usrpasswrd_txt layer] setCornerRadius:15];
    txtPassword.layer.borderColor = [UIColor whiteColor].CGColor;
    txtPassword.layer.borderWidth = 2;
    [txtPassword setClipsToBounds: YES];
    
   // self.view.hidden=YES;
   // self.background_img.hidden=YES;
    [self textFieldErrorsMesseges];
    
}

-(void)keyboardNotification:(NSNotification*)notification{
    
    NSLog(@"keyboard height:%f",[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    
    NSLog(@"keyboard height:%f",[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y);
    
    double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    unsigned int curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]intValue];
    CGRect curverect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect targetrect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat delayY = targetrect.origin.y - curverect.origin.y;
    NSLog(@"delayY:%f",delayY);
    [UIView animateKeyframesWithDuration:duration delay:0.0 options:(curve) animations:^{
        CGRect frameY = self.view.frame;
        frameY.origin.y = 0;
        if (delayY<0) {
          frameY.origin.y = delayY;
        }
        
        self.view.frame = frameY;
        
    } completion:^(BOOL finished) {
        
    }];
}


-(void)textFieldErrorsMesseges{
    [txtUserName addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    [txtUserName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    txtUserName.validateOnResign=NO;
    
    //[txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    //[txtConfirmPass addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    
    //[txtPhone addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
    //txtPhone.isMandatory=NO;
}
-(void)setIconsForLoginPage{
    self.usernameicon.image = [UIImage imageWithIcon:@"fa-user" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:30];
    self.passwordicon.image = [UIImage imageWithIcon:@"fa-key" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:30];
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


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //if(txtDemo==textField){
    //[scrlView setContentOffset:CGPointMake(0, 50) animated:YES];
    //}
    NSLog(@"textFieldDidBeginEditing");
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[self.username_txtfld resignFirstResponder];
    //[self.usrpasswrd_txt resignFirstResponder];
    NSLog(@"textFieldShouldReturn");
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [textField resignFirstResponder];
    return YES;
}

-(void)loaderCall{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Logging....";
    
}

- (IBAction)loginClick:(id)sender {
    //NSLog(@"login click");
    if([txtUserName validate] & [txtPassword validate]){
        [self loaderCall];
       // [self performSelector:@selector(loginCalled) withObject:nil afterDelay:0.1];
        //[self loginCalled];
        [self newLoginCalled];
        
        
    }
}

-(void)getPatientDetails{
    //IMIHLRestService*restlogin = [IMIHLRestService getSharedInstance];

}



-(void)newLoginCalled{
    //NSLog(@"loginCalled");
    IMIHLRestService*restlogin = [IMIHLRestService getSharedInstance];
    //IMIHLRestService*restlogin = [[IMIHLRestService alloc]init];
    NSLog(@"logged called");
    // int statuscode = [restlogin login:txtUserName.text :txtPassword.text];
   
    [restlogin newLoginWithUserIdPasswordByBlock:txtUserName.text :txtPassword.text withCompletionHandler:^(NSInteger response) {
        if (response == 200) {
            NSLog(@"restlogin.restresult_dict:%@",restlogin.restresult_dict);
            NSString*patientid_str = [restlogin.restresult_dict objectForKey:@"patientId"];
            NSLog(@"patientid login:%@",patientid_str);
            
            
            
            NSLog(@"username value:%@",self.username_txtfld.text);
            
            IMIHLLogin*login = [[IMIHLLogin alloc]init];
           
            login = [login getLoginResult:restlogin.restresult_dict];
            NSLog(@"test1");
            /*
            [[NSUserDefaults standardUserDefaults] setValue:self.username_txtfld.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"test2");
            [[NSUserDefaults standardUserDefaults] setValue:self.usrpasswrd_txt.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"test3");
             */
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:login];
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userprofiles"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"test4");
            
            
            
            ALUserLogin *userLogin = [[ALUserLogin alloc]init];
            
            userLogin.userid = txtUserName.text;
            userLogin.password = txtPassword.text;
            NSData *logindata = [NSKeyedArchiver archivedDataWithRootObject:userLogin];
            
            [[NSUserDefaults standardUserDefaults] setObject:logindata forKey:@"userlogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
           
            [self loadViewControllerFromStoryBoard:@"dashboard"];
            
            
            
           
        }else if(response >= 201 && response < 300){
            NSLog(@"Result login 201>:%@",restlogin.restresult_dict);
            [self showAlertController:[restlogin.restresult_dict objectForKey:@"message"]];
        }
        else if(response >= 400 && response < 500){
            NSLog(@"Result login 400=>:%@",restlogin.restresult_dict);
            [self showAlertController:[restlogin.restresult_dict objectForKey:@"message"]];
        }else if(response >= 500 && response < 600){
            NSLog(@"Result login 500=>:%@",restlogin.restresult_dict);
            [self showAlertController:[restlogin.restresult_dict objectForKey:@"message"]];
        }
    }];
    
   
    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)showAlertController:(NSString*)alrtmsg{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //NSLog(@"touchview:%@",touch.view);
    if ([touch.view isKindOfClass:[UIImageView class]]) {
        
        [self.username_txtfld resignFirstResponder];
        [self.usrpasswrd_txt resignFirstResponder];
    }
}


-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"load vc");
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString * storyboardName = @"Main";
    if([identifiername isEqualToString:@"dashboard"]){
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
     IMIHLDashboardVC* vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    vc.patientid_str = self.patientid_str;
    vc.patientname_str = self.patientname_str;
    
    //[self presentViewController:vc animated:YES completion:nil];
   // UINavigationController*navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    [self.navigationController pushViewController:vc animated:YES];
    //[navigationController pushViewController:vc animated:YES];
    
    }
}


@end
