import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'src/theme.dart';
import 'package:tugas_3_pbm/src/api.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({super.key});

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  var doctorList = [];
  var _loading = true;

  Future<void> getDoctorList() async {
    try {
      var data = await Repository().loadDoctorsList();
      setState(() {
        doctorList = data.toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      _showErrorToast(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      getDoctorList();
      return Container(
        color: ZTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: SpinKitCubeGrid(
              color: ZTheme.of(context).primary,
              size: 50.0,
            ),
          ),
        ),
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: doctorList.length,
        itemBuilder: (context, doctorListIndex) {
          final doctorListItem = doctorList[doctorListIndex];
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: ZTheme.of(context).secondaryBackground,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        doctorListItem['img_url'].toString(),
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5.0, 0.0, 5.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: Text(
                                doctorListItem["name"].toString(),
                                style: ZTheme.of(context).titleMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 3.0, 0.0, 0.0),
                              child: Text(
                                '${doctorListItem["specialist"]} • ${doctorListItem["city"]}',
                                style: ZTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Poppins',
                                      color: ZTheme.of(context).secondaryText,
                                    ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                    child: RatingBarIndicator(
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star_rounded,
                                        color: ZTheme.of(context).secondary,
                                      ),
                                      direction: Axis.horizontal,
                                      rating: double.parse(
                                          doctorListItem["rating"].toString()),
                                      unratedColor: ZTheme.of(context).accent,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void _showErrorToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Failed to load data'),
        action: SnackBarAction(
            label: 'RETRY', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
