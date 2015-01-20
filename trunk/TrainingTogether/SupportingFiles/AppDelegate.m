//
//  AppDelegate.m
//  TrainingTogether
//
//  Created by Alessio Melani on 13/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "AppDelegate.h"
#import "ProgramSelectionViewController.h"

@interface AppDelegate ()

- (void)createEditableCopyOfDb;

@end

@implementation AppDelegate

- (void)createEditableCopyOfDb
{
    NSString* dbFilePath = nil;
    NSArray* searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentFolderPath = [searchPaths objectAtIndex:0];
    dbFilePath = [documentFolderPath stringByAppendingPathComponent:@"storage.sqlite"];
    
    //copia della base di dati
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFilePath])
    {
        NSString* backupDbPath = [[NSBundle mainBundle] pathForResource:@"storage" ofType:@"sqlite"];
        if (backupDbPath == nil)
        {
            DLog(@"Database path is nil");
        }
        else
        {
            BOOL copiedBackupDb = [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
            if (!copiedBackupDb)
            {
                DLog(@"Copying database failed");
            }
            else
            {
                DLog(@"Copying database succeed");
            }
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [self createEditableCopyOfDb];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ProgramSelectionViewController* programSelectionViewController = [[ProgramSelectionViewController alloc] initWithNibName:@"ProgramSelectionViewController" bundle:nil];
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:programSelectionViewController];
    
    
    
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
