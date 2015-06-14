//
//  DeviceViewController.m
//  BLKApp
//
//  Created by try on 13-11-27.
//  Copyright (c) 2013年 TRY. All rights reserved.
//

#import "DeviceViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "QuartzCore/QuartzCore.h"

@interface DeviceViewController ()

@end

@implementation DeviceViewController
@synthesize MsgToBTMode;
@synthesize BLKAppUUID;
@synthesize tvRecv;
@synthesize lbDevice;

//add by yaole 2015.4.29
//

@synthesize debugPitchViewed;
@synthesize debugRollViewed;
@synthesize debugYawViewed;
@synthesize debugXPositiveViewed;
@synthesize debugXNegativeViewed;
@synthesize debugYPositiveViewed;
@synthesize debugYNegativeViewed;


@synthesize debugPIDPitchP;
@synthesize debugPIDPitchI;
@synthesize debugPIDPitchD;
@synthesize debugPIDRollP;
@synthesize debugPIDRollI;
@synthesize debugPIDRollD;

//add off
@synthesize rssi_container;

//@synthesize timer;

@synthesize peripheral;
@synthesize sensor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = self.sensor.activePeripheral.name;
    self.sensor.delegate = self;
    
    tvRecv.layer.borderWidth = 1;
    tvRecv.layer.borderColor = [[UIColor grayColor] CGColor];
    tvRecv.layer.cornerRadius = 8;
    tvRecv.layer.masksToBounds = YES;
    
    BLKAppUUID.layer.borderWidth = 1;
    BLKAppUUID.layer.borderColor = [[UIColor grayColor] CGColor];
    BLKAppUUID.layer.cornerRadius = 8;
    BLKAppUUID.layer.masksToBounds = YES;
    
    lbDevice.layer.borderWidth = 1;
    lbDevice.layer.borderColor = [[UIColor grayColor] CGColor];
    lbDevice.layer.cornerRadius = 8;
    lbDevice.layer.masksToBounds = YES;
}

