//
//  main.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/21.
//  Copyright © 2019 JA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([SPAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
