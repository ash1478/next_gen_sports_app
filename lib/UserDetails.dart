class UserDetails {
  String name,email,dob,phone,uid;
  int slotCount;

  void getDetails(name,email,dob,phone,count){
    this.name = name;
    this.email = email;
    this.dob = dob;
    this.phone = phone;
    this.slotCount = count;
  }

  toJson(){
    return {
      'Name' : name,
      'Email' : email,
      'DOB' : dob,
      'Uid' : uid,
      'Phone' : phone,
      'Count' : 0,
    };
  }

  toJsonList(){
    return {
      'Name' : name,
      'Email' : email,
      'Uid' : uid,
      'Phone' : phone,
      'Count' : 0,
    };
  }
  toJsonDOB(){
    return {
      'DOB' : dob,
    };
  }
}