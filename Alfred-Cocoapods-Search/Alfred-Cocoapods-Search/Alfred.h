//
//  Alfred.h
//  Alfred-cocoapods-search(objc)
//
//  Created by Vasilis Akoinoglou on 4/10/13.
//  Copyright (c) 2013 Vasilis Akoinoglou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlfredObject : NSObject
// Attributes
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *arg;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) BOOL valid;
@property (nonatomic, copy) NSString *autocomplete;
// Elements
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *icon;

@property (nonatomic, readonly) NSXMLElement *item;
@end

@interface Alfred : NSObject
@property (nonatomic, strong) NSMutableArray *objects;
- (NSString *)serializedResults;
@end
