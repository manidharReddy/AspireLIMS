//
//  IMIHLRemainder.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 28/06/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLRemainder.h"
#import "IMIHLDBManager.h"
#import "IMIHLRestService.h"

@import EventKit;
@interface IMIHLRemainder ()
// The database with calendar events and reminders
@property (strong, nonatomic) EKEventStore *eventStore;

// Indicates whether app has access to event store.
@property (nonatomic) BOOL isAccessToEventStoreGranted;
@property (copy, nonatomic) NSArray *reminders;
@end

@implementation IMIHLRemainder

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.remainderBackBarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    
   // [self getReminderList];
    
    //[self updateAuthorizationStatusToAccessEventStore];
   // if (self.isAccessToEventStoreGranted) {
   // [self getAllReminders];
  //  }
    //[self.tableView reloadData];
    self.navigationController.navigationBarHidden = NO;
    //[self getReminders];
    
    [self remainders];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
   
    self.remainderBackBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.remainderBackBarItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.remainderBackBarItem];
    
}

- (void)goBack
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getReminders{
    IMIHLRestService*rest = [IMIHLRestService getSharedInstance];
    if ([rest remainders:self.patientId] == 200) {
        self.remList  = [[IMIHLRemaindersList alloc]init];
        NSLog(@"restResult:%@",rest.restresult_dict);
        self.remList = [self.remList getRemainders:rest.restresult_dict];
        NSLog(@"count");
        [self.tableView reloadData];
    }
    
}

-(void)remainders{
   IMIHLRestService*rest = [IMIHLRestService getSharedInstance];
    [rest remainders:self.patientId withCompletionHandler:^(NSInteger response) {
        if (response == 200) {
            self.remList  = [[IMIHLRemaindersList alloc]init];
            NSLog(@"restResult:%@",rest.restresult_dict);
            self.remList = [self.remList getRemainders:rest.restresult_dict];
            NSLog(@"count");
            [self.tableView reloadData];
        }else{
            
        }
    }];
}
-(void)getReminderList{
    //NSLog(@"RemindersList called");
    IMIHLDBManager*dbmanager = [IMIHLDBManager getSharedInstance];
    
   // self.reminderdata_arr = [[NSMutableArray alloc]init];
    
    dbmanager = [dbmanager getPatientAppointmentsList];
    
    
    //NSLog(@"dbmanager.apptest_arr:%@",dbmanager.apptest_arr);
    if (dbmanager.apptdate_arr.count==0) {
        [self showAlertController:@"You dont have any remainders"];
    }else{
        
       NSDate*currentdate =[NSDate date];
        NSDateFormatter *df= [[NSDateFormatter alloc] init];
        
        [df setDateFormat:@"yyyy-MM-dd"];
        
        
    for (int i=0; i<dbmanager.apptest_arr.count; i++) {
    
        
        NSComparisonResult result = [[df dateFromString:[dbmanager.apptdate_arr objectAtIndex:i]]  compare:currentdate];
        
        if(result==NSOrderedAscending){
            //NSLog(@"Date1 is in the future");
            //int success =[dbmanager deleteOldAppoinmentsList:[dbmanager.apptdate_arr objectAtIndex:i]];
            //NSLog(@"success:%d",success);
            
        }
        else if(result==NSOrderedDescending){
            //NSLog(@"Date1 is in the past");
          
           
        }
        else{
                //NSLog(@"Both dates are the same");
        }
    }
        [self getReminderTotalList];
    }
}



-(void)getReminderTotalList{
    //NSLog(@"getReminderTotalList");
    IMIHLDBManager*dbmanager = [IMIHLDBManager getSharedInstance];
    
    self.reminderdata_arr = [[NSMutableArray alloc]init];
    
    dbmanager = [dbmanager getPatientAppointmentsList];
    
    
    //NSLog(@"dbmanager.apptest_arr total:%@",dbmanager.apptest_arr);
    
        for (int i=0; i<dbmanager.apptest_arr.count; i++) {
            NSString*reminder_srt = [NSString stringWithFormat:@"You have an appointment booked on %@ for %@",[dbmanager.apptdate_arr objectAtIndex:i],[dbmanager.apptest_arr objectAtIndex:i]];
            [self.reminderdata_arr addObject:reminder_srt];
        }
}

