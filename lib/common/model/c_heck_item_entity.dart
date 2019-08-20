class CHeckItemEntity {
	String name;
	int id;
	String content;

	CHeckItemEntity({this.name, this.id, this.content});

	CHeckItemEntity.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		data['content'] = this.content;
		return data;
	}
}
