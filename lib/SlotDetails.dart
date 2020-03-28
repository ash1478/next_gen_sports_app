

class SlotDetails {

  String time,month,status,bookingID,session,date;
  int cost,day,year,index;

 void getDetails(time,int day,month,year,status,bookingID,session,int cost,int index){
     this.time = time ;
     this.day = day;
     this.month = month;
     this.year = year;
     this.status = status;
     this.bookingID = bookingID;
     this.session = session;
     this.cost = cost;
     this.index = index;
  }
  void getDetails2(time,date,status,bookingID,session,int cost,int index){
    this.time = time ;
    this.date = date;
    this.status = status;
    this.bookingID = bookingID;
    this.session = session;
    this.cost = cost;
    this.index = index;
  }
  void getDetails3(SlotDetails slot){
    this.time = slot.time ;
    this.bookingID = slot.bookingID;
    this.session = slot.session;
    this.index = slot.index;
  }
  toJson(){
   return {
     "Time" : time,
     "Date" : date,
     "Status" : status,
     "BookingId" : bookingID,
     "Session" : session,
     "Cost" : cost,
     "Index" : index,
   };
  }

}