-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Remainders"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return self.remList.remainders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    //NSLog(@"reminderarr count:%u",self.reminderdata_arr.count);
    NSLog(@"reminderscount:%lu",self.remList.remainders.count);
    //return self.remList.remainders.count;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"remaindercell";
    ALRemainders*remainder = [self.remList.remainders objectAtIndex:indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        //cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        //cell.textLabel.numberOfLines = 1;
       // cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:cell.frame.size.height*0.3];
        
        //cell.textLabel.textColor = [UIColor colorWithRed:93.0/255.0 green:109.0/255.0 blue:126.0/255 alpha:1.0];
    }
    
    //tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"remaindercell" forIndexPath:indexPath];
    
    // Configure the cell...
    
     //cell.textLabel.text = @"You have an appointment booked on 17-Nov-2016 for ABO Blood Test";
    
    cell.layer.cornerRadius = 10.0f;
    [cell.imageView setImage:[UIImage imageWithIcon:@"fa-clock-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor brownColor] fontSize:cell.bounds.size.height/3]];
     //cell.textLabel.text = [NSString stringWithFormat:@"%@",remainder.appointmentDate];
    cell.textLabel.text =[NSString stringWithFormat:@"You have an appointment booked on %@ by appointment id %@",remainder.appointmentDate,remainder.apptmtId];
     //cell.detailTextLabel.text = @"";
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:cell.bounds.size.height/3];
    //NSLog(@"remider text:%@",[self.reminderdata_arr objectAtIndex:indexPath.row]);
    return cell;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 if (section==0) {
 return [NSString stringWithFormat:@"%@",@"Upcoming event"];
 }
 return nil;
 }
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.bounds.size.height*0.08;
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel*welcm_lbl = [[UILabel alloc]init];
    [welcm_lbl setText:@"Upcoming events"];
    welcm_lbl.textColor = [UIColor darkGrayColor];
    welcm_lbl.textAlignment = NSTextAlignmentLeft;
    
   // [welcm_lbl setFont:[UIFont systemFontOfSize:self.view.bounds.size.width/12]];
   // welcm_lbl.frame = CGRectMake(tableView.frame.size.width,tableView.sectionHeaderHeight,tableView.frame.size.width,tableView.sectionHeaderHeight);
    return welcm_lbl;
}
 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)remainderBackBarItemClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}

/*Reminder Implementation*/
#pragma mark - Custom accessors

// 1
- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}


#pragma mark - Reminders

- (void)updateAuthorizationStatusToAccessEventStore {
    // 2
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    
    switch (authorizationStatus) {
            // 3
        case EKAuthorizationStatusDenied:
        case EKAuthorizationStatusRestricted: {
            self.isAccessToEventStoreGranted = NO;
            /*
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Access Denied"
                                                                message:@"This app doesn't have access to your Reminders." delegate:nil
                                                      cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
            [alertView show];
            */
            
            UIAlertController* alertView = [UIAlertController
                                        alertControllerWithTitle:@"Access Denied"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                        message:@"This app doesn't have access to your Reminders."
                                        preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* button0 = [UIAlertAction
                                      actionWithTitle:@"OK"
                                      style:UIAlertActionStyleCancel
                                      handler:^(UIAlertAction * action)
                                      {
                                          //  UIAlertController will automatically dismiss the view
                                      }];
            [alertView addAction:button0];
            [self presentViewController:alertView animated:YES completion:nil];
            //[self.tableView reloadData];
            break;
        }
            
            // 4
        case EKAuthorizationStatusAuthorized:
            self.isAccessToEventStoreGranted = YES;
            //[self.tableView reloadData];
            break;
            
            // 5
        case EKAuthorizationStatusNotDetermined: {
            __weak IMIHLRemainder *weakSelf = self;
            [self.eventStore requestAccessToEntityType:EKEntityTypeReminder
                                            completion:^(BOOL granted, NSError *error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    weakSelf.isAccessToEventStoreGranted = granted;
                                                    //[weakSelf.tableView reloadData];
                                                });
                                            }];
        
            break;
        }
    }
}

-(void)getAllReminders{
    
   
    
    self.reminderdata_arr = [[NSMutableArray alloc]init];
    
    // 1
    //if (!self.isAccessToEventStoreGranted)
      //  return;
    
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create the start date components
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    //oneDayAgoComponents.day = -30;
    //oneDayAgoComponents.day = 0;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    //NSLog(@"onedayago:%@",oneDayAgo);
    // Create the end date components
    NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
    oneYearFromNowComponents.year = 1;
    NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    //NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:oneDayAgo
      //                                                      endDate:oneYearFromNow
        //                                                  calendars:nil];
    
    /// Create the predicate from the event store's instance method
    NSPredicate *predicate = [self.eventStore predicateForIncompleteRemindersWithDueDateStarting:oneDayAgo ending:oneYearFromNow calendars:nil];
    
    //NSLog(@"precedents");
    // Fetch all events that match the predicate
    //NSArray *events = [self.eventStore eventsMatchingPredicate:predicate];
    ////NSLog(@"events:%@",events);
    
    
    [self.eventStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        for (EKReminder *reminder in reminders) {
            // do something for each reminder
            //NSLog(@"reminder title:%@",reminder.title);
            if ([reminder.title containsString:@"You have an appointment on"]) {
                //NSLog(@"if entred");
                NSString*strtitle = reminder.title;
            [self.reminderdata_arr addObject:strtitle];
            }
            [self.tableView reloadData];
        }
    }];
    
    //NSLog(@"reminders data:%@",self.reminderdata_arr);
    //[self.tableView reloadData];
}




@end
