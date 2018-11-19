//
//  NSDictionary+ExceptionUtil.h
//  CDCloud
//
//  Created by Ronnie Chen on 16/7/22.
//  Copyright © 2016年 云武华科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(ExceptionUtil)

-(NSString *)stringObjectForKey:(id)aKey;

-(int)intObjectForKey:(id)aKey;

-(long)longObjectForKey:(id)aKey;

-(long long)longlongObjectForKey:(id)aKey;

-(float)floatObjectForKey:(id)aKey;

-(double)doubleObjectForKey:(id)aKey;

-(BOOL)boolObjectForKey:(id)aKey;

-(NSDictionary *)dictionaryObjectForKey:(id)aKey;

-(NSArray *)arrayObjectForKey:(id)aKey;

+(NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;
//json转字典
+ (NSDictionary *)convertjsonStringToDict:(NSString *)jsonString;
@end
