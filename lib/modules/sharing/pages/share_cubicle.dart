import 'dart:async';

import 'package:barcode_scan/platform_wrapper.dart';
import 'package:cubipool/models/publication.dart';
import 'package:cubipool/models/reservation.dart';
import 'package:cubipool/models/resource.dart';
import 'package:cubipool/models/sharedSpace.dart';
import 'package:cubipool/modules/learn/qr_flutter/pages/scan_page.dart';
import 'package:cubipool/services/publications/publication_http_service.dart';
import 'package:cubipool/services/resources/resources_http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';



class ShareCubiclePage extends StatefulWidget {
	static const String route = '/share';
	final Reservation reservation;
	ShareCubiclePage(this.reservation) : super();

	@override
	_ShareCubiclePage createState() => _ShareCubiclePage(this.reservation);
}

class _ShareCubiclePage extends State<ShareCubiclePage> {


	List<DateTime> startHourList = [];
	DateTime selectedStartHour;

	// Lista de horas de fin
	List<DateTime> endHourList = [];
	DateTime selectedEndHour;

	int selectedReservationHour;
	int selectedEndReservationHour;
	final List<int> hoursCountList = [1, 2];
	int selectedHoursCount = 1;
	final description = TextEditingController();
	final List<int> seatsCountList = [2, 3, 4, 5, 6];
	List<Resource> recursos=[];
	int selectedSeatsCount = 2;
	bool _loading = true;
	final  Reservation reservation;
  _ShareCubiclePage(this.reservation):super();

	DateTime selectedStartHourDateTime( int startHour) {
		var startHourDateTime = DateTime.now();
		startHourDateTime = startHourDateTime
			.add(Duration(hours: startHour - startHourDateTime.hour));
		startHourDateTime = startHourDateTime.subtract(Duration(
			minutes: startHourDateTime.minute,
			seconds: startHourDateTime.second,
			milliseconds: startHourDateTime.millisecond,
			microseconds: startHourDateTime.microsecond));
		return startHourDateTime;
	}


	@override
	void initState() {
		super.initState();
		getResources(this.reservation.cubicleId);
		initializeStartHourDropdown();
		selectedStartHour=startHourList[0];
		initializeEndHourDropdown();

		final startHours = reservationStartHoursList(	 selectedHoursCount);
		selectedReservationHour = startHours.length == 0 ? null : startHourList[0].hour;
	}
	List<int> reservationStartHoursList(int reservationHours) {
		List<int> startHoursList = [];
		final currentHour = DateTime.now().hour;
		final startHour = this.reservation.startTime.hour;
		final endHour = this.reservation.endTime.hour;
		final add = currentHour < startHour ? startHour - currentHour : 0;
		final maxHour = endHour - reservationHours;
		startHoursList = [for (var i = currentHour + add; i <= maxHour; i++) i];

		return startHoursList;
	}

	void getResources(int id) async
	{
		List<Resource> rs=new List();
		//TODO: VALIDAR LOS DATOS OBTENIDOS DE RESERVAS COMPLETADAS
		  await Future.wait([
			ResourceHttpService.getResourcesByCubicleId(id)
		])
			.then((List responses) => {
			 rs= responses.elementAt(0).map(
					 (e) => Resource.fromDTO(e)
			 ).cast<Resource>().toList()
		})
			.catchError((e) => print(e) );

		setState(() {
			recursos=rs;
			_loading = false;
		});
	}



	@override
	Widget build(BuildContext context) {
		return Container(
			child: Scaffold(
				appBar: AppBar(
					title: const Text('Compartir cubiculo'),
					centerTitle: true,
				),
				body:Center(

			child: Column(
				children: <Widget>[
					buildBooksImage(),
					buildReservationHourDropdown(),
					buildEndReservationHourDropdown(),
					buildSeatsCountDropdown(),
					resources(),
					buildDescription(),
					buildCubicleListButton(context)

				],
			),
		)));
	}

	Container buildBooksImage() {
		return Container(
			margin: const EdgeInsets.symmetric(vertical: 32.0),
			height: 120.0,
			child: Image.asset('assets/images/books.png'),
		);
	}
	bool res1= false;
	void _onRes1(bool newValue) => setState(() {
		res1 = newValue;
	});
	bool res2= false;
	void _onRes2(bool newValue) => setState(() {
		res2 = newValue;
	});
	bool res3= false;
	void _onRes3(bool newValue) => setState(() {
		res3 = newValue;
	});

