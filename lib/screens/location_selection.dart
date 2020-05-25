import 'package:Borhan_User/screens/location_selection_input.dart';
import 'package:flutter/material.dart';

class LocationSelection extends StatefulWidget {
  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {

String _address;
String _buildingNo;
String _addressName;
String _floorNo;
String _apartmentNo;
String _uniqueSign;

final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();

Widget _buildAddress(){
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'اسم الشارع ورقم المبنى',
      labelText: 'العنوان'
    ),
    
    validator: (String value){
      if(value.isEmpty){
        return 'الحقل مطلوب';
      }
    },
    onSaved: (String value){
      _address = value;
    },
  );
}

Widget _buildBuildingNo(){
   return TextFormField(
     keyboardType: TextInputType.number,
    decoration: InputDecoration(
      
      hintText: 'رقم',
      labelText: 'رقم المبنى / فيلا'
    ),
    
    validator: (String value){
      if(value.isEmpty){
        return 'الحقل مطلوب';
      }
    },
    onSaved: (String value){
      _addressName = value;
    },
  );
}
Widget _buildAddressName(){
  return TextFormField(
    decoration: InputDecoration(
      hintText: ' مثلا :المنزل، العمل، الخ',
      labelText: 'اسم العنوان',
    ),
    
    validator: (String value){
      if(value.isEmpty){
        return 'الحقل مطلوب';
      }
    },
    onSaved: (String value){
      _buildingNo = value;
    },
  );
}
Widget _buildFloorNo(){
 return TextFormField(
   keyboardType: TextInputType.number,
    decoration: InputDecoration(
      
      hintText: 'رقم',
      labelText: 'رقم الطابق',
    ),
    
    validator: (String value){
      if(value.isEmpty){
        return 'الحقل مطلوب';
      }
    },
    onSaved: (String value){
      _floorNo = value;
    },
  );
}
Widget _buildApartmentNo(){
  
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: 'رقم',
      labelText: 'رقم الشقة',
    ),
    
    validator: (String value){
      if(value.isEmpty){
        return 'الحقل مطلوب';
      }
    },
    onSaved: (String value){
      _apartmentNo = value;
    },
  );
}
Widget _buildUniqueSign(){
  return TextFormField(
    decoration: InputDecoration(
      hintText: 'ميز عنوانك بعلامة',
      labelText: 'علامة مميزة',
    ),
    
    validator: (String value){
      if(value.isEmpty){
        return 'الحقل مطلوب';
      }
    },
    onSaved: (String value){
      _uniqueSign = value;
    },
  );
}
  @override
  Widget build(BuildContext context) {

       return Scaffold(
      appBar: AppBar(
        centerTitle: true ,
        title: Text("اضافة عنوان التوصيل")
        ,
        
      ),
      body: SingleChildScrollView(
              child: Container(
          margin: EdgeInsets.all(18),
          child: Form(
            key: _addressKey,
            child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildAddress(),
              Row(
                
                children: <Widget>[
                    
                Expanded(child: _buildBuildingNo()),
                SizedBox(
                  width: 12,
                ),
                Expanded(child: _buildAddressName())
              ],
              )
              ,
              Row(children: <Widget>[
                Expanded(child: _buildFloorNo()),
                SizedBox(
                  width: 12,
                ),
                Expanded(child: _buildApartmentNo())

              ],)
              ,
              _buildUniqueSign(),
              SizedBox(
                height: 32,
              )  ,
              
              LocationSelectionInput(),
              RaisedButton(
                onPressed: (){
                if(!_addressKey.currentState.validate()) {
    return;
                }
                
                _addressKey.currentState.save();

// print(_address);
// print(_buildingNo);
// print(_addressName);
// print(_floorNo);
// print(_apartmentNo);
// print(_uniqueSign);

              }
  
              ,
              
              child: Text("Submit"),
              )
              
            ],
          ),
        ),
        ),
      ),
      
      
    );
    
  }
}


