import 'package:flutter/material.dart';
import 'package:foodpanda_users_app/assistantMethods/address_changer.dart';
import 'package:foodpanda_users_app/mainScreens/placed_order_screen.dart';
import 'package:foodpanda_users_app/maps/maps.dart';
import 'package:foodpanda_users_app/models/address.dart';
import 'package:provider/provider.dart';


class AddressDesign extends StatefulWidget
{

  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;

  AddressDesign({
    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.sellerUID,
});

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign>
{
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        // select this address
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);

      },
      child: Column(
        children: [

          // address info
          Row(

            children: [
              Radio(
                groupValue: widget.currentIndex!,
                value: widget.value!,
                activeColor: Colors.amber,
                onChanged: (val)
                {
                  // provider
                  Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                  print(val);
                },
              ),
              Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text(
                               "Tên khách hàng: ",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model!.name.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Số điện thoại: ",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model!.phoneNumber.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Số nhà: ",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model!.flatNumber.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Thành phố: ",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model!.city.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Quốc gia: ",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model!.state.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              "Địa chỉ đầy đủ: ",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model!.fullAddress.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),


          // button
          ElevatedButton(
            child: const Text("Kiểm tra trên map"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black54,
            ),
            onPressed: ()
            {
              //MapsUtils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);

              MapsUtils.openMapWithAddress(widget.model!.fullAddress!);

            },

          ),


          // button
          widget.value == Provider.of<AddressChanger>(context).count
              ? ElevatedButton(
                    child:  Text("Hoàn thành"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: ()
                    {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (c)=> PlacedOrderScreen(
                            addressID: widget.addressID,
                            totalAmount: widget.totalAmount,
                            sellerUID: widget.sellerUID,
                          )
                      )
                      );
                    },
                )
              : Container(),

        ],
      ),
    );
  }
}
