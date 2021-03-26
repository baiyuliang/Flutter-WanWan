// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:wanwan/model/news_detail_entity.dart';
import 'package:wanwan/generated/json/news_detail_entity_helper.dart';
import 'package:wanwan/model/news_result_entity.dart';
import 'package:wanwan/generated/json/news_result_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case NewsDetailEntity:
				return newsDetailEntityFromJson(data as NewsDetailEntity, json) as T;
			case NewsDetailDetail:
				return newsDetailDetailFromJson(data as NewsDetailDetail, json) as T;
			case NewsResultEntity:
				return newsResultEntityFromJson(data as NewsResultEntity, json) as T;
			case NewsResultData:
				return newsResultDataFromJson(data as NewsResultData, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case NewsDetailEntity:
				return newsDetailEntityToJson(data as NewsDetailEntity);
			case NewsDetailDetail:
				return newsDetailDetailToJson(data as NewsDetailDetail);
			case NewsResultEntity:
				return newsResultEntityToJson(data as NewsResultEntity);
			case NewsResultData:
				return newsResultDataToJson(data as NewsResultData);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (NewsDetailEntity).toString()){
			return NewsDetailEntity().fromJson(json);
		}	else if(type == (NewsDetailDetail).toString()){
			return NewsDetailDetail().fromJson(json);
		}	else if(type == (NewsResultEntity).toString()){
			return NewsResultEntity().fromJson(json);
		}	else if(type == (NewsResultData).toString()){
			return NewsResultData().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<NewsDetailEntity>[] is M){
			return data.map<NewsDetailEntity>((e) => NewsDetailEntity().fromJson(e)).toList() as M;
		}	else if(<NewsDetailDetail>[] is M){
			return data.map<NewsDetailDetail>((e) => NewsDetailDetail().fromJson(e)).toList() as M;
		}	else if(<NewsResultEntity>[] is M){
			return data.map<NewsResultEntity>((e) => NewsResultEntity().fromJson(e)).toList() as M;
		}	else if(<NewsResultData>[] is M){
			return data.map<NewsResultData>((e) => NewsResultData().fromJson(e)).toList() as M;
		}
		throw Exception("not fond");
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}