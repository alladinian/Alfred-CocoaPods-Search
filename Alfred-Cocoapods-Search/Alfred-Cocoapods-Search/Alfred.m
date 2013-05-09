//
//  Alfred.m
//  Alfred-cocoapods-search(objc)
//
//  Created by Vasilis Akoinoglou on 4/10/13.
//  Copyright (c) 2013 Vasilis Akoinoglou. All rights reserved.
//

#import "Alfred.h"

@implementation AlfredObject

- (id)init
{
    self = [super init];
    if (self)
    {
        _valid = YES;
    }
    
    return self;
}

- (NSXMLElement *)item
{
    NSXMLElement *el = [NSXMLElement elementWithName:@"item"];
    [el setAttributesAsDictionary:@{
    @"uid":self.uid,
    @"arg":self.arg,
    @"valid":self.valid ? @"yes":@"no",
     @"autocomplete":self.valid ? (self.autocomplete?self.autocomplete:@"") : @""
     }];
    
    NSXMLElement *title = [NSXMLElement elementWithName:@"title"];
    [title setStringValue:self.title];
    [el addChild:title];
    
    NSXMLElement *subtitle = [NSXMLElement elementWithName:@"subtitle"];
    [subtitle setStringValue:self.subtitle];
    [el addChild:subtitle];
    
    NSXMLElement *icon = [NSXMLElement elementWithName:@"icon"];
    [icon setStringValue:self.icon];
    [el addChild:icon];
    
    return el;
}


@end

@implementation Alfred

- (id)init
{
    self = [super init];
    if (self)
    {
        _objects = [NSMutableArray arrayWithCapacity:0];
    }
    
    return self;
}

- (NSString *)serializedResults
{
    NSXMLElement *root = [NSXMLElement elementWithName:@"items"];
    NSXMLDocument *output = [NSXMLDocument documentWithRootElement:root];
    for (AlfredObject *object in self.objects)
    {
        [root addChild:object.item];
    }
    
    return output.XMLString;
}

@end
