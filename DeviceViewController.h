//
//  DeviceViewController.h
//  BLKApp
//
//  Created by try on 13-11-27.
//  Copyright (c) 2013年 TRY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SerialGATT.h"

#define RSSI_THRESHOLD -60
#define WARNING_MESSAGE @"z"

@class CBPeripheral;
@class SerialGATT;

@interface DeviceViewController : UIViewController<BTSmartSensorDelegate>

@property (strong, nonatomic) CBPeripheral *peripheral;
@property (strong, nonatomic) SerialGATT *sensor;

//@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSMutableArray *rssi_container; // used for contain the indexers of the lower rssi value

@property (weak, nonatomic) IBOutlet UILabel *BLKAppUUID;

- (IBAction)sendMsgToBTMode:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *MsgToBTMode;
@property (weak, nonatomic) IBOutlet UITextView *tvRecv;
@property (weak, nonatomic) IBOutlet UILabel *lbDevice;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UITextField *debugRollViewed;

@property (weak, nonatomic) IBOutlet UITextField *debugYawViewed;

@property (weak, nonatomic) IBOutlet UITextField *debugPitchViewed;


@property (weak, nonatomic) IBOutlet UITextField *debugXPositiveViewed;


@property (weak, nonatomic) IBOutlet UITextField *debugXNegativeViewed;

@property (weak, nonatomic) IBOutlet UITextField *debugYPositiveViewed;
@property (weak, nonatomic) IBOutlet UITextField *debugYNegativeViewed;

@property (weak, nonatomic) IBOutlet UITextField *debugPIDPitchP;

@property (weak, nonatomic) IBOutlet UITextField *debugPIDPitchI;

@property (weak, nonatomic) IBOutlet UITextField *debugPIDPitchD;

@property (weak, nonatomic) IBOutlet UITextField *debugPIDRollP;

@property (weak, nonatomic) IBOutlet UITextField *debugPIDRollI;

@property (weak, nonatomic) IBOutlet UITextField *debugPIDRollD;

@end