	Row resources() {
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
			Checkbox(
			value: res1,
			onChanged: _onRes1
		),
						Image.asset(

							'assets/images/imac.png',
							height: 35.0,
						),
						Text('IMAC')
					],
				),
				SizedBox(width: 32.0),
				Column(

					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Checkbox(
							value: res2,
							onChanged: _onRes2
						),
						Image.asset(
							'assets/images/blackboard.png',
							height: 35.0,
						),
						Text('PIZARRA')
					],
				),
				SizedBox(width: 32.0),
				Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						Checkbox(
							value: res3,
							onChanged: _onRes3
						),
						Image.asset(
							'assets/images/smart-tv.png',
							height: 35.0,
						),
						Text('TV')
					],
				)
			],
		);
	}

	Container buildDescription()
	{
		return Container(
			width: 250.0,
		child:TextField(
				decoration: InputDecoration(
					border: OutlineInputBorder(),
					labelText: 'Descripcion',
				),
		controller: description,
		));
	}




	Container buildReservationHourDropdown() {
		return Container(
			width: 250.0,
			child: DropdownButtonFormField(
				decoration: InputDecoration(
					icon: Icon(Icons.access_time),
					hintText: 'Seleccione hora inicial para compartir',
					labelText: 'Hora de inicio'),
				value: selectedStartHour,
				onChanged: (startHour) {
					setState(() {
						selectedStartHour = startHour;
						initializeEndHourDropdown();
					});
				},
				items: startHourList
					.map((hour) => DropdownMenuItem<DateTime>(
					child: Text('${hour.hour.toString()}:${hour.minute}${hour.minute<10?"0":""} '),
					value: hour,
				))
					.toList()));
	}

	Container buildEndReservationHourDropdown() {
		return Container(
			width: 250.0,
			child: DropdownButtonFormField(
				decoration: InputDecoration(
					icon: Icon(Icons.access_time),
					hintText: 'Seleccione final para compartir',
					labelText: 'Hora final'),
				value: selectedEndReservationHour,
				onChanged: (startHour) {
					setState(() {
						selectedEndHour = startHour;
					});
				},
				items: endHourList
					.map((hour) => DropdownMenuItem<DateTime>(
					child: Text('${hour.hour.toString()}:${hour.minute}${hour.minute<10?"0":""} '),
					value: hour,
				))
					.toList()));
	}

	Future initializeStartHourDropdown() async {
		var now = reservation.startTime;
		var minutes = (now.minute < 30) ? 0 : 30;

		var timeIterator =
		DateTime(now.year, now.month, now.day, now.hour, minutes);

		var counter = (minutes == 0) ? 4 : 3;

		startHourList =
			generateDateTimeList(timeIterator, counter, Duration(minutes: 30));
	}
	List<DateTime> generateDateTimeList(
		DateTime startTime, int count, Duration duration) {
		var iterator = startTime;
		var result = List<DateTime>();

		for (var i = 0; i < count; ++i) {
			result.add(iterator);
			iterator = iterator.add(duration);
		}
		return result;
	}
	Future initializeEndHourDropdown() async {
		var iterator = selectedStartHour.add(Duration(minutes: 30));

		endHourList = List<DateTime>();
		for (var item in startHourList) {
			if (item
				.difference(iterator)
				.inMinutes >= 0) {
				endHourList.add(item);
			}
		}
	}

	Container buildSeatsCountDropdown() {
		return Container(
			width: 250.0,
			child: DropdownButtonFormField(
				decoration: InputDecoration(
					icon: Icon(Icons.event_seat),
					hintText: 'Seleccione la cantidad de asientos',
					labelText: 'Cantidad de asientos'),
				value: selectedSeatsCount,
				onChanged: (reservationSeats) {
					setState(() {
						selectedSeatsCount = reservationSeats;
					});
				},
				items: seatsCountList
					.map((reservationSeats) => DropdownMenuItem(
					child: Text(reservationSeats.toString()),
					value: reservationSeats,
				))
					.toList(),
			));
	}

	Builder buildCubicleListButton(BuildContext ctx)  {

		return Builder(
			builder: (ctx)=>
			RaisedButton(
			child: Text(
				'Compartir',
				style: TextStyle(color: Colors.white),
			),
			color: Colors.red,
			onPressed: () async {
				final startHourDateTime = selectedStartHour;
			  final endHourDateTime=selectedEndHour;
				Publication publication=new Publication(null, startHourDateTime, endHourDateTime, selectedSeatsCount, this.reservation.id,description.text);

				int libres=selectedSeatsCount-(this.res1==true?1:0)-(this.res2==true?1:0)- (this.res3==true?1:0);
				publication.sharedSpaces=new List<SharedSpace>();
				for(int i=0;i<libres;i++)
					{
						SharedSpace ss=new SharedSpace(startHourDateTime, endHourDateTime, null);
						publication.sharedSpaces.add(ss);
					}
				if(res1)
					{
						SharedSpace ss=new SharedSpace(startHourDateTime, endHourDateTime,this.recursos[0].id);
						publication.sharedSpaces.add(ss);
					}
				if(res2)
				{
					SharedSpace ss=new SharedSpace(startHourDateTime, endHourDateTime,this.recursos[1].id);
					publication.sharedSpaces.add(ss);
				}
				if(res3)
				{
					SharedSpace ss=new SharedSpace(startHourDateTime, endHourDateTime,this.recursos[2].id);
					publication.sharedSpaces.add(ss);
				}
					try{
					await handleShareButton(publication);
					showSnackBar(ctx, 'Compartido 🎉');
					}catch(e)
				{
					showSnackBar(ctx, 'Hubo un error al compartir');
				}

				},
		)
		);
	}

	Future handleShareButton(Publication publication) async{
		await PublicationsHttpService.postPublication(publication);

	}

	void showSnackBar(BuildContext context, String text) {
		Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
	}
}
