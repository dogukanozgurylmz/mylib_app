import 'package:flutter/material.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({super.key});

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pageCountController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String _selectedLibrary = "Library 1";

  List<String> _libraries = ['Library 1', 'Library 2', 'Library 3'];

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pageCountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form validation successful, process the data
      String title = _titleController.text;
      String author = _authorController.text;
      int pageCount = int.parse(_pageCountController.text);

      // Do something with the form data (e.g., save to database)
      // ...

      // Clear the form fields
      _titleController.clear();
      _authorController.clear();
      _pageCountController.clear();
      _startDate = DateTime.now();
      _endDate = DateTime.now();
      _selectedLibrary = "Library 1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap ekle'),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Kitabın adı',
                  labelStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Color(0xFF273043)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: 'Yazarı',
                  labelStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Color(0xFF273043)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _pageCountController,
                decoration: InputDecoration(
                  labelText: 'Kaç sayfa',
                  labelStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Color(0xFF273043)),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a page count';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              InkWell(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    if (selectedDate != null) {
                      _startDate = selectedDate;
                    } else {
                      _startDate = DateTime.now();
                    }
                  });
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Başlangıç tarihi',
                    labelStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Color(0xFF273043)),
                    ),
                  ),
                  child: Text(
                    _startDate != null
                        ? '${_startDate.day}/${_startDate.month}/${_startDate.year}'
                        : 'Select a date',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              InkWell(
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    if (selectedDate != null) {
                      _endDate = selectedDate;
                    } else {
                      _endDate = DateTime.now();
                    }
                  });
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Bitireceğin tarih',
                    labelStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(color: Color(0xFF273043)),
                    ),
                  ),
                  child: Text(
                    _endDate != null
                        ? '${_endDate.day}/${_endDate.month}/${_endDate.year}'
                        : 'Select a date',
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedLibrary,
                items: _libraries.map((library) {
                  return DropdownMenuItem<String>(
                    value: library,
                    child: Text(library),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Kütüphane seç',
                  labelStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(45),
                    borderSide: const BorderSide(color: Color(0xFF273043)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedLibrary = value!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a library';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff273043),
                  ),
                ),
                child: Text(
                  'Ekle',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
