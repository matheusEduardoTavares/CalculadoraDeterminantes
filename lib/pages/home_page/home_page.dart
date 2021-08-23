import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  static final a11 = ValueNotifier<int>(0);
  static final a12 = ValueNotifier<int>(0);
  static final a13 = ValueNotifier<int>(0);
  static final a21 = ValueNotifier<int>(0);
  static final a22 = ValueNotifier<int>(0);
  static final a23 = ValueNotifier<int>(0);
  static final a31 = ValueNotifier<int>(0);
  static final a32 = ValueNotifier<int>(0);
  static final a33 = ValueNotifier<int>(0);
  static final is3x3 = ValueNotifier<bool>(false);

  String get _qty => is3x3.value ? '3x3' : '2x2';
  static String get invertedQty => is3x3.value ? '2x2' : '3x3';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: is3x3,
          builder: (_, __, ___) => Text('Calcular determinante $_qty'),
        ),
        actions: [
          TextButton(
            child: ValueListenableBuilder(
                valueListenable: is3x3,
                builder: (_, __, ___) => Text(
                invertedQty,
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () {
              is3x3.value = !is3x3.value;
            },
          ),
        ],
      ),
      body: const MyStatelessWidget(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({
    Key key,
  }) : super(key: key);

  String _validateInt(String value) {
    if (int.tryParse(value) != null) {
      return null;
    }

    return 'Apenas inteiros';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ValueListenableBuilder(
              valueListenable: HomePage.is3x3,
              builder: (_, __, ___) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Coluna 1',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Coluna 2',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    if (HomePage.is3x3.value)
                      DataColumn(
                        label: Text(
                          'Coluna 3',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                  ],
                  rows: <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value) {
                              if (int.tryParse(value) != null) {
                                HomePage.a11.value = int.parse(value);
                              }
                            },
                            validator: _validateInt,
                          ),
                        ),
                        DataCell(Text('19')),
                        if (HomePage.is3x3.value)
                          DataCell(Text('Student')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Janine')),
                        DataCell(Text('43')),
                        if (HomePage.is3x3.value)
                          DataCell(Text('Professor')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('William')),
                        DataCell(Text('27')),
                        if (HomePage.is3x3.value)
                          DataCell(Text('Associate Professor')),
                      ],
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}