//
//  AppDelegate.h
//  Adam_20191028_DatePickerHorizontal
//
//  Created by Adonis_HongYang on 2019/10/28.
//  Copyright © 2019 Adonis_HongYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

