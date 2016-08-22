//
//  ViewController.m
//  ClockRadio
//
//  Created by Andre Hess on 16.06.16.
//  Copyright © 2016 Andre Hess. All rights reserved.
//

#import <EventKit/EventKit.h>
#import "MainViewController.h"
#import "AudioPlayerView.h"
#import "RadioStationSelectonViewController.h"
#import "AlarmSelectionViewController.h"
#import "Configuration.h"
#import "TuneinProvider.h"
#import "StationProvider.h"
#import "Station.h"
#import "StationTuneinDetails.h"

#define LocalNotificationInfoDateKey @"LocalNotificationInfoDateKey"

@interface MainViewController () <RadioStationSelectionDelegate, AlarmSelectionDelegate>
@property (nonatomic, weak) IBOutlet UILabel *radioSelectionLabel;
@property (nonatomic, weak) IBOutlet UILabel *radioSelectionValueLabel;
@property (nonatomic, weak) IBOutlet UIButton *radioSelectionButton;
@property (nonatomic, weak) IBOutlet UILabel *alarmSelectionLabel;
@property (nonatomic, weak) IBOutlet UILabel *alarmSelectionValueLabel;
@property (nonatomic, weak) IBOutlet UIButton *alarmSelectionButton;
@property (nonatomic, strong) STKAudioPlayer *audioPlayer;
@property (nonatomic, strong) AudioPlayerView *audioPlayerView;
@property (nonatomic, strong) TuneinProvider *tuneinProvider;
@property (nonatomic, strong) StationProvider *stationProvider;
@end

@implementation MainViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self != nil) {
		self.tuneinProvider = [TuneinProvider sharedProvider];
		self.stationProvider = [StationProvider sharedProvider];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self refreshView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
}

- (void)refreshView {
	[self addPlayerView];
	self.radioSelectionValueLabel.text = [Configuration currentConfiguration].currentSelectedRadioStationURLString;
	self.alarmSelectionValueLabel.text = [[Configuration currentConfiguration].currentAlarmDate descriptionWithLocale:[NSLocale currentLocale]];
	if ([Configuration currentConfiguration].shouldPlayImmediately) {
		[Configuration currentConfiguration].playImmediately = NO;
		NSURL *url = [Configuration currentConfiguration].currentSelectedRadioStationURL;
		if (url == nil) {
			url = [NSURL URLWithString:[Configuration currentConfiguration].currentSelectedRadioStationURLString];
		}
		
		STKDataSource* dataSource = [STKAudioPlayer dataSourceFromURL:url];
		[self.audioPlayer queueDataSource:dataSource withQueueItemId:@0];
	}
}

- (void)addPlayerView {
	if (self.audioPlayer != nil) {
		[self.audioPlayer stop];
	}
	self.audioPlayer = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = YES, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000} }];
	self.audioPlayer.meteringEnabled = YES;
	self.audioPlayer.volume = 1;
	
	[self.audioPlayerView removeFromSuperview];
	self.audioPlayerView = [[AudioPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2) withAudioPlayer:self.audioPlayer];
	//audioPlayerView.delegate = self;
	
	[self.view addSubview:self.audioPlayerView];
}

- (void)viewDidLayoutSubviews {
	self.audioPlayerView.frame = CGRectMake(8, self.view.bounds.size.height / 2, self.view.bounds.size.width - 16, (self.view.bounds.size.height - 16) / 2);
}

#pragma mark -
#pragma mark Button handling
#pragma mark -

- (IBAction)radioSelectionButtonTouched:(id)sender {
	RadioStationSelectonViewController *controller = [[RadioStationSelectonViewController alloc] initWithNibName:@"RadioStationSelectonViewController" bundle:nil];
	controller.delegate = self;
	[self presentViewController:controller animated:YES completion:NULL];
}

- (IBAction)alarmSelectionButtonTouched:(id)sender {
	AlarmSelectionViewController *controller = [[AlarmSelectionViewController alloc] initWithNibName:@"AlarmSelectionViewController" bundle:nil];
	controller.delegate = self;
	[self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark -
#pragma mark RadioStationSelectionDelegate
#pragma mark -

- (void)radioStationSelectionVCDidCancelSelecting:(RadioStationSelectonViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

//- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStationURLString:(NSString *)radioStationURLString {
//	[Configuration currentConfiguration].currentSelectedRadioStationURLString = radioStationURLString;
//	[self dismissViewControllerAnimated:YES completion:NULL];
//	[self refreshView];
//}
//
//- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStationURL:(NSURL *)radioStationURL {
//	[Configuration currentConfiguration].currentSelectedRadioStationURL = radioStationURL;
//	[self dismissViewControllerAnimated:YES completion:NULL];
//	[self refreshView];
//}

- (void)radioStationSelectionVC:(RadioStationSelectonViewController *)controller didFinishWithRadioStation:(Station *)station {
	__weak typeof(self) weakSelf = self;
	[self dismissViewControllerAnimated:YES completion:^{
		[weakSelf.tuneinProvider loadTuneinDataWithStationId:station.stationId
											   forTuneinBase:self.stationProvider.tuneinBase
											  withCompletion:^(id tuneinData, NSError *error) {
												  [Configuration currentConfiguration].currentSelectedRadioStationURLString = weakSelf.tuneinProvider.tuneinDetails.fileURLStrings[0];
												  [weakSelf refreshView];
											  }];
	}];
}

#pragma mark -
#pragma mark AlarmSelectionDelegate
#pragma mark -

- (void)alarmSelectonVCDidCancel:(AlarmSelectionViewController *)controller {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)alarmSelectionVC:(AlarmSelectionViewController *)controller didFinishWithAlarmDate:(NSDate *)date {
	__weak typeof(self) weakSelf = self;
	[self dismissViewControllerAnimated:YES completion:^{
		[Configuration currentConfiguration].currentAlarmDate = date;
		[weakSelf refreshView];
		[weakSelf createLocalNotificationForDate:date];
	}];
}

- (void)registerForLocalNotifications {
	UIUserNotificationType types = (UIUserNotificationType) (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert);
	UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
	[[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
}

- (void)createLocalNotificationForDate:(NSDate *)date {
	//if ([[UIApplication sharedApplication] currentUserNotificationSettings] == nil) {
		[self registerForLocalNotifications];
	//}
	
	UILocalNotification *localNotif = [[UILocalNotification alloc] init];
	if (localNotif == nil) {
		return;
	}
	
	localNotif.fireDate = date;
	localNotif.timeZone = [NSTimeZone defaultTimeZone];
	localNotif.alertBody = @"Aufwachen!";
	localNotif.alertAction = @"Jetzt!";
	localNotif.alertTitle = @"Wirklich!";
	//localNotif.soundName = UILocalNotificationDefaultSoundName;
	localNotif.soundName = @"Gipfel";
	localNotif.applicationIconBadgeNumber = 1;
	localNotif.userInfo = @{LocalNotificationInfoDateKey: date};
	
 	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

@end