- (void)viewDidUnload
{
    [self setBLKAppUUID:nil];
    [self setMsgToBTMode:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//recv data  显示传感器的数值
//bool receive_flag=0;

-(void) serialGATTCharValueUpdated:(NSString *)UUID value:(NSData *)data
{
    //NSString* a ="\n";
    //tvRecv.text = nil;
    //[tvRecv reloadInputViews];//清除上一次缓存
     NSString *value= [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
   // NSString *temp=nil;
   // tvRecv.text= [tvRecv.text stringByAppendingString:value];
   // tvRecv.text= [tvRecv.text stringByAppendingString:@"\n"];
    
    NSUInteger length=value.length;
    if(length>12)
    {
        char index=1;
        for(char k=12;k>0;k--)
        {
            unichar c = [value characterAtIndex:index];
            if(c=='S')break;
            index++;
        }
        if(index<=12)
        {
            index++;
            unichar c = [value characterAtIndex:index];
            NSString* s =nil;
             //NSLog(@"%d\n",c);
            switch(c)
            {
                case '1':
                    debugYawViewed.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugYawViewed.text = [debugYawViewed.text stringByAppendingPathComponent:s]; //显示字符串
                    break;
                case '2':
                    debugRollViewed.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugRollViewed.text = [debugRollViewed.text stringByAppendingPathComponent:s];//显示字符串
                    break;
                case '3':
                    debugPitchViewed.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugPitchViewed.text = [debugPitchViewed.text stringByAppendingPathComponent:s];//显示字符串
                    break;
                case '4':
                    debugXPositiveViewed.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugXPositiveViewed.text = [debugXPositiveViewed.text stringByAppendingPathComponent:s]; //显示字符串
                    break;
                case '5':
                    debugXNegativeViewed.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugXNegativeViewed.text = [debugXNegativeViewed.text stringByAppendingPathComponent:s]; //显示字符串
                    break;
                case '6':
                    debugYPositiveViewed.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugYPositiveViewed.text = [debugYPositiveViewed.text stringByAppendingPathComponent:s]; //显示字符串
                    break;
                case '7':
                    debugYNegativeViewed.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugYNegativeViewed.text = [debugYNegativeViewed.text stringByAppendingPathComponent:s]; //显示字符串
                    break;
                case '8':
                    debugPIDPitchP.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugPIDPitchP.text=[debugPIDPitchP.text stringByAppendingPathComponent:s];
                    break;
                case '9':
                    debugPIDPitchI.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugPIDPitchI.text=[debugPIDPitchI.text stringByAppendingPathComponent:s];
                    break;
                case 'a':
                    debugPIDPitchD.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugPIDPitchD.text=[debugPIDPitchD.text stringByAppendingPathComponent:s];
                    break;
                case 'b':
                    debugPIDRollP.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugPIDRollP.text=[debugPIDRollP.text stringByAppendingPathComponent:s];
                    break;
                case 'c':
                    debugPIDRollI.text=nil;
                    s= [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugPIDRollI.text=[debugPIDRollI.text stringByAppendingPathComponent:s];
                    break;
                case 'd':
                    debugPIDRollD.text=nil;
                    s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                    debugPIDRollD.text=[debugPIDRollD.text stringByAppendingPathComponent:s];
                    break;
                default:
                    break;
                    
            }
        }
    }

    
    /*
    NSData *data_new = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data_new];
    data    =   [@":" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data_new];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data_new];*/
    /*NSString* s =nil;
    s = [value substringWithRange:NSMakeRange(index,5)]; //截取字符串
    debugYawViewed.text = [debugYawViewed.text stringByAppendingPathComponent:s]; //显示字符串
    index+=5;
    s = [value substringWithRange:NSMakeRange(index,5)]; //截取字符串
    debugRollViewed.text = [debugRollViewed.text stringByAppendingPathComponent:s];//显示字符串
    index+=5;
    s = [value substringWithRange:NSMakeRange(index,5)]; //截取字符串
    debugPitchViewed.text = [debugPitchViewed.text stringByAppendingPathComponent:s];//显示字符串
    index+=5;
    s = [value substringWithRange:NSMakeRange(index,4)]; //截取字符串
    debugXPositiveViewed.text = [debugXPositiveViewed.text stringByAppendingPathComponent:s]; //显示字符串
    index+=4;
    s = [value substringWithRange:NSMakeRange(index,4)]; //截取字符串
    debugXNegativeViewed.text = [debugXNegativeViewed.text stringByAppendingPathComponent:s]; //显示字符串
    index+=4;
    s = [value substringWithRange:NSMakeRange(index,4)]; //截取字符串
    debugYPositiveViewed.text = [debugYPositiveViewed.text stringByAppendingPathComponent:s]; //显示字符串
    index+=4;
    s = [value substringWithRange:NSMakeRange(index,4)]; //截取字符串
    debugYNegativeViewed.text = [debugYNegativeViewed.text stringByAppendingPathComponent:s]; //显示字符串
    index+=4;*/
    
   
    /*for (char k=6; k>0; k--) {
        unichar c = [value characterAtIndex:index];
        if(c=='R')break;
        else if(c=='P')break;
        else if(c=='Y')break;
        else if(c=='A')break;
        else if(c=='B')break;
        else if(c=='C')break;
        else if(c=='D')break;
        index++;
    }
    for(int j=0;j<3;j++)
    {
        unichar c = [value characterAtIndex:index];
        NSString* s =nil;
        //NSArray *array=[value componentsSeparatedByString:@","];
        switch(c)
        {
            case 'R':
                debugRollViewed.text = nil;
                [debugRollViewed reloadInputViews];//清除上一次缓存
                s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                debugRollViewed.text = [debugRollViewed.text stringByAppendingPathComponent:s];//显示字符串
                index+=5;
                break;
            case 'P':
                debugPitchViewed.text = nil;
                [debugPitchViewed reloadInputViews];//清屏
                s = [value substringWithRange:NSMakeRange(index+1,5)];//[value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                debugPitchViewed.text = [debugPitchViewed.text stringByAppendingPathComponent:s];//显示字符串
                index+=5;
                break;
            case 'Y':
                debugYawViewed.text = nil;
                [debugYawViewed reloadInputViews];//清除上一次缓存
                s = [value substringWithRange:NSMakeRange(index+1,5)]; //截取字符串
                debugYawViewed.text = [debugYawViewed.text stringByAppendingPathComponent:s]; //显示字符串
                index+=5;
                break;
            case 'A':
                debugXPositiveViewed.text = nil;
                [debugXPositiveViewed reloadInputViews];//清除上一次缓存
                s = [value substringWithRange:NSMakeRange(index+1,4)]; //截取字符串
                debugXPositiveViewed.text = [debugXPositiveViewed.text stringByAppendingPathComponent:s]; //显示字符串
                index+=4;
                break;
            case 'B':
                debugXNegativeViewed.text = nil;
                [debugXNegativeViewed reloadInputViews];//清除上一次缓存
                s = [value substringWithRange:NSMakeRange(index+1,4)]; //截取字符串
                debugXNegativeViewed.text = [debugXNegativeViewed.text stringByAppendingPathComponent:s]; //显示字符串
                index+=4;
                break;
            case 'C':
                debugYPositiveViewed.text = nil;
                [debugYPositiveViewed reloadInputViews];//清除上一次缓存
                s = [value substringWithRange:NSMakeRange(index+1,4)]; //截取字符串
                debugYPositiveViewed.text = [debugYPositiveViewed.text stringByAppendingPathComponent:s]; //显示字符串
                index+=4;
                break;
            case 'D':
                debugYNegativeViewed.text = nil;
                [debugYNegativeViewed reloadInputViews];//清除上一次缓存
                s = [value substringWithRange:NSMakeRange(index+1,4)]; //截取字符串
                debugYNegativeViewed.text = [debugYNegativeViewed.text stringByAppendingPathComponent:s]; //显示字符串
                index+=4;
                break;
            default:
                break;
        }
        
        
        
    }*/

    //tvRecv.text= [tvRecv.text stringByAppendingString:value];

   // debugRollViewed.text=[debugRollViewed.text stringByAppendingPathComponent:value];
    
}
//send data  changed by yaole 2015.4.28
/*********
 //  sender button function
 //
 *********/
- (IBAction)sendMsgToBTMode:(id)sender {
    NSData *data = [MsgToBTMode.text dataUsingEncoding:[NSString defaultCStringEncoding]];
    [sensor write:sensor.activePeripheral data:data];
}
//start stop button
- (IBAction)drylStartButton:(id)sender {
    if([[sender currentTitle]isEqualToString:@"Start"]) // start button function "0x30"
    {
        NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
        [sensor write:sensor.activePeripheral data:data];
        data    =   [@"0" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
        [sensor write:sensor.activePeripheral data:data];
        data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
        [sensor write:sensor.activePeripheral data:data];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
        [sender setTintColor:[UIColor redColor]];
    }
    else // stop button function "0x31"

    {
        NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
        [sensor write:sensor.activePeripheral data:data];
        data    =   [@"1" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
        [sensor write:sensor.activePeripheral data:data];
        data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
        [sensor write:sensor.activePeripheral data:data];
        [sender setTitle:@"Start" forState:UIControlStateNormal];
        [sender setTintColor:[UIColor blueColor]];
    }
    
}
//clean button
//clean screen content
- (IBAction)drylCleanButtton:(id)sender {
    tvRecv.text=nil;
    [tvRecv reloadInputViews];
    
}
//top button  function "0x32"
- (IBAction)drylTopButton:(id)sender
{
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"2" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
//down button function "0x33"
- (IBAction)drylDownButton:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"3" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
//left button  function "0x34"
- (IBAction)drylLeftButton:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"4" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
//right button function "0x35"
- (IBAction)drylRightButton:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"5" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
/**********************************************************
Pitch PID 设置
 ***********************************************************/
- (IBAction)drylPitchPIDPInc:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"=" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
    
}
- (IBAction)drylPitchPIDPDec:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"@" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
- (IBAction)drylPitchPIDIInc:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@">" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
- (IBAction)drylPitchPIDIDec:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"A" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
- (IBAction)drylPitchPIDDInc:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"?" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
- (IBAction)drylPitchPIDDDec:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"B" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
/*********************************************************
Roll  PID  设置
 ******************************/
- (IBAction)drylRollPIDPInc:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"C" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
    
}
- (IBAction)drylRollPIDPDec:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"F" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
    
}
- (IBAction)drylRollPIDIInc:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"D" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
- (IBAction)drylRollPIDIDec:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"G" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}

- (IBAction)drylRollPIDDInc:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"E" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}
- (IBAction)drylRollPIDDDec:(id)sender {
    NSData *data = [@"Head" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送头
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"H" dataUsingEncoding:[NSString defaultCStringEncoding]];  //发送内容
    [sensor write:sensor.activePeripheral data:data];
    data    =   [@"Tail" dataUsingEncoding:[NSString defaultCStringEncoding]];//发送尾
    [sensor write:sensor.activePeripheral data:data];
}

/***********************************************************************/
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    NSTimeInterval anm = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:anm];
    if(offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([[[UIDevice currentDevice] systemVersion]floatValue] >= 7)
    {
        self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        
    }else
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
// 设置连接
-(void)setConnect
{
    CFStringRef s = CFUUIDCreateString(kCFAllocatorDefault, (__bridge CFUUIDRef )sensor.activePeripheral.identifier);
    BLKAppUUID.text = (__bridge NSString*)s;
    tvRecv.text = @"OK+CONN";
}
//断开连接
-(void)setDisconnect
{
    tvRecv.text= [tvRecv.text stringByAppendingString:@"OK+LOST"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
