//
//  ICGDataManager.m
//  iCheckInGenie
//
//  Created by Krishna on 25/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import "ICGDataManager.h"
#import "RemoteOperation.h"
#import "CommunicationManager.h"
#import "AFAppDotNetAPIClient.h"
#import "LoginOperation.h"
#import "LoginResponse.h"
#import "EventList.h"
#import "AttendeeDetails.h"
@implementation ICGDataManager

+(instancetype) defaultManager {

    static ICGDataManager *_defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[ICGDataManager alloc] init];
    });
    return _defaultManager;
}

- (RemoteOperation *)operationForType:(NSString *)type
{
    NSString *plistPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"RemoteOperations"
                                                                           ofType:@"plist"];
    NSDictionary *remoteOperationsList = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    return [[NSClassFromString([remoteOperationsList objectForKey:type]) alloc] initWithType:type];
}

- (void) fetchData:(CommpletionHandler)block
{
    __block LoginOperation *op = (LoginOperation*)[self operationForType:ICGLogin];
    [op globalTimelinePostsWithBlock:^(id posts, NSError *error) {
        op.data = posts;
        block(op, error);
    }];

}
/// Login
- (void)parseDataForLogin:(id) data {
    NSDictionary *dict = (NSDictionary *)data;
    LoginResponse* res = [[LoginResponse alloc] init];
    [res setCreatedTimestamp:[dict objectForKey:@"CreatedTimestamp"]];
    [res setDeviceID:[dict objectForKey:@"DeviceID"]];
    [res setID:[dict objectForKey:@"ID"]];
    [res setOrganizerID:[dict objectForKey:@"OrganizerID"]];
    [res setToken:[dict objectForKey:@"Token"]];
    self.loginResponse = res;
}

/// GetList of Events & Parse
- (NSArray*)listOfEventsFromData:(id) data
{
    NSArray *listEvent = (NSArray *)data;
    NSMutableArray *listOfEvents = [[NSMutableArray alloc] init];
    for (NSDictionary *d in listEvent)
    {
        [listOfEvents addObject:[self eventFromDict:d]];
    }

    self.eventsList = listOfEvents;
    return listOfEvents;
}


