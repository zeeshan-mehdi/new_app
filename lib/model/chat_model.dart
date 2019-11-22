

class Chat{
  String from;
  String to;

  String name;
  String photoUrl;

  Chat(this.from, this.to, this.name, this.photoUrl);


  toJson(){
    return {
      "from":from,
      "to":to,
      "name":name,
      "photoUrl":photoUrl
    };
  }

  Chat.fromJson(chat){
    this.from = chat['from'];
    this.to = chat['to'];
    this.name = chat['name'];
    this.photoUrl = chat['photoUrl'];
  }

}