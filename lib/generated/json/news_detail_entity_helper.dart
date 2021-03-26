import 'package:wanwan/model/news_detail_entity.dart';

newsDetailEntityFromJson(NewsDetailEntity data, Map<String, dynamic> json) {
	if (json['uniquekey'] != null) {
		data.uniquekey = json['uniquekey'].toString();
	}
	if (json['detail'] != null) {
		data.detail = NewsDetailDetail().fromJson(json['detail']);
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	return data;
}

Map<String, dynamic> newsDetailEntityToJson(NewsDetailEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uniquekey'] = entity.uniquekey;
	data['detail'] = entity.detail?.toJson();
	data['content'] = entity.content;
	return data;
}

newsDetailDetailFromJson(NewsDetailDetail data, Map<String, dynamic> json) {
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['date'] != null) {
		data.date = json['date'].toString();
	}
	if (json['category'] != null) {
		data.category = json['category'].toString();
	}
	if (json['author_name'] != null) {
		data.authorName = json['author_name'].toString();
	}
	if (json['url'] != null) {
		data.url = json['url'].toString();
	}
	if (json['thumbnail_pic_s'] != null) {
		data.thumbnailPicS = json['thumbnail_pic_s'].toString();
	}
	if (json['thumbnail_pic_s02'] != null) {
		data.thumbnailPicS02 = json['thumbnail_pic_s02'].toString();
	}
	if (json['thumbnail_pic_s03'] != null) {
		data.thumbnailPicS03 = json['thumbnail_pic_s03'].toString();
	}
	return data;
}

Map<String, dynamic> newsDetailDetailToJson(NewsDetailDetail entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['title'] = entity.title;
	data['date'] = entity.date;
	data['category'] = entity.category;
	data['author_name'] = entity.authorName;
	data['url'] = entity.url;
	data['thumbnail_pic_s'] = entity.thumbnailPicS;
	data['thumbnail_pic_s02'] = entity.thumbnailPicS02;
	data['thumbnail_pic_s03'] = entity.thumbnailPicS03;
	return data;
}