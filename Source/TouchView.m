//
//  TouchView.m
//  TouchDB
//
//  Created by Jens Alfke on 6/19/12.
//  Copyright (c) 2012 Couchbase, Inc. All rights reserved.
//

#import "TouchDBPrivate.h"
#import "TDView.h"


@implementation TouchView


- (id)initWithDatabase: (TouchDatabase*)database view: (TDView*)view
{
    self = [super init];
    if (self) {
        _database = [database retain];
        _view = [view retain];
    }
    return self;
}

- (void)dealloc
{
    [_database release];
    [_view release];
    [super dealloc];
}


- (NSString*) name {
    return _view.name;
}


@synthesize database=_database;


- (TDMapBlock) mapBlock         {return _view.mapBlock;}
- (TDReduceBlock) reduceBlock   {return _view.reduceBlock;}

- (BOOL) setMapBlock: (TDMapBlock)mapBlock
         reduceBlock: (TDReduceBlock)reduceBlock
             version: (NSString*)version
{
    if (mapBlock) {
        return [_view setMapBlock: mapBlock reduceBlock: reduceBlock version: version];
    } else {
        [_view deleteView];
        setObj(&_view, nil);
        setObj(&_database, nil);
        return YES;
    }
}

- (BOOL) setMapBlock: (TDMapBlock)mapBlock
             version: (NSString*)version
{
    return [self setMapBlock: mapBlock reduceBlock: nil version: version];
}

- (TouchQuery*) query {
    return [[[TouchQuery alloc] initWithDatabase: _database view: _view] autorelease];
}


@end
