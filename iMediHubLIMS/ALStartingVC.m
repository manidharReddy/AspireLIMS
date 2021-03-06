//
//  ALStartingVC.m
//  AspireLIMS
//
//  Created by ihub on 29/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALStartingVC.h"
#import "IMIHLRestService.h"
#import "IMIHLLogin.h"
#import "IMIHLLoginViewController.h"
#import "ViewController.h"
#import "ALUserLogin.h"
@interface ALStartingVC ()
@property (strong,nonatomic) NSString*username;
@property (strong,nonatomic) NSString*userpassword;
@end

@implementation ALStartingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    [self loggedUser];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)loggedUser{
    ALUserLogin*userLogin = [self getUserLoginDetails];
    NSLog(@"userid:%@",userLogin.userid);
    self.username = userLogin.userid;
    self.userpassword = userLogin.password;
    NSLog(@"username local:%@",self.userpassword);
    if (self.username != NULL && self.userpassword != NULL) {
        //[self loginCalled];
        [self newLoginCalled];
    }else{
       [self loadViewControllerFromStoryBoard:@"login"];
    }
}
-(ALUserLogin*)getUserLoginDetails{
    NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userdefaults objectForKey:@"userlogin"];
    ALUserLogin * login = (ALUserLogin*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"login object:%@",login);
    return login;
}

-(void)newLoginCalled{
    //NSLog(@"loginCalled");
    IMIHLRestService*restlogin = [IMIHLRestService getSharedInstance];
    //IMIHLRestService*restlogin = [[IMIHLRestService alloc]init];
    NSLog(@"logged called");
    // int statuscode = [restlogin login:txtUserName.text :txtPassword.text];
    
    [restlogin newLoginWithUserIdPasswordByBlock:self.username :self.userpassword withCompletionHandler:^(NSInteger response) {
        if (response == 200) {
            NSLog(@"restlogin.restresult_dict:%@",restlogin.restresult_dict);
            NSString*patientid_str = [restlogin.restresult_dict objectForKey:@"patientId"];
            NSLog(@"patientid login:%@",patientid_str);
            
            
            
            
            
            IMIHLLogin*login = [[IMIHLLogin alloc]init];
            
            login = [login getLoginResult:restlogin.restresult_dict];
            NSLog(@"test1");
            /*
            [[NSUserDefaults standardUserDefaults] setValue:self.username forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"test2");
            [[NSUserDefaults standardUserDefaults] setValue:self.userpassword forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"test3");
             */
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:login];
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userprofiles"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"test4");
            
            
            
            [self loadViewControllerFromStoryBoard:@"dashboard"];
            
            
            
            
        }else if(response >= 201 && response < 300){
            NSLog(@"Result login 201>:%@",restlogin.restresult_dict);
           [self loadViewControllerFromStoryBoard:@"login"];
        }
        else if(response >= 400 && response < 500){
            NSLog(@"Result login 400=>:%@",restlogin.restresult_dict);
            [self loadViewControllerFromStoryBoard:@"login"];
        }else if(response >= 500 && response < 600){
            NSLog(@"Result login 500=>:%@",restlogin.restresult_dict);
           [self loadViewControllerFromStoryBoard:@"login"];
        }else if(response == 0){
           [self loadViewControllerFromStoryBoard:@"dashboard"];
        }
    }];
    
    
    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"load vc");
    
    NSString * storyboardName = @"Main";
    if([identifiername isEqualToString:@"dashboard"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        ViewController *vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        IMIHLLoginViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"loginpage"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
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

@end