- (EventList *) eventFromDict:(NSDictionary *)dict
{
    EventList *event = [[EventList alloc] init];
    [event setAcct_Id:[dict objectForKey:@"Acct_Id"]];
    [event setCnfrm_Cd_Lgth_Nb:[dict objectForKey:@"Cnfrm_Cd_Lgth_Nb"]];
    [event setComt_Txt:[dict objectForKey:@"Comt_Txt"]];
    [event setCrt_Dttm:[dict objectForKey:@"Crt_Dttm"]];

    [event setCustm_Fld_1_Sel_In:[dict objectForKey:@"Custm_Fld_1_Sel_In"]];
    [event setCustm_Fld_2_Sel_In:[dict objectForKey:@"Custm_Fld_2_Sel_In"]];
    [event setCustm_Fld_3_Sel_In:[dict objectForKey:@"Custm_Fld_3_Sel_In"]];
    [event setCustm_Fld_4_Sel_In:[dict objectForKey:@"Custm_Fld_4_Sel_In"]];
    [event setCustm_Fld_5_Sel_In:[dict objectForKey:@"Custm_Fld_5_Sel_In"]];
    [event setCustm_Fld_6_Sel_In:[dict objectForKey:@"Custm_Fld_6_Sel_In"]];
    [event setCustm_Fld_7_Sel_In:[dict objectForKey:@"Custm_Fld_7_Sel_In"]];
    [event setCustm_Fld_8_Sel_In:[dict objectForKey:@"Custm_Fld_8_Sel_In"]];
    [event setCustm_Fld_9_Sel_In:[dict objectForKey:@"Custm_Fld_9_Sel_In"]];
    [event setCustm_Fld_10_Sel_In:[dict objectForKey:@"Custm_Fld_10_Sel_In"]];

//    [event setDel_Ind:];
    [event setEnabl_Db_Sync_In:[dict objectForKey:@"Enabl_Db_Sync_In"]];
    [event setEnabl_Ieventgenie_Data_Src_In:[dict objectForKey:@"Enabl_Ieventgenie_Data_Src_In"]];
    [event setEv_Addr_1_Txt:[dict objectForKey:@"Ev_Addr_1_Txt"]];
    [event setEv_Addr_2_Txt:[dict objectForKey:@"Ev_Addr_2_Txt"]];
    [event setEv_Barcd_Type_Cd:[dict objectForKey:@"Ev_Barcd_Type_Cd"]];
    [event setEv_Barcd_Type_Cd:[dict objectForKey:@"Ev_Barcd_Type_Cd"]];
    [event setEv_Cd_Txt:[dict objectForKey:@"Ev_Cd_Txt"]];
    [event setEv_Chk_In_End_Dttm:[dict objectForKey:@"Ev_Chk_In_End_Dttm"]];
    [event setEv_Chk_In_Strt_Dttm:[dict objectForKey:@"Ev_Chk_In_Strt_Dttm"]];
    [event setEv_City_Txt:[dict objectForKey:@"Ev_City_Txt"]];
    [event setEv_Cntct_Id:[dict objectForKey:@"Ev_Cntct_Id"]];
    [event setEv_Cont_Email:[dict objectForKey:@"Ev_Cont_Email"]];
    [event setEv_Desc:[dict objectForKey:@"Ev_Desc"]];
    [event setEv_Early_Chk_In_End_Dttm:[dict objectForKey:@"Ev_Early_Chk_In_End_Dttm"]];
    [event setEv_End_Dt:[dict objectForKey:@"Ev_End_Dt"]];
    [event setEv_Id:[dict objectForKey:@"Ev_Id"]];
    [event setEv_Nm:[dict objectForKey:@"Ev_Nm"]];
    [event setEv_St_Cd:[dict objectForKey:@"Ev_St_Cd"]];
    [event setEv_Strt_Dt:[dict objectForKey:@"Ev_Strt_Dt"]];
    [event setEv_Sts_Cd:[dict objectForKey:@"Ev_Sts_Cd"]];
    [event setEv_Type_Id:[dict objectForKey:@"Ev_Type_Id"]];
    [event setEv_Zip_Cd:[dict objectForKey:@"Ev_Zip_Cd"]];
    [event setHosted_By_Txt:[dict objectForKey:@"Hosted_By_Txt"]];
    [event setMod_By_Usrid:[dict objectForKey:@"Mod_By_Usrid"]];
    [event setMod_Dttm:[dict objectForKey:@"Mod_Dttm"]];
    [event setModuleId:[dict objectForKey:@"ModuleId"]];
    [event setParnt_Ev_Id:[dict objectForKey:@"Parnt_Ev_Id"]];
    [event setPendingCheckIns:[dict objectForKey:@"PendingCheckIns"]];
    [event setRegs_Strt_Dt:[dict objectForKey:@"Regs_Strt_Dt"]];
    [event setSync_Ev_Id:[dict objectForKey:@"Sync_Ev_Id"]];
    [event setTotalAttendees:[dict objectForKey:@"TotalAttendees"]];
    [event setTotalCheckIns:[dict objectForKey:@"TotalCheckIns"]];
    return event;
}


- (void)attendeeList:(id)data {
    // GetList of Attendees & Parse
    NSArray *attendeeList = (NSArray *)data;
    NSMutableArray *listOfAttendees = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in attendeeList) {
        [listOfAttendees addObject:[self attendeeFromDict:dict]];
    }
    
    self.attendeesList = listOfAttendees;
}


