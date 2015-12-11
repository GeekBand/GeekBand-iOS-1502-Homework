//
//  BYNote.h
//  HelloNote
//
//  Created by binglogo on 15/9/15.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BYUser;

@interface BYNote : NSObject

@property (nonatomic, copy) NSString *noteId;
@property (nonatomic, strong) BYUser *user;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *notePicURL;

@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int liked_count;

@end
