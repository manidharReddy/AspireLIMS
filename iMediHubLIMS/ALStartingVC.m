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
@interface ALStartingVC ()
@property (strong,nonatomic) NSString*username;
@property (strong,nonatomic) NSString*userpassword;
@end

@implementation ALStartingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loggedUser];
}

-(void)loggedUser{
    _username = [[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
    _userpassword = [[NSUserDefaults standardUserDefaults]valueForKey:@"password"];
    if (_username != NULL && _userpassword != NULL) {
        [self loginCalled];
    }else{
       [self loadViewControllerFromStoryBoard:@"login"];
    }
}

-(void)loginCalled{
    
    IMIHLRestService*restlogin = [IMIHLRestService getSharedInstance];
    
    NSLog(@"logged called");
    
    int statuscode = [restlogin newLogin:_username :_userpassword];
    NSLog(@"statuscode login:%d",statuscode);
    if (statuscode==200) {
       
        NSLog(@"restlogin.restresult_dict:%@",restlogin.restresult_dict);
        NSString*patientid_str = [restlogin.restresult_dict objectForKey:@"patientId"];
        NSLog(@"patientid login:%@",patientid_str);
   
        IMIHLLogin*login = [[IMIHLLogin alloc]init];
      
        login = [login getLoginResult:restlogin.restresult_dict];
        NSLog(@"test1");
        
        NSLog(@"test3");
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:login];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userprofiles"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"test4");
        
        
        
        [self loadViewControllerFromStoryBoard:@"dashboard"];
        
        
        
        NSLog(@"status code:%d",statuscode);
    }else if (statuscode==500){
        
        [self loadViewControllerFromStoryBoard:@"login"];
        
    }else if (statuscode==0){
         [self loadViewControllerFromStoryBoard:@"login"];
    }else{
         [self loadViewControllerFromStoryBoard:@"login"];
       
    }
    
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