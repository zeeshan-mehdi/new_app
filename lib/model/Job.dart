

class Job{
  String title;
  String description;
  String budget;
  String time;
  String fileUrl;
  String category;

  String agency;
  String location;
  String jobId;
  String details;

  bool saved = false;
  Job(this.title, this.description, this.budget, this.time, this.fileUrl,
      this.agency,this.category,this.location,this.details,{this.jobId});

  toJson(){
    return {
      "title":title,
      "description":description,
      "budget":budget,
      "time":time,
      "fileUrl":fileUrl,
      "agency":agency,
      "category":category,
      "location":location,
      "details":details,
      "saved":saved
    };
  }

  Job.fromJson(job){
    this.title=job['title'];
    this.description=job['description'];
    this.budget=job['budget'];
    this.time=job['time'];
    this.fileUrl=job['fileUrl'];
    this.agency=job['agency'];
    this.category=job['category'];
    this.location=job['location'];
    this.details=job['details'];
    this.saved=job['saved'];
  }


}