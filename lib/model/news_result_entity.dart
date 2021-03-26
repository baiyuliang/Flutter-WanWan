import 'package:wanwan/generated/json/base/json_convert_content.dart';
import 'package:wanwan/generated/json/base/json_field.dart';

class NewsResultEntity with JsonConvert<NewsResultEntity> {
	String stat;
	List<NewsResultData> data;
	String page;
	String pageSize;
}

class NewsResultData with JsonConvert<NewsResultData> {
	String uniquekey;
	String title;
	String date;
	String category;
	@JSONField(name: "author_name")
	String authorName;
	String url;
	@JSONField(name: "thumbnail_pic_s")
	String thumbnailPicS;
	@JSONField(name: "thumbnail_pic_s02")
	String thumbnailPicS02;
	@JSONField(name: "thumbnail_pic_s03")
	String thumbnailPicS03;
	@JSONField(name: "is_content")
	String isContent;
}
