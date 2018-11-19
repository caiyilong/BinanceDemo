//
//  NSDictionary+ExceptionUtil.m
//  CDCloud
//
//  Created by Ronnie Chen on 16/7/22.
//  Copyright © 2016年 云武华科技有限公司. All rights reserved.
//

#import "NSDictionary+ExceptionUtil.h"

@implementation NSDictionary(ExceptionUtil)

-(BOOL)checkTargetKeyIsNotNullOrNotEmpty:(id)key
{
	if(![self objectForKey:key]){
		return NO;
	}
	
	id obj = [self objectForKey:key];// judge NSNull
	
	return ![obj isEqual:[NSNull null]];
}

-(NSString *)stringObjectForKey:(id)aKey
{
	if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
		return [self objectForKey:aKey];
	}
	
	return @"";
}

-(int)intObjectForKey:(id)aKey
{
	if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
		return [[self objectForKey:aKey] intValue];
	}
	
	return 0;
}

-(long)longObjectForKey:(id)aKey
{
	if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
		return [[self objectForKey:aKey] longValue];
	}
	
	return 0;
}

-(long long)longlongObjectForKey:(id)aKey
{
    if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
        return [[self objectForKey:aKey] longLongValue];
    }
    
    return 0;
}

-(float)floatObjectForKey:(id)aKey
{
	if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
		return [[self objectForKey:aKey] floatValue];
	}
	
	return 0;
}

-(double)doubleObjectForKey:(id)aKey
{
    if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
        return [[self objectForKey:aKey] doubleValue];
    }
    
    return 0;
}

-(BOOL)boolObjectForKey:(id)aKey
{
	if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
		return [[self objectForKey:aKey] boolValue];
	}
	
	return NO;
}

-(NSDictionary *)dictionaryObjectForKey:(id)aKey{
	if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
		return (NSDictionary *)[self objectForKey:aKey];
	}
	
	return @{};
}

-(NSArray *)arrayObjectForKey:(id)aKey{
	
	if ([self checkTargetKeyIsNotNullOrNotEmpty:aKey]) {
		return (NSArray *)[self objectForKey:aKey];
	}
	
	return @[];
}

+(NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary{
	//系统自带
	
	NSError * error;
	
	NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
	
	NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	
	//自定义
	//	NSString *jsonStr = @"{";
	//	
	//	NSArray * keys = [dictionary allKeys];
	//	
	//	for (NSString * key in keys) {
	//		
	//		jsonStr = [NSString stringWithFormat:@"%@\"%@\":\"%@\",",jsonStr,key,[dictionary objectForKey:key]];
	//		
	//	}
	//	
	//	jsonStr = [NSString stringWithFormat:@"%@%@",[jsonStr substringWithRange:NSMakeRange(0, jsonStr.length-1)],@"}"];
	
	return jsonStr;
}
//json转字典
+ (NSDictionary *)convertjsonStringToDict:(NSString *)jsonString{
    
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
    
}
@end
