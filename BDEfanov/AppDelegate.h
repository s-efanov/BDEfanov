//
//  AppDelegate.h
//  Kurs
//
//  Created by Sergey Efanov on 02.12.13.
//  Copyright (c) 2013 Sergey Efanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) NSString *user;
@property (nonatomic, retain) NSString *entity;

- (NSURL *)applicationDocumentsDirectory;

@end