- (AttendeeDetails *)attendeeFromDict:(NSDictionary *)dict {
    AttendeeDetails *attendee = [[AttendeeDetails alloc] init];
    
    
    [attendee setAcct_Id:[dict objectForKey:@"Acct_Id"]];
    
    [attendee setAdditional_Guests:[dict objectForKey:@"Additional_Guests"]];
    [attendee setAttendee_Checkedin_Barcd_Txt:[dict objectForKey:@"Attendee_Checkedin_Barcd_Txt"]];
    [attendee setAttendee_Chkd_In_Sts_Cd:@"Attendee_Chkd_In_Sts_Cd"];
    [attendee setAttendee_Id:[dict objectForKey:@"Attendee_Id"]];
    [attendee setCity_Txt:[dict objectForKey:@"City_Txt"]];
    [attendee setCnfrm_Cd:[dict objectForKey:@"Cnfrm_Cd"]];
    [attendee setCrt_By_Usrid:[dict objectForKey:@"Crt_By_Usrid"]];
    [attendee setCrt_Dttm:[dict objectForKey:@"Crt_Dttm"]];
    [attendee setCustm_Fld_1_Lbl_Txt:[dict objectForKey:@"Custm_Fld_1_Lbl_Txt"]];
    [attendee setCustm_Fld_2_Lbl_Txt:[dict objectForKey:@"Custm_Fld_2_Lbl_Txt"]];
    [attendee setCustm_Fld_3_Lbl_Txt:[dict objectForKey:@"Custm_Fld_3_Lbl_Txt"]];
    [attendee setCustm_Fld_4_Lbl_Txt:[dict objectForKey:@"Custm_Fld_4_Lbl_Txt"]];
    [attendee setCustm_Fld_5_Lbl_Txt:[dict objectForKey:@"Custm_Fld_5_Lbl_Txt"]];
    [attendee setCustm_Fld_6_Lbl_Txt:[dict objectForKey:@"Custm_Fld_6_Lbl_Txt"]];
    [attendee setCustm_Fld_7_Lbl_Txt:[dict objectForKey:@"Custm_Fld_7_Lbl_Txt"]];
    [attendee setCustm_Fld_8_Lbl_Txt:[dict objectForKey:@"Custm_Fld_8_Lbl_Txt"]];
    [attendee setCustm_Fld_9_Lbl_Txt:[dict objectForKey:@"Custm_Fld_9_Lbl_Txt"]];
    [attendee setCustm_Fld_10_Lbl_Txt:[dict objectForKey:@"Custm_Fld_10_Lbl_Txt"]];

    [attendee setCustm_Fld_1_Val_Txt:[dict objectForKey:@"Custm_Fld_1_Val_Txt"]];
    [attendee setCustm_Fld_2_Val_Txt:[dict objectForKey:@"Custm_Fld_2_Val_Txt"]];
    [attendee setCustm_Fld_3_Val_Txt:[dict objectForKey:@"Custm_Fld_3_Val_Txt"]];
    [attendee setCustm_Fld_4_Val_Txt:[dict objectForKey:@"Custm_Fld_4_Val_Txt"]];
    [attendee setCustm_Fld_5_Val_Txt:[dict objectForKey:@"Custm_Fld_5_Val_Txt"]];
    [attendee setCustm_Fld_6_Val_Txt:[dict objectForKey:@"Custm_Fld_6_Val_Txt"]];
    [attendee setCustm_Fld_7_Val_Txt:[dict objectForKey:@"Custm_Fld_7_Val_Txt"]];
    [attendee setCustm_Fld_8_Val_Txt:[dict objectForKey:@"Custm_Fld_8_Val_Txt"]];
    [attendee setCustm_Fld_9_Val_Txt:[dict objectForKey:@"Custm_Fld_9_Val_Txt"]];
    [attendee setCustm_Fld_10_Val_Txt:[dict objectForKey:@"Custm_Fld_10_Val_Txt"]];
    [attendee setDel_Ind:[dict objectForKey:@"Del_Ind"]];
    [attendee setEml_Addr_Txt:[dict objectForKey:@"Eml_Addr_Txt"]];
    [attendee setAttendee_Id:[dict objectForKey:@"Attendee_Id"]];
    [attendee setEv_Id:[dict objectForKey:@"Ev_Id"]];
    [attendee setEv_Venue_Id:[dict objectForKey:@"Ev_Venue_Id"]];
    [attendee setFst_Nm:[dict objectForKey:@"Fst_Nm"]];
    [attendee setLast_Nm:[dict objectForKey:@"Last_Nm"]];
    [attendee setMod_By_Usrid:@"Mod_By_Usrid"];
    [attendee setMod_Dttm:[dict objectForKey:@"Mod_Dttm"]];
    [attendee setPhn_Num:[dict objectForKey:@"tPhn_Num"]];
    [attendee setSt_Cd:[dict objectForKey:@"St_Cd"]];
    [attendee setValidity:[dict objectForKey:@"Validity"]];

    return attendee;
}

@end
